-- ═══════════════════════════════════════════════════════════════
-- RPC trừ/hoàn chỗ AN TOÀN cho tour_schedules — chạy trong Supabase → SQL Editor.
-- Idempotent (create or replace) — chạy lại nhiều lần vô hại.
--
-- BỐI CẢNH: sau khi áp rls-all-tables.sql, client KHÔNG còn được UPDATE
--   tour_schedules trực tiếp (chỉ admin ghi). Việc "đặt tour → trừ chỗ" chuyển
--   sang gọi 2 hàm SECURITY DEFINER dưới đây (chạy bằng quyền chủ hàm, vượt RLS
--   nhưng chỉ làm đúng 1 việc: cộng/trừ available_slots có kiểm tra).
--
-- Vì sao an toàn hơn client tự UPDATE:
--   • reserve_slots trừ chỗ NGUYÊN TỬ + chặn (available_slots >= qty) → không
--     bao giờ âm, chống overbooking kể cả khi 2 khách đặt cùng lúc (khóa dòng).
--   • Khách chỉ truyền schedule_id + số lượng, KHÔNG tự đặt số chỗ còn lại.
--
-- id so khớp dạng text (id::text) → chạy được dù tour_schedules.id là uuid hay bigint.
-- ═══════════════════════════════════════════════════════════════


-- ── Trừ chỗ: trả về số chỗ còn lại; lỗi 'not_enough_slots' nếu không đủ ──
create or replace function public.reserve_slots(p_schedule_id text, p_qty int)
returns int
language plpgsql
security definer
set search_path = public
as $$
declare
  remaining int;
begin
  if p_qty is null or p_qty <= 0 then
    raise exception 'invalid_qty';
  end if;

  update public.tour_schedules
     set available_slots = available_slots - p_qty
   where id::text = p_schedule_id
     and available_slots >= p_qty
  returning available_slots into remaining;

  if not found then
    -- hoặc không có schedule đó, hoặc không đủ chỗ
    raise exception 'not_enough_slots';
  end if;

  return remaining;
end;
$$;


-- ── Hoàn chỗ: dùng khi đã trừ nhưng insert booking lỗi (rollback thủ công) ──
create or replace function public.release_slots(p_schedule_id text, p_qty int)
returns int
language plpgsql
security definer
set search_path = public
as $$
declare
  remaining int;
begin
  if p_qty is null or p_qty <= 0 then
    raise exception 'invalid_qty';
  end if;

  update public.tour_schedules
     set available_slots = available_slots + p_qty
   where id::text = p_schedule_id
  returning available_slots into remaining;

  return remaining;  -- null nếu không tìm thấy schedule (không sao)
end;
$$;


-- ── Quyền gọi: cho cả khách vãng lai (anon) và khách đăng nhập ──
revoke all on function public.reserve_slots(text, int) from public;
revoke all on function public.release_slots(text, int) from public;
grant execute on function public.reserve_slots(text, int) to anon, authenticated;
grant execute on function public.release_slots(text, int) to anon, authenticated;
