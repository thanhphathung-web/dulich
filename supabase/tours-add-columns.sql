-- ═══════════════════════════════════════════════════════════════
-- Thêm các cột CMS cần nhưng bảng `tours` đang thiếu.
-- Chạy trong Supabase → SQL Editor. An toàn & idempotent (IF NOT EXISTS) —
-- chạy lại nhiều lần không sao.
-- ═══════════════════════════════════════════════════════════════

-- ── Cột phần lưu chính (gây lỗi 'audience' và các lỗi tiếp theo) ──
alter table public.tours add column if not exists single_supplement numeric   default 0;
alter table public.tours add column if not exists deposit_pct       integer   default 30;
alter table public.tours add column if not exists tour_type         text;
alter table public.tours add column if not exists service_class     text;
alter table public.tours add column if not exists audience          text;
alter table public.tours add column if not exists difficulty        text;
alter table public.tours add column if not exists cancel_policy     text;
alter table public.tours add column if not exists best_season       text;
alter table public.tours add column if not exists guide_language    text;
alter table public.tours add column if not exists sub_destinations  jsonb     default '[]'::jsonb;
-- (gallery: KHÔNG thêm — dùng cột 'images' có sẵn; CMS đã sửa để load/save vào 'images')
alter table public.tours add column if not exists description        text;   -- mô tả VI
alter table public.tours add column if not exists notes             jsonb     default '[]'::jsonb;
alter table public.tours add column if not exists travel_styles     jsonb     default '[]'::jsonb;
alter table public.tours add column if not exists tags              jsonb     default '[]'::jsonb;
alter table public.tours add column if not exists meta_description   text;
alter table public.tours add column if not exists video_url         text;
alter table public.tours add column if not exists depart_time       text;

-- ── Cột bản dịch EN còn thiếu (để approve/auto-translate EN lưu đủ) ──
alter table public.tours add column if not exists summary_en        text;
alter table public.tours add column if not exists description_en    text;
alter table public.tours add column if not exists excludes_en       jsonb     default '[]'::jsonb;

-- ── Buộc PostgREST nạp lại schema ngay (nếu không, đợi vài phút) ──
notify pgrst, 'reload schema';

-- ── Kiểm tra: liệt kê toàn bộ cột của tours ──
select column_name, data_type
from information_schema.columns
where table_schema = 'public' and table_name = 'tours'
order by column_name;
