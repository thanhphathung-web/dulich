-- ═══════════════════════════════════════════════════════════════
-- Bảng Nhà cung cấp (suppliers) + Giao dịch NCC (supplier_transactions)
-- Dùng cho trang /suppliers (baggio-suppliers.html).
-- Chạy trong Supabase → SQL Editor. Idempotent — chạy lại nhiều lần vô hại.
--
-- Bảo mật: dữ liệu giá hợp đồng / nhà cung cấp là NỘI BỘ, KHÔNG public.
-- → RLS chỉ cho admin (app_metadata.role='admin') đọc & ghi.
-- ⚠ Sau khi gán role admin (xem supabase/rls-tours.sql BƯỚC 0), phải
--   ĐĂNG XUẤT/ĐĂNG NHẬP LẠI ở /account thì role mới vào JWT.
-- ═══════════════════════════════════════════════════════════════

-- ── BẢNG SUPPLIERS ──
create table if not exists public.suppliers (
  id             uuid primary key default gen_random_uuid(),
  name           text not null,
  cat            text not null default 'other'
                   check (cat in ('hotel','flight','transport','food','activity','other')),
  contact        text,
  phone          text,
  email          text,
  web            text,
  address        text,
  area           text,
  contract_price numeric not null default 0,
  market_price   numeric not null default 0,
  unit           text not null default 'per_night'
                   check (unit in ('per_night','per_person','per_trip','per_day','per_group')),
  status         text not null default 'active'
                   check (status in ('active','preferred','inactive')),
  rating         int not null default 0 check (rating between 0 and 5),
  notes          text,
  tags           text[] not null default '{}',
  created_at     timestamptz not null default now(),
  updated_at     timestamptz not null default now()
);

-- ── BẢNG SUPPLIER_TRANSACTIONS ──
create table if not exists public.supplier_transactions (
  id           uuid primary key default gen_random_uuid(),
  supplier_id  uuid references public.suppliers(id) on delete cascade,
  sup_name     text,                 -- snapshot tên NCC lúc ghi (để xuất CSV / hiển thị)
  tx_date      date,
  amount       numeric not null default 0,
  description  text,
  type         text not null default 'booking'
                 check (type in ('booking','payment','refund','penalty')),
  created_at   timestamptz not null default now()
);

-- ── INDEX ──
create index if not exists idx_suppliers_cat        on public.suppliers(cat);
create index if not exists idx_suppliers_status     on public.suppliers(status);
create index if not exists idx_sup_tx_supplier      on public.supplier_transactions(supplier_id);
create index if not exists idx_sup_tx_date          on public.supplier_transactions(tx_date desc);

-- ── RLS: chỉ admin đọc & ghi ──
alter table public.suppliers              enable row level security;
alter table public.supplier_transactions  enable row level security;

drop policy if exists "suppliers_admin_all" on public.suppliers;
create policy "suppliers_admin_all" on public.suppliers
  for all to authenticated
  using      ((auth.jwt() -> 'app_metadata' ->> 'role') = 'admin')
  with check ((auth.jwt() -> 'app_metadata' ->> 'role') = 'admin');

drop policy if exists "sup_tx_admin_all" on public.supplier_transactions;
create policy "sup_tx_admin_all" on public.supplier_transactions
  for all to authenticated
  using      ((auth.jwt() -> 'app_metadata' ->> 'role') = 'admin')
  with check ((auth.jwt() -> 'app_metadata' ->> 'role') = 'admin');

-- ── (TÙY CHỌN) Dữ liệu mẫu để xem thử — bỏ comment nếu muốn seed ──
-- insert into public.suppliers (name,cat,contact,phone,email,address,area,contract_price,market_price,unit,status,rating,notes,tags) values
--   ('Mường Thanh Hội An','hotel','Nguyễn Thị Mai','0235 3861 999','sale@muongthanh-hoian.com','Đường Võ Thị Sáu, Hội An','Hội An, Quảng Nam',450000,650000,'per_night','preferred',5,'Giá net, bao breakfast. Cần đặt trước 7 ngày.','{"4 sao","breakfast","hồ bơi","trung tâm"}'),
--   ('Vinpearl Phú Quốc','hotel','Sales Team','0297 3598 888','phuquoc@vinpearl.com','Bãi Dài, Phú Quốc','Phú Quốc, Kiên Giang',2800000,4200000,'per_night','preferred',5,'Resort 5 sao. All-inclusive package.','{"5 sao","all-inclusive","resort","biển"}');

-- ── KIỂM TRA ──
select tablename, policyname, cmd, roles
from pg_policies
where schemaname='public' and tablename in ('suppliers','supplier_transactions')
order by tablename, cmd;
