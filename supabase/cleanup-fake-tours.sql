-- ═══════════════════════════════════════════════════════════════
-- DỌN TOUR ẢO — giữ nhóm slug đuôi "-100xx" (tour tuyển chọn), xóa còn lại
-- Chạy trong Supabase → SQL Editor. LÀM ĐÚNG 3 BƯỚC.
-- ⚠ XÓA KHÔNG HOÀN TÁC. Bắt buộc chạy BƯỚC 1 + BƯỚC 2 trước BƯỚC 3.
--
-- Quy tắc GIỮ: slug khớp biểu thức '-100[0-9][0-9]$'  (vd -10001 … -10099)
-- Quy tắc XÓA: mọi tour còn lại (kể cả slug NULL)
-- ═══════════════════════════════════════════════════════════════


-- ─────────────────────────────────────────────────────────────
-- BƯỚC 1 — XEM TRƯỚC (CHỈ ĐỌC, không xóa gì). Chạy & kiểm tra kỹ.
-- ─────────────────────────────────────────────────────────────

-- 1a. Tổng số tour trong bảng
select count(*) as tong_so_tour from public.tours;

-- 1b. Sẽ GIỮ bao nhiêu — CON SỐ NÀY PHẢI ĐÚNG ~20 (tour thật của bạn)
select count(*) as se_giu
from public.tours
where slug ~ '-100[0-9][0-9]$';

-- 1c. Danh sách tour sẽ GIỮ — đọc kỹ, phải toàn tour thật
select name_vi, slug, status, base_price
from public.tours
where slug ~ '-100[0-9][0-9]$'
order by slug;

-- 1d. Sẽ XÓA bao nhiêu (mong đợi ~8.200)
select count(*) as se_xoa
from public.tours
where slug !~ '-100[0-9][0-9]$' or slug is null;

-- 1e. Xem mẫu 50 tour sẽ XÓA — kiểm tra không có tour thật nào lọt vào
select name_vi, slug, status
from public.tours
where slug !~ '-100[0-9][0-9]$' or slug is null
order by created_at desc
limit 50;

-- 1f. Bảng con tham chiếu tới tours (khóa ngoại) — cần biết trước khi xóa.
--     Nếu quy_tac_xoa = 'CASCADE' → xóa tours sẽ tự xóa dòng con (an toàn).
--     Nếu 'NO ACTION' / 'RESTRICT' → phải xóa dòng con TRƯỚC, nếu không lệnh xóa sẽ báo lỗi.
select
  tc.table_name   as bang_con,
  kcu.column_name as cot_khoa_ngoai,
  rc.delete_rule  as quy_tac_xoa
from information_schema.table_constraints tc
join information_schema.key_column_usage kcu
  on tc.constraint_name = kcu.constraint_name and tc.table_schema = kcu.table_schema
join information_schema.referential_constraints rc
  on tc.constraint_name = rc.constraint_name
join information_schema.constraint_column_usage ccu
  on rc.unique_constraint_name = ccu.constraint_name
where tc.constraint_type = 'FOREIGN KEY' and ccu.table_name = 'tours';

-- ✅ ĐIỀU KIỆN AN TOÀN trước khi sang bước sau:
--    • se_giu ≈ 20 và danh sách 1c toàn tour thật
--    • se_giu + se_xoa = tong_so_tour
--    • Xem 1f: nếu có bảng con quy_tac_xoa KHÁC 'CASCADE' → GỬI TÔI kết quả 1f,
--      tôi sẽ bổ sung lệnh xóa dòng con trước. ĐỪNG chạy bước 3 vội.


-- ─────────────────────────────────────────────────────────────
-- BƯỚC 2 — BACKUP (bắt buộc). Tạo bảng lưu toàn bộ tours hiện tại.
--          Nếu xóa nhầm, khôi phục được từ bảng này.
-- ─────────────────────────────────────────────────────────────

create table public.tours_backup_20260706 as
select * from public.tours;

-- Kiểm tra backup có đủ dòng (phải = tong_so_tour ở 1a):
select count(*) as so_dong_backup from public.tours_backup_20260706;


-- ─────────────────────────────────────────────────────────────
-- BƯỚC 3 — XÓA (chỉ chạy SAU KHI 1 + 2 đã OK). KHÔNG HOÀN TÁC.
--
-- MẸO AN TOÀN: bọc trong transaction để thử trước —
--   BEGIN;   chạy DELETE;   chạy lại 1b/1d để đối chiếu;
--   nếu đúng → COMMIT;   nếu sai → ROLLBACK;
-- ─────────────────────────────────────────────────────────────

-- (Nếu bước 1f cho thấy bảng con KHÔNG cascade, chạy phần xóa dòng con
--  mà tôi cung cấp riêng TẠI ĐÂY trước, rồi mới chạy lệnh dưới.)

delete from public.tours
where slug !~ '-100[0-9][0-9]$' or slug is null;

-- Kiểm tra sau xóa: phải còn đúng ~20 dòng
select count(*) as con_lai from public.tours;

-- Khi đã chắc chắn ổn định (vài ngày sau), có thể xóa bảng backup:
-- drop table public.tours_backup_20260706;
