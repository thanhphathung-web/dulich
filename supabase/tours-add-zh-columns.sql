-- ═══════════════════════════════════════════════════════════════
-- Thêm các cột bản dịch TIẾNG TRUNG (ZH) cho bảng `tours`.
-- `name_zh` đã có sẵn (do công cụ /translate). File này thêm phần
-- nội dung ZH đầy đủ để tab 🇨🇳 trong CMS auto-translate/approve lưu đủ.
-- Chạy trong Supabase → SQL Editor. An toàn & idempotent (IF NOT EXISTS).
-- ═══════════════════════════════════════════════════════════════

-- ── Nội dung bản dịch ZH ──
alter table public.tours add column if not exists summary_zh          text;
alter table public.tours add column if not exists description_zh      text;
alter table public.tours add column if not exists highlights_zh       text[];
alter table public.tours add column if not exists itinerary_zh        jsonb        default '[]'::jsonb;
alter table public.tours add column if not exists includes_zh         jsonb        default '[]'::jsonb;
alter table public.tours add column if not exists excludes_zh         jsonb        default '[]'::jsonb;

-- ── Trạng thái duyệt riêng cho ZH (KHÔNG dùng chung với EN để tránh đá nhau) ──
-- pending = chưa dịch · auto = chờ review · reviewed = đã duyệt · manual = nhập tay
alter table public.tours add column if not exists translation_status_zh text     default 'pending';
alter table public.tours add column if not exists translated_at_zh    timestamptz;

-- ── Buộc PostgREST nạp lại schema ngay (nếu không, đợi vài phút) ──
notify pgrst, 'reload schema';

-- ── Kiểm tra: liệt kê các cột ZH ──
select column_name, data_type
from information_schema.columns
where table_schema = 'public' and table_name = 'tours' and column_name like '%_zh'
order by column_name;
