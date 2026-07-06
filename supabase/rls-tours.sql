-- ═══════════════════════════════════════════════════════════════
-- RLS TRỌN GÓI cho bảng `tours` — chạy trong Supabase → SQL Editor
-- Mục tiêu: khách (anon) chỉ ĐỌC tour ACTIVE; ADMIN đọc/ghi tất cả.
-- Script tự XOÁ SẠCH mọi policy cũ trên tours rồi tạo lại bộ chuẩn,
-- nên KHÔNG cần biết tên policy hiện tại.
--
-- ⚠ CHẠY THEO ĐÚNG THỨ TỰ. Đọc kỹ 3 lưu ý ở cuối trước khi chạy —
--   đặc biệt việc PHẢI ĐĂNG XUẤT/ĐĂNG NHẬP LẠI sau khi chạy.
-- ═══════════════════════════════════════════════════════════════

-- ── BƯỚC 0: Gán quyền admin cho tài khoản của bạn (chạy TRƯỚC) ──
-- Nếu bỏ qua bước này, sau khi áp policy bạn sẽ MẤT quyền ghi
-- (CMS + tool import không lưu được) cho tới khi user có role='admin'.
update auth.users
set raw_app_meta_data = coalesce(raw_app_meta_data, '{}'::jsonb) || '{"role":"admin"}'::jsonb
where email = 'thanhphathung@gmail.com';
-- (Thêm dòng update tương tự cho các email admin khác nếu có.)

-- ── BƯỚC 1: Bật RLS ──
alter table public.tours enable row level security;

-- ── BƯỚC 2: Xoá SẠCH mọi policy đang có trên tours ──
do $$
declare pol record;
begin
  for pol in
    select policyname from pg_policies
    where schemaname = 'public' and tablename = 'tours'
  loop
    execute format('drop policy if exists %I on public.tours', pol.policyname);
  end loop;
end $$;

-- ── BƯỚC 3: Tạo lại bộ policy chuẩn ──

-- 3a) Khách (anon + authenticated) xem được tour ACTIVE
create policy "tours_public_read_active"
  on public.tours for select
  using ( status = 'ACTIVE' );

-- 3b) Admin xem được TẤT CẢ trạng thái (để CMS/tool thấy DRAFT, INACTIVE)
create policy "tours_admin_read_all"
  on public.tours for select
  to authenticated
  using ( (auth.jwt() -> 'app_metadata' ->> 'role') = 'admin' );

-- 3c) Chỉ admin được GHI (insert / update / delete)
create policy "tours_admin_write"
  on public.tours for all
  to authenticated
  using      ( (auth.jwt() -> 'app_metadata' ->> 'role') = 'admin' )
  with check ( (auth.jwt() -> 'app_metadata' ->> 'role') = 'admin' );

-- ── BƯỚC 4: Kiểm tra kết quả ──
select policyname, cmd, roles, qual, with_check
from pg_policies
where schemaname = 'public' and tablename = 'tours'
order by cmd;

-- ═══════════════════════════════════════════════════════════════
-- 3 LƯU Ý QUAN TRỌNG
--
-- 1) app_metadata nằm TRONG JWT lúc đăng nhập. Sau khi chạy BƯỚC 0,
--    phiên đăng nhập hiện tại VẪN mang JWT cũ (chưa có role).
--    => PHẢI ĐĂNG XUẤT rồi ĐĂNG NHẬP LẠI thì writes mới hoạt động.
--
-- 2) Nếu admin đăng nhập bằng Google OAuth, email phải khớp CHÍNH XÁC
--    email ở BƯỚC 0. Kiểm tra: select email from auth.users;
--
-- 3) Sau khi xong, mở /cms hoặc /tour-import (đã đăng nhập lại) và
--    thử LƯU một tour. Nếu bị chặn 42501 => JWT chưa có role,
--    nghĩa là chưa đăng nhập lại hoặc email không khớp.
-- ═══════════════════════════════════════════════════════════════
