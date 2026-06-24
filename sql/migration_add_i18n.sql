-- ============================================================
-- Migration: add_i18n_columns
-- Baggio Travel — Thêm cột đa ngôn ngữ VI/EN
-- Chạy trực tiếp trên Supabase SQL Editor
-- SAFE: chỉ ADD COLUMN, không xóa dữ liệu cũ
-- ============================================================

-- ────────────────────────────────────────
-- BƯỚC 1: Rename cột cũ → _vi
-- (chạy từng câu, kiểm tra trước khi chạy tiếp)
-- ────────────────────────────────────────

-- Kiểm tra cột hiện tại của bảng tours trước khi rename
-- SELECT column_name FROM information_schema.columns WHERE table_name = 'tours';

-- Nếu cột hiện tại tên là "name" → rename thành "name_vi"
ALTER TABLE tours RENAME COLUMN name        TO name_vi;
ALTER TABLE tours RENAME COLUMN summary     TO summary_vi;
ALTER TABLE tours RENAME COLUMN description TO description_vi;
ALTER TABLE tours RENAME COLUMN itinerary   TO itinerary_vi;
ALTER TABLE tours RENAME COLUMN includes    TO includes_vi;
ALTER TABLE tours RENAME COLUMN excludes    TO excludes_vi;
ALTER TABLE tours RENAME COLUMN highlights  TO highlights_vi;

-- Blog posts
ALTER TABLE blog_posts RENAME COLUMN title   TO title_vi;
ALTER TABLE blog_posts RENAME COLUMN excerpt TO excerpt_vi;
ALTER TABLE blog_posts RENAME COLUMN content TO content_vi;

-- ────────────────────────────────────────
-- BƯỚC 2: Thêm cột EN (nullable — chưa dịch thì NULL)
-- ────────────────────────────────────────

-- Tours: text fields
ALTER TABLE tours
  ADD COLUMN IF NOT EXISTS name_en        TEXT,
  ADD COLUMN IF NOT EXISTS summary_en     TEXT,
  ADD COLUMN IF NOT EXISTS description_en TEXT,
  ADD COLUMN IF NOT EXISTS itinerary_en   JSONB,
  ADD COLUMN IF NOT EXISTS includes_en    TEXT[]  DEFAULT '{}',
  ADD COLUMN IF NOT EXISTS excludes_en    TEXT[]  DEFAULT '{}',
  ADD COLUMN IF NOT EXISTS highlights_en  TEXT[]  DEFAULT '{}';

-- Tours: translation tracking
ALTER TABLE tours
  ADD COLUMN IF NOT EXISTS translation_status TEXT    NOT NULL DEFAULT 'pending'
                           CHECK (translation_status IN ('pending','auto','reviewed','manual')),
  ADD COLUMN IF NOT EXISTS translated_at      TIMESTAMPTZ,
  ADD COLUMN IF NOT EXISTS translation_note   TEXT;

-- Blog posts
ALTER TABLE blog_posts
  ADD COLUMN IF NOT EXISTS title_en     TEXT,
  ADD COLUMN IF NOT EXISTS excerpt_en   TEXT,
  ADD COLUMN IF NOT EXISTS content_en   TEXT,
  ADD COLUMN IF NOT EXISTS translation_status TEXT NOT NULL DEFAULT 'pending'
                           CHECK (translation_status IN ('pending','auto','reviewed','manual')),
  ADD COLUMN IF NOT EXISTS translated_at TIMESTAMPTZ;

-- Reviews: chỉ thêm detected_lang, không dịch nội dung
ALTER TABLE reviews
  ADD COLUMN IF NOT EXISTS detected_lang TEXT NOT NULL DEFAULT 'vi'
                           CHECK (detected_lang IN ('vi','en'));

-- ────────────────────────────────────────
-- BƯỚC 3: Index để query theo ngôn ngữ nhanh hơn
-- (full-text search nếu cần sau này)
-- ────────────────────────────────────────

-- Index cho filter tour theo destination + published (dùng ở trang chủ)
CREATE INDEX IF NOT EXISTS idx_tours_destination
  ON tours (destination, is_published);

-- Index tìm tour chưa dịch (dùng ở CMS để batch translate)
CREATE INDEX IF NOT EXISTS idx_tours_translation_status
  ON tours (translation_status)
  WHERE translation_status = 'pending';

CREATE INDEX IF NOT EXISTS idx_blog_translation_status
  ON blog_posts (translation_status)
  WHERE translation_status = 'pending';

-- ────────────────────────────────────────
-- BƯỚC 4: View tiện lợi cho frontend
-- Query 1 view, tự lấy đúng ngôn ngữ theo param
-- ────────────────────────────────────────

-- View: tours_i18n — trả về tên/mô tả theo ngôn ngữ được truyền vào
-- Dùng: SELECT * FROM tours_i18n('en') WHERE is_published = true
CREATE OR REPLACE FUNCTION tours_i18n(lang TEXT DEFAULT 'vi')
RETURNS TABLE (
  id                UUID,
  slug              TEXT,
  featured_image    TEXT,
  duration_days     INT,
  max_pax           INT,
  base_price        NUMERIC,
  discount_price    NUMERIC,
  category          TEXT,
  destination       TEXT,
  difficulty        TEXT,
  is_published      BOOLEAN,
  is_featured       BOOLEAN,
  name              TEXT,   -- trả về name_vi hoặc name_en
  summary           TEXT,
  description       TEXT,
  itinerary         JSONB,
  includes          TEXT[],
  excludes          TEXT[],
  highlights        TEXT[],
  translation_status TEXT
) AS $$
  SELECT
    id, slug, featured_image, duration_days, max_pax,
    base_price, discount_price, category, destination,
    difficulty::TEXT, is_published, is_featured,

    -- Fallback về VI nếu EN chưa có
    CASE WHEN lang = 'en' AND name_en IS NOT NULL
         THEN name_en ELSE name_vi END           AS name,
    CASE WHEN lang = 'en' AND summary_en IS NOT NULL
         THEN summary_en ELSE summary_vi END     AS summary,
    CASE WHEN lang = 'en' AND description_en IS NOT NULL
         THEN description_en ELSE description_vi END AS description,
    CASE WHEN lang = 'en' AND itinerary_en IS NOT NULL
         THEN itinerary_en ELSE itinerary_vi END AS itinerary,
    CASE WHEN lang = 'en' AND array_length(includes_en, 1) > 0
         THEN includes_en ELSE includes_vi END   AS includes,
    CASE WHEN lang = 'en' AND array_length(excludes_en, 1) > 0
         THEN excludes_en ELSE excludes_vi END   AS excludes,
    CASE WHEN lang = 'en' AND array_length(highlights_en, 1) > 0
         THEN highlights_en ELSE highlights_vi END AS highlights,
    translation_status

  FROM tours
$$ LANGUAGE sql STABLE;

-- View tương tự cho blog
CREATE OR REPLACE FUNCTION blog_posts_i18n(lang TEXT DEFAULT 'vi')
RETURNS TABLE (
  id          UUID,
  slug        TEXT,
  cover_image TEXT,
  category    TEXT,
  tags        TEXT[],
  is_published BOOLEAN,
  published_at TIMESTAMPTZ,
  title       TEXT,
  excerpt     TEXT,
  content     TEXT,
  translation_status TEXT
) AS $$
  SELECT
    id, slug, cover_image, category, tags, is_published, published_at,
    CASE WHEN lang = 'en' AND title_en IS NOT NULL
         THEN title_en ELSE title_vi END       AS title,
    CASE WHEN lang = 'en' AND excerpt_en IS NOT NULL
         THEN excerpt_en ELSE excerpt_vi END   AS excerpt,
    CASE WHEN lang = 'en' AND content_en IS NOT NULL
         THEN content_en ELSE content_vi END   AS content,
    translation_status
  FROM blog_posts
$$ LANGUAGE sql STABLE;

-- ────────────────────────────────────────
-- BƯỚC 5: Row Level Security (nếu dùng Supabase RLS)
-- ────────────────────────────────────────

-- Anon user chỉ đọc được tour đã published
ALTER TABLE tours ENABLE ROW LEVEL SECURITY;

CREATE POLICY "public_read_published_tours"
  ON tours FOR SELECT
  USING (is_published = true);

CREATE POLICY "admin_full_access_tours"
  ON tours FOR ALL
  USING (auth.jwt() ->> 'role' = 'ADMIN');

-- Blog tương tự
ALTER TABLE blog_posts ENABLE ROW LEVEL SECURITY;

CREATE POLICY "public_read_published_blogs"
  ON blog_posts FOR SELECT
  USING (is_published = true);

CREATE POLICY "admin_full_access_blogs"
  ON blog_posts FOR ALL
  USING (auth.jwt() ->> 'role' = 'ADMIN');

-- ────────────────────────────────────────
-- KIỂM TRA SAU KHI CHẠY
-- ────────────────────────────────────────
/*
  -- Xem cột tours mới:
  SELECT column_name, data_type, is_nullable
  FROM information_schema.columns
  WHERE table_name = 'tours'
  ORDER BY ordinal_position;

  -- Test function:
  SELECT id, name, summary, translation_status
  FROM tours_i18n('en')
  WHERE is_published = true
  LIMIT 5;

  -- Xem tour chưa dịch:
  SELECT id, name_vi, translation_status
  FROM tours
  WHERE translation_status = 'pending';
*/
