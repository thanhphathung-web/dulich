-- ═══════════════════════════════════════════════════════════════
-- KÊNH 2: EMAIL XÁC NHẬN ĐẶT TOUR CHO KHÁCH (Resend)
-- Vá function notify_new_booking TẠI CHỖ (không tạo lại từ file cũ)
-- để giữ nguyên topic ntfy bí mật đang chạy trên production.
--
-- YÊU CẦU TRƯỚC KHI EMAIL HOẠT ĐỘNG:
--   1) Domain baggio.website đã verify trong Resend (DNS trên Vercel).
--   2) API key nằm trong Vault với tên 'resend_api_key' — CHỦ SHOP tự chạy:
--      select vault.create_secret('<RESEND_API_KEY>', 'resend_api_key');
--      (KHÔNG commit key; nếu chưa có key, function vẫn chạy — chỉ bỏ qua email.)
--
-- An toàn: chạy lại nhiều lần không sao (tự phát hiện đã vá thì bỏ qua).
-- Mọi lỗi gửi email bị nuốt bởi exception handler sẵn có — không chặn booking.
-- ═══════════════════════════════════════════════════════════════

do $migrate$
declare
  def    text;
  eb     text;
  anchor text;
begin
  def := pg_get_functiondef('public.notify_new_booking()'::regprocedure);

  if position('api.resend.com' in def) > 0 then
    raise notice 'Email block da co san — bo qua.';
    return;
  end if;

  -- Body trên production dùng CRLF (chạy từ Windows) — thử cả 2 kiểu xuống dòng
  if position(E'\r\n  return new;\r\nexception when others then' in def) > 0 then
    anchor := E'\r\n  return new;\r\nexception when others then';
  elsif position(E'\n  return new;\nexception when others then' in def) > 0 then
    anchor := E'\n  return new;\nexception when others then';
  else
    raise exception 'Khong tim thay anchor "return new; exception" — function da bi sua khac cau truc, can va tay.';
  end if;

  eb := $eb$
  -- ── Kênh 2: email xác nhận cho khách qua Resend ──
  -- Key đọc từ Vault ('resend_api_key'); chưa có key thì bỏ qua êm.
  if new.guest_email is not null and position('@' in new.guest_email) > 1
     and exists (select 1 from vault.decrypted_secrets where name = 'resend_api_key') then
    perform net.http_post(
      url     := 'https://api.resend.com/emails',
      headers := jsonb_build_object(
        'Authorization', 'Bearer ' || (select decrypted_secret from vault.decrypted_secrets where name = 'resend_api_key' limit 1),
        'Content-Type',  'application/json'
      ),
      body := jsonb_build_object(
        'from',     'Baggio Travel <booking@baggio.website>',
        'to',       jsonb_build_array(new.guest_email),
        'reply_to', 'thanhphathung@gmail.com',
        'subject',  'Xác nhận đặt tour ' || new.booking_ref || ' — Baggio Travel',
        'html',
          '<div style="font-family:Arial,Helvetica,sans-serif;max-width:560px;margin:0 auto;color:#1a1712;line-height:1.6">'
          || '<h2 style="color:#c5372b;margin-bottom:0">Baggio<span style="color:#1a1712">.</span>Travel</h2>'
          || '<p style="font-size:15px">Chào <b>' || replace(replace(replace(coalesce(new.guest_name,'bạn'),'&','&amp;'),'<','&lt;'),'>','&gt;') || '</b>,</p>'
          || '<p>Chúng tôi đã nhận được yêu cầu đặt tour của bạn. Mã đơn của bạn là:</p>'
          || '<p style="font-size:22px;font-weight:bold;letter-spacing:1px;background:#faf8f3;border:1px solid #e8e3d8;padding:10px 16px;display:inline-block">' || new.booking_ref || '</p>'
          || '<table style="width:100%;border-collapse:collapse;font-size:14px;margin:12px 0">'
          || '<tr><td style="padding:6px 0;color:#8a8578">Tour</td><td style="padding:6px 0"><b>' || coalesce(v_tour, '') || '</b></td></tr>'
          || '<tr><td style="padding:6px 0;color:#8a8578">Ngày khởi hành</td><td style="padding:6px 0">' || coalesce(v_depart, 'sẽ xác nhận sau') || '</td></tr>'
          || '<tr><td style="padding:6px 0;color:#8a8578">Số khách</td><td style="padding:6px 0">' || new.adult_count || ' người lớn'
          ||   case when coalesce(new.child_count,0)  > 0 then ', ' || new.child_count  || ' trẻ em'  else '' end
          ||   case when coalesce(new.infant_count,0) > 0 then ', ' || new.infant_count || ' em bé'   else '' end || '</td></tr>'
          || '<tr><td style="padding:6px 0;color:#8a8578">Tổng tiền</td><td style="padding:6px 0"><b>' || to_char(coalesce(new.total_price,0),'FM999,999,999') || 'đ</b></td></tr>'
          || '<tr><td style="padding:6px 0;color:#8a8578">Đặt cọc (30%)</td><td style="padding:6px 0;color:#c5372b"><b>' || to_char(coalesce(new.deposit_amount,0),'FM999,999,999') || 'đ</b></td></tr>'
          || '</table>'
          || '<div style="background:#faf8f3;border:1px solid #e8e3d8;padding:14px 16px;font-size:14px">'
          || '<b>Thanh toán tiền cọc để giữ chỗ:</b><br>'
          || 'Ngân hàng: <b>Techcombank</b><br>'
          || 'Số tài khoản: <b>4042828666</b><br>'
          || 'Chủ tài khoản: <b>TRAN HUNG VI</b><br>'
          || 'Nội dung chuyển khoản: <b>' || new.booking_ref || '</b>'
          || '</div>'
          || '<p style="font-size:14px">Sau khi chuyển khoản, bạn có thể nhắn <a href="https://zalo.me/0906306286">Zalo 0906 306 286</a> để được xác nhận nhanh. Hủy sớm được hoàn cọc theo <a href="https://baggio.website/chinh-sach">chính sách hoàn hủy</a>.</p>'
          || '<p style="font-size:13px;color:#8a8578">Baggio Travel · Phạm Văn Chiêu, TP. Hồ Chí Minh · Hotline/Zalo: 0906 306 286<br>Email này gửi tự động — cần hỗ trợ hãy trả lời trực tiếp email này.</p>'
          || '</div>'
      )
    );
  end if;
$eb$;

  def := replace(def, anchor, eb || anchor);

  execute def;
  raise notice 'Da va xong: notify_new_booking gio gui them email xac nhan.';
end $migrate$;

-- Kiểm tra: function đã chứa khối Resend chưa
select position('api.resend.com' in pg_get_functiondef('public.notify_new_booking()'::regprocedure)) > 0 as email_da_noi;
