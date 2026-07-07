-- ═══════════════════════════════════════════════════════════════
-- RLS cho các bảng CMS/khách còn lại — chạy trong Supabase → SQL Editor.
-- Idempotent (drop if exists + create) — chạy lại nhiều lần vô hại.
--
-- ⚠ TRƯỚC KHI CHẠY: deploy bản sửa baggio-booking-live.html (bỏ .select()
--    sau insert booking) cho xong, để việc siết quyền đọc bookings không
--    làm hỏng luồng đặt tour của khách.
--
-- Điều kiện admin dùng lại: app_metadata.role = 'admin'
-- Chủ sở hữu: users.email / bookings.guest_email khớp email trong JWT.
-- ═══════════════════════════════════════════════════════════════


-- ── GUIDES ── ai cũng đọc; chỉ admin ghi
drop policy if exists "guides_admin_write" on public.guides;
create policy "guides_admin_write" on public.guides
  for all to authenticated
  using      ((auth.jwt() -> 'app_metadata' ->> 'role') = 'admin')
  with check ((auth.jwt() -> 'app_metadata' ->> 'role') = 'admin');


-- ── BOOKINGS ──
-- 🔴 BỎ policy đọc công khai (đang cho BẤT KỲ AI đọc mọi booking — rò rỉ PII).
drop policy if exists "public select bookings" on public.bookings;

-- Khách đăng nhập chỉ đọc booking CỦA MÌNH (guest_email = email trong JWT)
drop policy if exists "bookings_owner_select" on public.bookings;
create policy "bookings_owner_select" on public.bookings
  for select to authenticated
  using (guest_email = (auth.jwt() ->> 'email'));

-- Admin đọc/sửa/xóa tất cả booking
drop policy if exists "bookings_admin_all" on public.bookings;
create policy "bookings_admin_all" on public.bookings
  for all to authenticated
  using      ((auth.jwt() -> 'app_metadata' ->> 'role') = 'admin')
  with check ((auth.jwt() -> 'app_metadata' ->> 'role') = 'admin');
-- (Giữ nguyên "public insert bookings" — khách/khách vãng lai vẫn tạo booking được.)


-- ── REVIEWS ── giữ đọc công khai; thêm quyền admin duyệt/xóa
drop policy if exists "reviews_admin_write" on public.reviews;
create policy "reviews_admin_write" on public.reviews
  for all to authenticated
  using      ((auth.jwt() -> 'app_metadata' ->> 'role') = 'admin')
  with check ((auth.jwt() -> 'app_metadata' ->> 'role') = 'admin');


-- ── TOUR_SCHEDULES ── ai cũng đọc; chỉ admin ghi (quản lý lịch)
drop policy if exists "tour_schedules_admin_write" on public.tour_schedules;
create policy "tour_schedules_admin_write" on public.tour_schedules
  for all to authenticated
  using      ((auth.jwt() -> 'app_metadata' ->> 'role') = 'admin')
  with check ((auth.jwt() -> 'app_metadata' ->> 'role') = 'admin');
-- ⚠ LƯU Ý: việc "khách đặt tour → trừ available_slots" hiện cho client UPDATE
--    trực tiếp là RỦI RO (khách có thể sửa số chỗ tùy ý) → policy này CỐ TÌNH
--    không cho. Hệ quả: slot không tự trừ khi khách đặt (nguy cơ overbooking —
--    vốn đã hỏng sẵn). Cách đúng: dùng hàm SECURITY DEFINER (RPC) trừ chỗ an
--    toàn. Nói tôi nếu muốn tôi viết RPC + sửa booking-live gọi nó.


-- ── USERS ── (hồ sơ khách, khóa theo email) — user tự quản hồ sơ mình
drop policy if exists "users_owner_select" on public.users;
create policy "users_owner_select" on public.users
  for select to authenticated
  using (email = (auth.jwt() ->> 'email'));

drop policy if exists "users_owner_insert" on public.users;
create policy "users_owner_insert" on public.users
  for insert to authenticated
  with check (email = (auth.jwt() ->> 'email'));

drop policy if exists "users_owner_update" on public.users;
create policy "users_owner_update" on public.users
  for update to authenticated
  using      (email = (auth.jwt() ->> 'email'))
  with check (email = (auth.jwt() ->> 'email'));

drop policy if exists "users_admin_all" on public.users;
create policy "users_admin_all" on public.users
  for all to authenticated
  using      ((auth.jwt() -> 'app_metadata' ->> 'role') = 'admin')
  with check ((auth.jwt() -> 'app_metadata' ->> 'role') = 'admin');


-- ── TOURS ── (siết nhẹ) khách chỉ đọc tour ACTIVE, không lộ DRAFT
--    (admin vẫn đọc mọi trạng thái qua policy tours_admin_read_all sẵn có)
drop policy if exists "public read tours" on public.tours;
create policy "public read tours" on public.tours
  for select to public
  using (status = 'ACTIVE');


-- ── KIỂM TRA: liệt kê lại toàn bộ policy sau khi chạy ──
select tablename, policyname, cmd, roles
from pg_policies
where schemaname='public'
  and tablename in ('tours','guides','bookings','reviews','tour_schedules','users')
order by tablename, cmd;
