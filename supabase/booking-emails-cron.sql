-- ═══════════════════════════════════════════════════════════════
-- EMAIL TỰ ĐỘNG THEO LỊCH (pg_cron): NHẮC CỌC + E-VOUCHER
-- Chạy trong Supabase → SQL Editor. Idempotent — chạy lại không sao.
--
-- 1) Nhắc thanh toán cọc: đơn payment_status='PENDING' quá 24h
--    (tối đa 7 ngày, chưa hủy), nhắc ĐÚNG 1 LẦN, chỉ gửi 8h–20h giờ VN.
--    Cron: mỗi giờ phút 15.
-- 2) E-voucher: đơn CONFIRMED + payment SUCCESS có lịch khởi hành
--    trong vòng 2 ngày tới (khớp lời hứa "48 tiếng trước ngày đi").
--    Cron: mỗi giờ 8:45–19:45 VN, tối đa 2 email/lượt (tránh 429 Resend).
--
-- Cả 2 đọc Resend API key từ Vault ('resend_api_key') — không có key
-- thì thoát êm. Cột *_sent_at chống gửi trùng.
-- ═══════════════════════════════════════════════════════════════

create extension if not exists pg_cron;

alter table public.bookings add column if not exists deposit_reminder_sent_at timestamptz;
alter table public.bookings add column if not exists voucher_sent_at          timestamptz;

-- ── 1. NHẮC THANH TOÁN CỌC ─────────────────────────────────────
create or replace function public.send_deposit_reminders()
returns void
language plpgsql
security definer
set search_path = public
as $fn$
declare
  v_key text;
  r     record;
begin
  select decrypted_secret into v_key from vault.decrypted_secrets where name = 'resend_api_key' limit 1;
  if v_key is null then
    raise warning 'send_deposit_reminders: chua co resend_api_key trong Vault';
    return;
  end if;

  -- Chỉ gửi trong khung 8h–20h giờ VN cho lịch sự
  if extract(hour from now() at time zone 'Asia/Ho_Chi_Minh') not between 8 and 19 then
    return;
  end if;

  for r in
    select b.id, b.booking_ref, b.guest_name, b.guest_email, b.deposit_amount, t.name_vi as tour_name
    from bookings b
    join tours t on t.id = b.tour_id
    where b.payment_status = 'PENDING'
      and b.status in ('PENDING','CONFIRMED')
      and b.deposit_reminder_sent_at is null
      and b.guest_email is not null and position('@' in b.guest_email) > 1
      and b.created_at < now() - interval '24 hours'
      and b.created_at > now() - interval '7 days'
    limit 2 -- Resend free = 2 req/giây; gửi ít mỗi lượt, cron chạy dày để bù
  loop
    perform net.http_post(
      url     := 'https://api.resend.com/emails',
      headers := jsonb_build_object('Authorization', 'Bearer ' || v_key, 'Content-Type', 'application/json'),
      body := jsonb_build_object(
        'from',     'Baggio Travel <booking@baggio.website>',
        'to',       jsonb_build_array(r.guest_email),
        'reply_to', 'thanhphathung@gmail.com',
        'subject',  'Nhắc thanh toán cọc — đơn ' || r.booking_ref || ' đang chờ giữ chỗ',
        'html',
          '<div style="font-family:Arial,Helvetica,sans-serif;max-width:560px;margin:0 auto;color:#1a1712;line-height:1.6">'
          || '<h2 style="color:#c5372b;margin-bottom:0">Baggio<span style="color:#1a1712">.</span>Travel</h2>'
          || '<p style="font-size:15px">Chào <b>' || replace(replace(replace(coalesce(r.guest_name,'bạn'),'&','&amp;'),'<','&lt;'),'>','&gt;') || '</b>,</p>'
          || '<p>Đơn đặt tour <b>' || r.booking_ref || '</b> (' || coalesce(r.tour_name,'') || ') của bạn vẫn đang <b>chờ thanh toán cọc</b>. Chỗ chỉ được giữ chắc chắn sau khi nhận cọc:</p>'
          || '<p style="font-size:20px;color:#c5372b;font-weight:bold">' || to_char(coalesce(r.deposit_amount,0),'FM999,999,999') || 'đ</p>'
          || '<div style="background:#faf8f3;border:1px solid #e8e3d8;padding:14px 16px;font-size:14px">'
          || 'Ngân hàng: <b>Techcombank</b><br>'
          || 'Số tài khoản: <b>4042828666</b><br>'
          || 'Chủ tài khoản: <b>TRAN HUNG VI</b><br>'
          || 'Nội dung chuyển khoản: <b>' || r.booking_ref || '</b>'
          || '</div>'
          || '<p style="font-size:14px">Nếu bạn ĐÃ chuyển khoản, vui lòng bỏ qua email này hoặc nhắn <a href="https://zalo.me/0906306286">Zalo 0906 306 286</a> kèm ảnh chụp giao dịch để được xác nhận ngay. Cần đổi lịch hay hủy? Xem <a href="https://baggio.website/chinh-sach">chính sách hoàn hủy</a>.</p>'
          || '<p style="font-size:13px;color:#8a8578">Baggio Travel · Hotline/Zalo: 0906 306 286</p>'
          || '</div>'
      )
    );
    update bookings set deposit_reminder_sent_at = now() where id = r.id;
  end loop;
end $fn$;

-- ── 2. E-VOUCHER TRƯỚC NGÀY KHỞI HÀNH ──────────────────────────
create or replace function public.send_evouchers()
returns void
language plpgsql
security definer
set search_path = public
as $fn$
declare
  v_key text;
  r     record;
begin
  select decrypted_secret into v_key from vault.decrypted_secrets where name = 'resend_api_key' limit 1;
  if v_key is null then
    raise warning 'send_evouchers: chua co resend_api_key trong Vault';
    return;
  end if;

  for r in
    select b.id, b.booking_ref, b.guest_name, b.guest_email,
           b.adult_count, b.child_count, b.infant_count,
           t.name_vi as tour_name, t.destination,
           s.depart_date, s.return_date,
           g.full_name as guide_name, g.phone as guide_phone
    from bookings b
    join tours t on t.id = b.tour_id
    join tour_schedules s on s.id = b.schedule_id
    left join guides g on g.id = b.guide_id
    where b.status = 'CONFIRMED'
      and b.payment_status = 'SUCCESS'
      and b.voucher_sent_at is null
      and b.guest_email is not null and position('@' in b.guest_email) > 1
      and s.depart_date between (now() at time zone 'Asia/Ho_Chi_Minh')::date
                             and (now() at time zone 'Asia/Ho_Chi_Minh')::date + 2
    limit 2 -- Resend free = 2 req/giây; gửi ít mỗi lượt, cron chạy dày để bù
  loop
    perform net.http_post(
      url     := 'https://api.resend.com/emails',
      headers := jsonb_build_object('Authorization', 'Bearer ' || v_key, 'Content-Type', 'application/json'),
      body := jsonb_build_object(
        'from',     'Baggio Travel <booking@baggio.website>',
        'to',       jsonb_build_array(r.guest_email),
        'reply_to', 'thanhphathung@gmail.com',
        'subject',  '🎫 E-Voucher ' || r.booking_ref || ' — ' || coalesce(r.tour_name,'') || ' khởi hành ' || to_char(r.depart_date,'DD/MM/YYYY'),
        'html',
          '<div style="font-family:Arial,Helvetica,sans-serif;max-width:560px;margin:0 auto;color:#1a1712;line-height:1.6">'
          || '<h2 style="color:#c5372b;margin-bottom:0">Baggio<span style="color:#1a1712">.</span>Travel</h2>'
          || '<p style="font-size:15px">Chào <b>' || replace(replace(replace(coalesce(r.guest_name,'bạn'),'&','&amp;'),'<','&lt;'),'>','&gt;') || '</b>, chuyến đi của bạn sắp bắt đầu! Đây là e-voucher chính thức:</p>'
          || '<div style="border:2px solid #c5372b;padding:18px 20px;text-align:center;margin:12px 0">'
          || '<div style="font-size:12px;letter-spacing:2px;color:#8a8578">E-VOUCHER</div>'
          || '<div style="font-size:26px;font-weight:bold;letter-spacing:2px;margin:6px 0">' || r.booking_ref || '</div>'
          || '<div style="font-size:15px;font-weight:bold">' || coalesce(r.tour_name,'') || '</div>'
          || '</div>'
          || '<table style="width:100%;border-collapse:collapse;font-size:14px;margin:12px 0">'
          || '<tr><td style="padding:6px 0;color:#8a8578">Khởi hành</td><td style="padding:6px 0"><b>' || to_char(r.depart_date,'DD/MM/YYYY') || '</b></td></tr>'
          || case when r.return_date is not null then '<tr><td style="padding:6px 0;color:#8a8578">Ngày về</td><td style="padding:6px 0">' || to_char(r.return_date,'DD/MM/YYYY') || '</td></tr>' else '' end
          || '<tr><td style="padding:6px 0;color:#8a8578">Số khách</td><td style="padding:6px 0">' || r.adult_count || ' người lớn'
          ||   case when coalesce(r.child_count,0)  > 0 then ', ' || r.child_count  || ' trẻ em' else '' end
          ||   case when coalesce(r.infant_count,0) > 0 then ', ' || r.infant_count || ' em bé'  else '' end || '</td></tr>'
          || case when r.guide_name is not null then '<tr><td style="padding:6px 0;color:#8a8578">Hướng dẫn viên</td><td style="padding:6px 0"><b>' || r.guide_name || '</b>' || coalesce(' — ' || r.guide_phone,'') || '</td></tr>' else '' end
          || '</table>'
          || '<p style="font-size:14px"><b>Vui lòng xuất trình email này</b> (hoặc đọc mã đơn) khi gặp hướng dẫn viên. Chi tiết giờ đón và điểm tập trung sẽ được HDV/tư vấn viên liên hệ xác nhận trước giờ khởi hành.</p>'
          || '<p style="font-size:14px">Cần hỗ trợ gấp: gọi/nhắn <a href="https://zalo.me/0906306286">Zalo 0906 306 286</a>.</p>'
          || '<p style="font-size:13px;color:#8a8578">Chúc bạn có chuyến đi tuyệt vời! — Baggio Travel</p>'
          || '</div>'
      )
    );
    update bookings set voucher_sent_at = now() where id = r.id;
  end loop;
end $fn$;

-- ── 3. LỊCH CHẠY (gỡ job cũ nếu có rồi tạo lại) ────────────────
do $sched$
begin
  begin perform cron.unschedule('baggio-deposit-reminders'); exception when others then null; end;
  begin perform cron.unschedule('baggio-evouchers');         exception when others then null; end;
end $sched$;

select cron.schedule('baggio-deposit-reminders', '15 * * * *',    'select public.send_deposit_reminders()');
select cron.schedule('baggio-evouchers',         '45 1-12 * * *', 'select public.send_evouchers()'); -- mỗi giờ 8:45–19:45 VN, 2 email/lượt

-- ── 4. KIỂM TRA ────────────────────────────────────────────────
select jobname, schedule, active from cron.job where jobname like 'baggio-%' order by jobname;
