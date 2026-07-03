-- Baggio Travel — Thêm các cột còn thiếu vào bảng tours
-- Sửa lỗi CMS "Could not find the 'audience' column of 'tours' in the schema cache"
-- Chạy trong Supabase SQL Editor (Dashboard → SQL Editor → New query)
--
-- Form CMS (baggio-cms.html, hàm saveTour) gửi 18 trường chưa có cột trong bảng.
-- ADD COLUMN IF NOT EXISTS nên chạy lại nhiều lần cũng an toàn.

ALTER TABLE tours
  ADD COLUMN IF NOT EXISTS single_supplement numeric      DEFAULT 0,
  ADD COLUMN IF NOT EXISTS deposit_pct       integer      DEFAULT 30,
  ADD COLUMN IF NOT EXISTS tour_type         text,
  ADD COLUMN IF NOT EXISTS service_class     text         DEFAULT 'standard',
  ADD COLUMN IF NOT EXISTS audience          text         DEFAULT 'all',
  ADD COLUMN IF NOT EXISTS difficulty        text         DEFAULT 'easy',
  ADD COLUMN IF NOT EXISTS cancel_policy     text         DEFAULT 'moderate',
  ADD COLUMN IF NOT EXISTS best_season       text,
  ADD COLUMN IF NOT EXISTS guide_language    text         DEFAULT 'vi',
  ADD COLUMN IF NOT EXISTS sub_destinations  text[]       DEFAULT '{}',
  ADD COLUMN IF NOT EXISTS gallery           text[]       DEFAULT '{}',
  ADD COLUMN IF NOT EXISTS description       text,
  ADD COLUMN IF NOT EXISTS notes             text[]       DEFAULT '{}',
  ADD COLUMN IF NOT EXISTS travel_styles     text[]       DEFAULT '{}',
  ADD COLUMN IF NOT EXISTS tags              text[]       DEFAULT '{}',
  ADD COLUMN IF NOT EXISTS meta_description  text,
  ADD COLUMN IF NOT EXISTS video_url         text,
  ADD COLUMN IF NOT EXISTS depart_time       text;

-- Cột dịch tiếng Anh còn thiếu (bản ZH đã có sẵn summary_zh/description_zh/excludes_zh):
ALTER TABLE tours
  ADD COLUMN IF NOT EXISTS summary_en        text,
  ADD COLUMN IF NOT EXISTS description_en    text,
  ADD COLUMN IF NOT EXISTS excludes_en       text[]       DEFAULT '{}';

-- Yêu cầu PostgREST nạp lại schema cache ngay (Supabase thường tự làm sau DDL,
-- lệnh này đảm bảo chắc chắn không phải chờ):
NOTIFY pgrst, 'reload schema';
