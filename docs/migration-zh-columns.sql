-- Migration: Thêm cột tiếng Trung (ZH) vào bảng tours
-- Chạy trên Supabase SQL Editor: https://supabase.com/dashboard → SQL Editor

ALTER TABLE tours
  ADD COLUMN IF NOT EXISTS name_zh            TEXT,
  ADD COLUMN IF NOT EXISTS highlights_zh      TEXT[],
  ADD COLUMN IF NOT EXISTS includes_zh        TEXT[],
  ADD COLUMN IF NOT EXISTS itinerary_zh       JSONB,
  ADD COLUMN IF NOT EXISTS summary_zh         TEXT,
  ADD COLUMN IF NOT EXISTS description_zh     TEXT,
  ADD COLUMN IF NOT EXISTS excludes_zh        TEXT[],
  ADD COLUMN IF NOT EXISTS zh_translation_status TEXT DEFAULT 'pending',
  ADD COLUMN IF NOT EXISTS zh_translated_at   TIMESTAMPTZ;

-- Kiểm tra kết quả
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'tours'
  AND column_name LIKE '%_zh%'
ORDER BY column_name;
