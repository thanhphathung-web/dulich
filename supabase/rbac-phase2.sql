-- ═══════════════════════════════════════════════════════════════
-- RBAC Phase 2 — VIẾT LẠI RLS THEO MA TRẬN QUYỀN (docs/rbac-plan.md §3)
-- Chạy SAU rbac-phase1.sql. Idempotent — chạy lại vô hại.
--
-- Nguyên tắc:
--  · Mỗi bảng: thay policy `*_admin_*` (check app_metadata) bằng policy
--    theo role đọc từ staff_roles (has_role).
--  · GIỮ FALLBACK: app_metadata.role='admin' vẫn được coi là admin
--    (qua has_role_or_legacy) — gỡ ở nhịp sau khi RBAC chạy ổn.
--  · KHÔNG đụng: policy public read (tours ACTIVE, reviews, guides,
--    schedules), owner-read bookings/users, guest insert bookings,
--    và các trigger/RPC security definer.
--
-- Ma trận (R=đọc, W=đọc+ghi):
--  tours:        W admin,manager,content · R sales,ops,accountant
--  schedules:    W admin,manager,ops     · R còn lại (public read sẵn)
--  bookings:     W admin,manager,sales,ops · R accountant · content: CẤM
--  comms:        W admin,manager,sales   · R ops
--  guides:       W admin,manager,ops     (public read sẵn)
--  suppliers:    W admin,manager,ops     · R accountant · sales/content: CẤM
--  supplier_tx:  W admin,manager,ops,accountant
--  reviews:      W admin,manager,content (public read sẵn)
--  users:        W admin,manager         · R sales,ops,accountant
-- ═══════════════════════════════════════════════════════════════

-- ── Helper: role mới HOẶC admin kiểu cũ (fallback 1 nhịp) ──
create or replace function public.has_role_or_legacy(variadic roles text[])
returns boolean language sql stable security definer set search_path = public as $$
  select public.has_role(variadic roles)
      or coalesce((auth.jwt() -> 'app_metadata' ->> 'role') = 'admin', false);
$$;
grant execute on function public.has_role_or_legacy(text[]) to authenticated;

-- ── TOURS ──
drop policy if exists "tours_admin_read_all" on public.tours;
create policy "tours_staff_read_all" on public.tours
  for select to authenticated
  using (public.has_role_or_legacy('admin','manager','sales','ops','accountant','content'));

drop policy if exists "tours_admin_write" on public.tours;
drop policy if exists "tours_staff_write" on public.tours;
create policy "tours_staff_write" on public.tours
  for all to authenticated
  using      (public.has_role_or_legacy('admin','manager','content'))
  with check (public.has_role_or_legacy('admin','manager','content'));

-- ── TOUR_SCHEDULES ──
drop policy if exists "tour_schedules_admin_write" on public.tour_schedules;
drop policy if exists "tour_schedules_staff_write" on public.tour_schedules;
create policy "tour_schedules_staff_write" on public.tour_schedules
  for all to authenticated
  using      (public.has_role_or_legacy('admin','manager','ops'))
  with check (public.has_role_or_legacy('admin','manager','ops'));

-- ── BOOKINGS ── (owner_select + public insert giữ nguyên)
drop policy if exists "bookings_admin_all" on public.bookings;
drop policy if exists "bookings_staff_all" on public.bookings;
create policy "bookings_staff_all" on public.bookings
  for all to authenticated
  using      (public.has_role_or_legacy('admin','manager','sales','ops'))
  with check (public.has_role_or_legacy('admin','manager','sales','ops'));

drop policy if exists "bookings_accountant_read" on public.bookings;
create policy "bookings_accountant_read" on public.bookings
  for select to authenticated
  using (public.has_role('accountant'));

-- ── COMMUNICATIONS + COMM_REMINDERS ──
drop policy if exists "communications_admin_all" on public.communications;
drop policy if exists "communications_staff_all" on public.communications;
create policy "communications_staff_all" on public.communications
  for all to authenticated
  using      (public.has_role_or_legacy('admin','manager','sales'))
  with check (public.has_role_or_legacy('admin','manager','sales'));

drop policy if exists "communications_ops_read" on public.communications;
create policy "communications_ops_read" on public.communications
  for select to authenticated
  using (public.has_role('ops'));

drop policy if exists "comm_reminders_admin_all" on public.comm_reminders;
drop policy if exists "comm_reminders_staff_all" on public.comm_reminders;
create policy "comm_reminders_staff_all" on public.comm_reminders
  for all to authenticated
  using      (public.has_role_or_legacy('admin','manager','sales'))
  with check (public.has_role_or_legacy('admin','manager','sales'));

drop policy if exists "comm_reminders_ops_read" on public.comm_reminders;
create policy "comm_reminders_ops_read" on public.comm_reminders
  for select to authenticated
  using (public.has_role('ops'));

-- ── GUIDES ── (public read giữ nguyên)
drop policy if exists "guides_admin_write" on public.guides;
drop policy if exists "guides_staff_write" on public.guides;
create policy "guides_staff_write" on public.guides
  for all to authenticated
  using      (public.has_role_or_legacy('admin','manager','ops'))
  with check (public.has_role_or_legacy('admin','manager','ops'));

-- ── SUPPLIERS (giá vốn — giấu với sales/content) ──
drop policy if exists "suppliers_admin_all" on public.suppliers;
drop policy if exists "suppliers_staff_all" on public.suppliers;
create policy "suppliers_staff_all" on public.suppliers
  for all to authenticated
  using      (public.has_role_or_legacy('admin','manager','ops'))
  with check (public.has_role_or_legacy('admin','manager','ops'));

drop policy if exists "suppliers_accountant_read" on public.suppliers;
create policy "suppliers_accountant_read" on public.suppliers
  for select to authenticated
  using (public.has_role('accountant'));

-- ── SUPPLIER_TRANSACTIONS ──
drop policy if exists "sup_tx_admin_all" on public.supplier_transactions;
drop policy if exists "sup_tx_staff_all" on public.supplier_transactions;
create policy "sup_tx_staff_all" on public.supplier_transactions
  for all to authenticated
  using      (public.has_role_or_legacy('admin','manager','ops','accountant'))
  with check (public.has_role_or_legacy('admin','manager','ops','accountant'));

-- ── REVIEWS ── (public read giữ nguyên)
drop policy if exists "reviews_admin_write" on public.reviews;
drop policy if exists "reviews_staff_write" on public.reviews;
create policy "reviews_staff_write" on public.reviews
  for all to authenticated
  using      (public.has_role_or_legacy('admin','manager','content'))
  with check (public.has_role_or_legacy('admin','manager','content'));

-- ── USERS (hồ sơ khách — owner policies giữ nguyên) ──
drop policy if exists "users_admin_all" on public.users;
drop policy if exists "users_staff_all" on public.users;
create policy "users_staff_all" on public.users
  for all to authenticated
  using      (public.has_role_or_legacy('admin','manager'))
  with check (public.has_role_or_legacy('admin','manager'));

drop policy if exists "users_staff_read" on public.users;
create policy "users_staff_read" on public.users
  for select to authenticated
  using (public.has_role('sales','ops','accountant'));

-- ── KIỂM TRA ──
select tablename, policyname, cmd
from pg_policies
where schemaname = 'public'
  and tablename in ('tours','tour_schedules','bookings','communications','comm_reminders',
                    'guides','suppliers','supplier_transactions','reviews','users','staff_roles')
order by tablename, policyname;
