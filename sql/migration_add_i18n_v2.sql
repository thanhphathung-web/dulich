-- ============================================================
-- Migration v2: add_i18n_columns
-- Viết lại theo schema thực tế của bảng tours
-- Chạy từng BLOCK trên Supabase SQL Editor
-- ============================================================

-- ────────────────────────────────────────
-- BƯỚC 1: Rename cột VI (name → name_vi, etc.)
-- ────────────────────────────────────────
ALTER TABLE tours RENAME COLUMN name        TO name_vi;
ALTER TABLE tours RENAME COLUMN highlights  TO highlights_vi;
ALTER TABLE tours RENAME COLUMN itinerary   TO itinerary_vi;
ALTER TABLE tours RENAME COLUMN includes    TO includes_vi;

-- ────────────────────────────────────────
-- BƯỚC 2: Thêm cột EN + translation tracking
-- ────────────────────────────────────────
ALTER TABLE tours
  ADD COLUMN IF NOT EXISTS name_en          TEXT,
  ADD COLUMN IF NOT EXISTS highlights_en    TEXT[]  DEFAULT '{}',
  ADD COLUMN IF NOT EXISTS itinerary_en     JSONB,
  ADD COLUMN IF NOT EXISTS includes_en      JSONB,
  ADD COLUMN IF NOT EXISTS translation_status TEXT NOT NULL DEFAULT 'pending'
                           CHECK (translation_status IN ('pending','auto','reviewed','manual')),
  ADD COLUMN IF NOT EXISTS translated_at    TIMESTAMPTZ;

-- ────────────────────────────────────────
-- KIỂM TRA
-- ────────────────────────────────────────
-- SELECT column_name, data_type FROM information_schema.columns
-- WHERE table_name = 'tours' ORDER BY ordinal_position;
