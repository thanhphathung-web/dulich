-- ═══════════════════════════════════════════════════════════════
-- RBAC Phase 1 — NỀN TẢNG (không phá vỡ gì hiện có)
-- Tạo bảng staff_roles + hàm helper + RPC gán role + seed admin.
-- RLS cũ (dựa app_metadata) vẫn nguyên → mọi trang chạy như cũ.
-- Chạy trong Supabase → SQL Editor. Idempotent — chạy lại vô hại.
-- Xem thiết kế: docs/rbac-plan.md
-- ═══════════════════════════════════════════════════════════════

-- ── BẢNG staff_roles (nguồn sự thật của phân quyền) ──
create table if not exists public.staff_roles (
  user_id     uuid primary key references auth.users(id) on delete cascade,
  role        text not null
                check (role in ('admin','manager','sales','ops','accountant','content')),
  email       text,                 -- lưu để hiển thị trong UI quản lý
  added_by    uuid,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);

alter table public.staff_roles enable row level security;

-- ── HÀM HELPER (security definer → đọc staff_roles vượt RLS) ──
create or replace function public.staff_role()
returns text language sql stable security definer set search_path = public as $$
  select role from public.staff_roles where user_id = auth.uid();
$$;

create or replace function public.has_role(variadic roles text[])
returns boolean language sql stable security definer set search_path = public as $$
  select coalesce(public.staff_role() = any(roles), false);
$$;

grant execute on function public.staff_role()        to authenticated;
grant execute on function public.has_role(text[])    to authenticated;

-- ── RLS cho chính bảng staff_roles ──
-- user đọc dòng của mình (để client biết role); admin đọc/ghi tất cả
drop policy if exists "staff_roles_self_read" on public.staff_roles;
create policy "staff_roles_self_read" on public.staff_roles
  for select to authenticated
  using (user_id = auth.uid() or public.has_role('admin'));

drop policy if exists "staff_roles_admin_write" on public.staff_roles;
create policy "staff_roles_admin_write" on public.staff_roles
  for all to authenticated
  using      (public.has_role('admin'))
  with check (public.has_role('admin'));

-- ── RPC gán role theo email (CHỈ admin gọi được) ──
create or replace function public.set_staff_role(target_email text, new_role text)
returns void language plpgsql security definer set search_path = public as $$
declare uid uuid;
begin
  if not public.has_role('admin') then
    raise exception 'forbidden: chi admin duoc gan role';
  end if;
  if new_role not in ('admin','manager','sales','ops','accountant','content') then
    raise exception 'invalid_role: %', new_role;
  end if;
  select id into uid from auth.users where email = target_email;
  if uid is null then
    raise exception 'user_not_found: % chua dang nhap lan nao', target_email;
  end if;
  -- Chống tự khóa: không cho hạ cấp admin CUỐI CÙNG
  if new_role <> 'admin'
     and exists (select 1 from public.staff_roles where user_id = uid and role = 'admin')
     and (select count(*) from public.staff_roles where role = 'admin') <= 1 then
    raise exception 'last_admin: khong the ha cap admin cuoi cung';
  end if;
  insert into public.staff_roles(user_id, role, email, added_by)
  values (uid, new_role, target_email, auth.uid())
  on conflict (user_id) do update
    set role = excluded.role, email = excluded.email, updated_at = now();
end;
$$;
grant execute on function public.set_staff_role(text, text) to authenticated;

-- ── RPC xoá role (thu hồi quyền nhân viên) — CHỈ admin ──
create or replace function public.remove_staff_role(target_email text)
returns void language plpgsql security definer set search_path = public as $$
begin
  if not public.has_role('admin') then
    raise exception 'forbidden';
  end if;
  -- Chống tự khóa: không cho xóa admin CUỐI CÙNG
  if exists (select 1 from public.staff_roles where email = target_email and role = 'admin')
     and (select count(*) from public.staff_roles where role = 'admin') <= 1 then
    raise exception 'last_admin: khong the xoa admin cuoi cung';
  end if;
  delete from public.staff_roles where email = target_email;
end;
$$;
grant execute on function public.remove_staff_role(text) to authenticated;

-- ── SEED: chuyển admin hiện tại vào staff_roles ──
insert into public.staff_roles(user_id, role, email)
select id, 'admin', email from auth.users where email = 'thanhphathung@gmail.com'
on conflict (user_id) do update set role = 'admin', updated_at = now();

-- ── KIỂM TRA ──
select role, email, created_at from public.staff_roles order by role;
