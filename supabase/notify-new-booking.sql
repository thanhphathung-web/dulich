-- ═══════════════════════════════════════════════════════════════
-- THÔNG BÁO ĐƠN MỚI — push notification qua ntfy.sh khi có booking
-- Kênh nhận: cài app "ntfy" (Android/iOS) → Subscribe topic:
--   baggio-don-moi-3bccbf0e03
-- Hoặc mở web: https://ntfy.sh/baggio-don-moi-3bccbf0e03
-- Sau này muốn thêm email: thêm 1 lệnh net.http_post nữa vào cùng
-- function này (đã chừa sẵn chỗ bên dưới).
-- ═══════════════════════════════════════════════════════════════

create extension if not exists pg_net;

-- Khách chọn trả kiểu gì (BANK_TRANSFER / CASH) — frontend gửi lên
alter table public.bookings add column if not exists payment_method text;

create or replace function public.notify_new_booking()
returns trigger
language plpgsql
security definer
set search_path = public
as $fn$
declare
  v_tour   text;
  v_depart text;
begin
  select name_vi into v_tour from tours where id = new.tour_id;
  if new.schedule_id is not null then
    select depart_date::text into v_depart from tour_schedules where id = new.schedule_id;
  end if;

  -- ── Kênh 1: push ntfy.sh ──
  perform net.http_post(
    url  := 'https://ntfy.sh',
    body := jsonb_build_object(
      'topic',    'baggio-don-moi-3bccbf0e03',
      'title',    'ĐƠN MỚI ' || new.booking_ref || ' — cọc ' || to_char(coalesce(new.deposit_amount,0), 'FM999,999,999') || 'đ',
      'message',
        'Tour: '      || coalesce(v_tour, new.tour_id::text)                       || E'\n' ||
        'Ngày đi: '   || coalesce(v_depart, 'chưa chọn')                           || E'\n' ||
        'Khách: '     || new.guest_name || ' — ' || new.guest_phone                || E'\n' ||
        'Email: '     || coalesce(new.guest_email, '—')                            || E'\n' ||
        'Số khách: '  || new.adult_count || ' NL, ' || coalesce(new.child_count,0)
                      || ' TE, ' || coalesce(new.infant_count,0) || ' EB'          || E'\n' ||
        'Tổng: '      || to_char(coalesce(new.total_price,0),   'FM999,999,999')  || 'đ'
                      || ' — Cọc 30%: '
                      || to_char(coalesce(new.deposit_amount,0),'FM999,999,999')  || 'đ' || E'\n' ||
        'Thanh toán: ' || case coalesce(new.payment_method,'?')
                            when 'BANK_TRANSFER' then 'Chuyển khoản QR'
                            when 'CASH' then 'Tiền mặt'
                            else coalesce(new.payment_method,'?') end             || E'\n' ||
        'Ghi chú: '   || coalesce(new.special_requests, '—'),
      'priority', 4,
      'tags',     jsonb_build_array('tada', 'moneybag')
    )
  );

  -- ── Kênh 2: email (CHƯA BẬT — nối Resend/API khác vào đây sau) ──
  -- perform net.http_post(url := 'https://api.resend.com/emails', ...);

  return new;
exception when others then
  -- Lỗi gửi thông báo KHÔNG được làm hỏng việc tạo booking
  raise warning 'notify_new_booking failed: %', sqlerrm;
  return new;
end $fn$;

drop trigger if exists trg_notify_new_booking on public.bookings;
create trigger trg_notify_new_booking
  after insert on public.bookings
  for each row execute function public.notify_new_booking();
