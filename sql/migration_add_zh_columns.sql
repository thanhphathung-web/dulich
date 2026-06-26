-- ============================================================
-- Migration: Thêm cột tiếng Trung (ZH) vào bảng tours
-- ============================================================
-- Chạy trên Supabase Dashboard → SQL Editor → New query → Run
-- URL: https://supabase.com/dashboard/project/lfnlezfphwjtdunyungi/sql/new
-- ============================================================

ALTER TABLE tours
  ADD COLUMN IF NOT EXISTS name_zh               TEXT,
  ADD COLUMN IF NOT EXISTS summary_zh            TEXT,
  ADD COLUMN IF NOT EXISTS description_zh        TEXT,
  ADD COLUMN IF NOT EXISTS highlights_zh         TEXT[]      DEFAULT '{}',
  ADD COLUMN IF NOT EXISTS itinerary_zh          JSONB,
  ADD COLUMN IF NOT EXISTS includes_zh           JSONB,
  ADD COLUMN IF NOT EXISTS excludes_zh           TEXT[]      DEFAULT '{}',
  ADD COLUMN IF NOT EXISTS zh_translation_status TEXT        NOT NULL DEFAULT 'pending'
                             CHECK (zh_translation_status IN ('pending','auto','reviewed','manual')),
  ADD COLUMN IF NOT EXISTS zh_translated_at      TIMESTAMPTZ;

-- Kiểm tra kết quả — chạy cùng lúc hoặc riêng sau ALTER
SELECT column_name, data_type, column_default
FROM   information_schema.columns
WHERE  table_name = 'tours'
  AND  column_name LIKE '%_zh%'
ORDER  BY column_name;
