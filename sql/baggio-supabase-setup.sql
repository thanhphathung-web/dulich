-- ============================================================
-- BAGGIO TRAVEL — Supabase SQL Setup
-- Paste vào SQL Editor của Supabase và nhấn Run
-- ============================================================

-- ── EXTENSIONS ──────────────────────────────────────────────
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ── ENUMS ───────────────────────────────────────────────────
CREATE TYPE tour_status      AS ENUM ('DRAFT','ACTIVE','PAUSED','ARCHIVED');
CREATE TYPE booking_status   AS ENUM ('PENDING','CONFIRMED','ONGOING','COMPLETED','CANCELLED');
CREATE TYPE payment_status   AS ENUM ('PENDING','SUCCESS','FAILED','CANCELLED','REFUNDED');
CREATE TYPE payment_provider AS ENUM ('MOMO','VNPAY','BANK_TRANSFER','CASH');
CREATE TYPE guide_status     AS ENUM ('ACTIVE','ON_TOUR','ON_LEAVE','INACTIVE');
CREATE TYPE room_type        AS ENUM ('STANDARD','DELUXE','SUITE');
CREATE TYPE user_role        AS ENUM ('CUSTOMER','STAFF','GUIDE','ADMIN');

-- ── USERS ───────────────────────────────────────────────────
CREATE TABLE users (
  id             UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  email          TEXT        NOT NULL UNIQUE,
  full_name      TEXT        NOT NULL,
  phone          TEXT        UNIQUE,
  password_hash  TEXT,
  role           user_role   NOT NULL DEFAULT 'CUSTOMER',
  avatar_url     TEXT,
  loyalty_points INTEGER     NOT NULL DEFAULT 0,
  is_verified    BOOLEAN     NOT NULL DEFAULT false,
  is_active      BOOLEAN     NOT NULL DEFAULT true,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at     TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ── TOURS ───────────────────────────────────────────────────
CREATE TABLE tours (
  id               UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  name             TEXT        NOT NULL,
  slug             TEXT        NOT NULL UNIQUE,
  destination      TEXT        NOT NULL,
  region           TEXT        NOT NULL CHECK (region IN ('north','central','south')),
  duration_days    SMALLINT    NOT NULL,
  duration_nights  SMALLINT    NOT NULL,
  base_price       BIGINT      NOT NULL,
  child_price_pct  SMALLINT    NOT NULL DEFAULT 70,
  max_pax          SMALLINT    NOT NULL DEFAULT 20,
  min_pax          SMALLINT    NOT NULL DEFAULT 1,
  status           tour_status NOT NULL DEFAULT 'ACTIVE',
  cover_image      TEXT,
  images           TEXT[]      DEFAULT '{}',
  includes         JSONB       NOT NULL DEFAULT '{}',
  itinerary        JSONB       NOT NULL DEFAULT '[]',
  highlights       TEXT[]      DEFAULT '{}',
  meeting_point    TEXT,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at       TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX tours_destination_idx ON tours (destination, status);
CREATE INDEX tours_region_idx      ON tours (region, status);
CREATE INDEX tours_price_idx       ON tours (base_price);

-- ── TOUR SCHEDULES ──────────────────────────────────────────
CREATE TABLE tour_schedules (
  id               UUID           PRIMARY KEY DEFAULT gen_random_uuid(),
  tour_id          UUID           NOT NULL REFERENCES tours(id) ON DELETE CASCADE,
  depart_date      DATE           NOT NULL,
  return_date      DATE           NOT NULL,
  total_slots      SMALLINT       NOT NULL,
  available_slots  SMALLINT       NOT NULL,
  price_override   BIGINT,
  status           TEXT           NOT NULL DEFAULT 'OPEN'
                                  CHECK (status IN ('OPEN','FULL','CANCELLED','COMPLETED')),
  created_at       TIMESTAMPTZ    NOT NULL DEFAULT NOW()
);

CREATE INDEX schedules_tour_date_idx ON tour_schedules (tour_id, depart_date);

-- ── GUIDES ──────────────────────────────────────────────────
CREATE TABLE guides (
  id              UUID         PRIMARY KEY DEFAULT gen_random_uuid(),
  full_name       TEXT         NOT NULL,
  phone           TEXT         NOT NULL UNIQUE,
  email           TEXT         UNIQUE,
  avatar_url      TEXT,
  languages       TEXT[]       NOT NULL DEFAULT '{vi}',
  specialties     TEXT[]       DEFAULT '{}',
  regions         TEXT[]       NOT NULL DEFAULT '{}',
  bio             TEXT,
  rating_avg      NUMERIC(3,2) NOT NULL DEFAULT 0,
  total_tours     INTEGER      NOT NULL DEFAULT 0,
  status          guide_status NOT NULL DEFAULT 'ACTIVE',
  daily_rate      BIGINT       NOT NULL DEFAULT 500000,
  license_number  TEXT         UNIQUE,
  joined_at       DATE         NOT NULL DEFAULT CURRENT_DATE,
  created_at      TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
  updated_at      TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);

-- ── BOOKINGS ────────────────────────────────────────────────
CREATE TABLE bookings (
  id               UUID           PRIMARY KEY DEFAULT gen_random_uuid(),
  booking_ref      TEXT           NOT NULL UNIQUE,
  user_id          UUID           REFERENCES users(id),
  tour_id          UUID           NOT NULL REFERENCES tours(id),
  schedule_id      UUID           REFERENCES tour_schedules(id),
  guide_id         UUID           REFERENCES guides(id),
  -- Thông tin khách (cho khách không đăng ký)
  guest_name       TEXT,
  guest_email      TEXT,
  guest_phone      TEXT           NOT NULL,
  -- Đặt tour
  status           booking_status NOT NULL DEFAULT 'PENDING',
  payment_status   payment_status NOT NULL DEFAULT 'PENDING',
  adult_count      SMALLINT       NOT NULL DEFAULT 1 CHECK (adult_count >= 1),
  child_count      SMALLINT       NOT NULL DEFAULT 0,
  infant_count     SMALLINT       NOT NULL DEFAULT 0,
  room_type        room_type      NOT NULL DEFAULT 'STANDARD',
  total_price      BIGINT         NOT NULL,
  deposit_amount   BIGINT         NOT NULL,
  deposit_paid     BIGINT         NOT NULL DEFAULT 0,
  special_requests TEXT,
  cancel_reason    TEXT,
  confirmed_at     TIMESTAMPTZ,
  cancelled_at     TIMESTAMPTZ,
  created_at       TIMESTAMPTZ    NOT NULL DEFAULT NOW(),
  updated_at       TIMESTAMPTZ    NOT NULL DEFAULT NOW()
);

CREATE INDEX bookings_guest_phone_idx ON bookings (guest_phone);
CREATE INDEX bookings_status_idx      ON bookings (status, payment_status);
CREATE INDEX bookings_tour_idx        ON bookings (tour_id);
CREATE INDEX bookings_created_idx     ON bookings (created_at DESC);

-- ── PAYMENTS ────────────────────────────────────────────────
CREATE TABLE payments (
  id                   UUID             PRIMARY KEY DEFAULT gen_random_uuid(),
  booking_id           UUID             NOT NULL REFERENCES bookings(id),
  provider             payment_provider NOT NULL,
  payment_type         TEXT             NOT NULL DEFAULT 'DEPOSIT'
                                        CHECK (payment_type IN ('DEPOSIT','REMAINING','FULL','REFUND')),
  provider_request_id  TEXT             NOT NULL UNIQUE,
  provider_order_id    TEXT             UNIQUE,
  provider_trans_id    TEXT             UNIQUE,
  amount               BIGINT           NOT NULL,
  status               payment_status   NOT NULL DEFAULT 'PENDING',
  webhook_payload      JSONB,
  failure_reason       TEXT,
  paid_at              TIMESTAMPTZ,
  expires_at           TIMESTAMPTZ,
  created_at           TIMESTAMPTZ      NOT NULL DEFAULT NOW(),
  updated_at           TIMESTAMPTZ      NOT NULL DEFAULT NOW()
);

CREATE INDEX payments_booking_idx ON payments (booking_id);

-- ── REVIEWS ─────────────────────────────────────────────────
CREATE TABLE reviews (
  id            UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  booking_id    UUID        UNIQUE REFERENCES bookings(id),
  tour_id       UUID        NOT NULL REFERENCES tours(id),
  guide_id      UUID        REFERENCES guides(id),
  reviewer_name TEXT        NOT NULL,
  rating        SMALLINT    NOT NULL CHECK (rating BETWEEN 1 AND 5),
  guide_rating  SMALLINT    CHECK (guide_rating BETWEEN 1 AND 5),
  comment       TEXT,
  photos        TEXT[]      DEFAULT '{}',
  is_published  BOOLEAN     NOT NULL DEFAULT false,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX reviews_tour_idx ON reviews (tour_id, is_published);

-- ── TOUR ADDONS ─────────────────────────────────────────────
CREATE TABLE tour_addons (
  id          UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  tour_id     UUID        REFERENCES tours(id) ON DELETE CASCADE,
  name        TEXT        NOT NULL,
  description TEXT,
  price       BIGINT      NOT NULL,
  price_unit  TEXT        NOT NULL DEFAULT 'per_person'
                          CHECK (price_unit IN ('per_person','per_group','per_night')),
  icon        TEXT,
  is_active   BOOLEAN     NOT NULL DEFAULT true
);

-- ── AUTO UPDATE updated_at ───────────────────────────────────
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN NEW.updated_at = NOW(); RETURN NEW; END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_users_updated    BEFORE UPDATE ON users    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
CREATE TRIGGER trg_tours_updated    BEFORE UPDATE ON tours    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
CREATE TRIGGER trg_guides_updated   BEFORE UPDATE ON guides   FOR EACH ROW EXECUTE FUNCTION set_updated_at();
CREATE TRIGGER trg_bookings_updated BEFORE UPDATE ON bookings FOR EACH ROW EXECUTE FUNCTION set_updated_at();
CREATE TRIGGER trg_payments_updated BEFORE UPDATE ON payments FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- ============================================================
-- SEED DATA — DỮ LIỆU MẪU THẬT
-- ============================================================

-- ── TOURS ───────────────────────────────────────────────────
INSERT INTO tours (name, slug, destination, region, duration_days, duration_nights, base_price, max_pax, cover_image, highlights, meeting_point, includes, itinerary) VALUES

('Hội An – Phố Cổ & Ẩm Thực 3N2Đ',
 'hoi-an-pho-co-am-thuc-3n2d',
 'Hội An', 'central', 3, 2, 2800000, 20,
 'https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80',
 ARRAY['Tham quan phố cổ Hội An về đêm','Lớp học nấu ăn truyền thống','Làng rau Trà Quế','Biển Mỹ Khê, Cửa Đại'],
 'Sảnh KS Vinpearl Hội An, 06:30 ngày 1',
 '{"flights": true, "hotel": "3-star", "guide": true, "transfer": true, "meals": ["breakfast x2"], "entrance_fees": true}'::jsonb,
 '[{"day":1,"title":"Bay vào Đà Nẵng – Nhận phòng Hội An","activities":["Đón sân bay Đà Nẵng","Di chuyển về Hội An (30 phút)","Check-in khách sạn 3★","Tự do khám phá phố đêm Hội An"]},{"day":2,"title":"Phố Cổ – Làng Rau – Nấu Ăn","activities":["Sáng: Tham quan Chùa Cầu, Nhà Cổ Phùng Hưng","Trưa: Lớp học nấu ăn tại Làng rau Trà Quế","Chiều: Thuê xe đạp dạo quanh làng","Tối: Thả đèn hoa đăng trên sông Hoài"]},{"day":3,"title":"Biển Cửa Đại – Bay về","activities":["Sáng: Tắm biển Cửa Đại","Trưa: Ăn hải sản tươi tại chợ Hội An","Chiều: Ra sân bay Đà Nẵng, bay về"]}]'::jsonb),

('Hạ Long – Du Thuyền Cao Cấp 5N4Đ',
 'ha-long-du-thuyen-cao-cap-5n4d',
 'Hạ Long', 'north', 5, 4, 5900000, 30,
 'https://images.unsplash.com/photo-1557400128-9a431afe5ff5?w=800&q=80',
 ARRAY['Ngủ đêm trên du thuyền 4★ giữa Vịnh','Chèo kayak khám phá hang động','Câu mực đêm','Tham quan Hang Sửng Sốt','Thăm làng chài Vũng Viêng'],
 'Sảnh khách sạn Mường Thanh Hà Nội, 07:00 ngày 1',
 '{"flights": true, "hotel": "4-star-cruise", "guide": true, "transfer": true, "meals": ["breakfast x4","lunch x3","dinner x2"], "activities": ["kayak","cave","fishing","cooking_class"]}'::jsonb,
 '[{"day":1,"title":"Hà Nội – Hạ Long – Lên Tàu","activities":["Xe bus đón tại HN, khởi hành 07:00","Nhận phòng tàu, ăn trưa giữa Vịnh","Tham quan Hang Sửng Sốt","Chèo kayak, tắm biển","Câu mực đêm, BBQ trên boong"]},{"day":2,"title":"Vũng Viêng – Làng Chài","activities":["Yoga buổi sáng trên boong","Thăm làng chài Vũng Viêng bằng kayak","Thăm quan hang Luồn","Lớp học nấu ăn trên tàu","Ngắm hoàng hôn"]},{"day":3,"title":"Hang Thien Cung – Đảo Ti Tốp","activities":["Tham quan Hang Thiên Cung","Leo núi đảo Ti Tốp ngắm toàn cảnh Vịnh","Tắm biển tự do","Trở về tàu nghỉ ngơi"]},{"day":4,"title":"Hà Nội – Về Nhà","activities":["Sáng: Tai chi trên boong","Trả phòng, ăn sáng","Xe bus về HN","Trả khách tại điểm đón"]}]'::jsonb),

('Phú Quốc Premium Resort 7N6Đ',
 'phu-quoc-premium-resort-7n6d',
 'Phú Quốc', 'south', 7, 6, 15500000, 10,
 'https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=800&q=80',
 ARRAY['Resort 5★ beachfront Vinpearl Phú Quốc','Vé máy bay hạng thương gia','Lặn biển ngắm san hô','Câu cá & nướng hải sản tươi','Safari Vinpearl','Spa truyền thống 90 phút'],
 'Sân bay Tân Sơn Nhất, ga đến nội địa, 08:00',
 '{"flights": "business_class", "hotel": "5-star-beachfront", "guide": true, "transfer": "limousine", "meals": "all_inclusive", "activities": ["diving","fishing","safari","spa","kayak","sunset_cruise"]}'::jsonb,
 '[{"day":1,"title":"Bay Phú Quốc – Check-in Resort","activities":["Đón tại sân bay bằng xe limousine","Check-in Vinpearl Resort & Spa 5★","Ăn trưa tại nhà hàng resort","Tự do tắm biển buổi chiều","Welcome dinner tại beach restaurant"]},{"day":2,"title":"Lặn Biển & Khám Phá Đảo","activities":["Sáng: Lặn biển ngắm san hô cùng hướng dẫn viên có bằng PADI","Trưa: Buffet hải sản trên tàu","Chiều: Câu cá, nướng hải sản ngay trên biển","Tối: Tự do"]},{"day":3,"title":"Vinpearl Safari & Spa","activities":["Sáng: Tham quan Vinpearl Safari (vườn thú bán hoang dã lớn nhất VN)","Chiều: Spa truyền thống 90 phút","Tối: Sunset Cruise + dinner"]},{"day":4,"title":"Bắc Đảo – Làng Chài Gành Dầu","activities":["Khám phá bờ Bắc hoang sơ","Tham quan làng chài Gành Dầu","Mua hải sản khô đặc sản","Chiều tự do tại resort"]},{"day":5,"title":"Grand World & Show đêm","activities":["Tham quan Grand World Phú Quốc","Xem show Kiss of the Sea (nếu có lịch)","Tự do mua sắm và ăn tối"]},{"day":6,"title":"Ngày Tự Do","activities":["Tự do hoàn toàn tại resort","Hồ bơi, kayak, bãi biển","Check-out, bay về"]},{"day":7,"title":"Bay về Sài Gòn","activities":["Trả phòng, ăn sáng","Xe đưa ra sân bay","Bay về TP.HCM"]}]'::jsonb),

('Sa Pa – Trekking & Bản Làng 3N2Đ',
 'sa-pa-trekking-ban-lang-3n2d',
 'Sa Pa', 'north', 3, 2, 2900000, 15,
 'https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=800&q=80',
 ARRAY['Trekking ruộng bậc thang mùa vàng','Homestay tại bản H''Mông','Chợ phiên Bắc Hà (cuối tuần)','Đỉnh Fansipan – Nóc nhà Đông Dương','Ẩm thực địa phương: Thắng cố, cá suối'],
 'Ga Hà Nội (tàu đêm), 21:30 ngày 0',
 '{"transport": "overnight_train", "hotel": "3-star-sapa", "guide": true, "transfer": true, "meals": ["breakfast x2","dinner x1"], "activities": ["trekking","homestay","fansipan_cable"]}'::jsonb,
 '[{"day":1,"title":"Tàu đêm – Sa Pa – Bản Cát Cát","activities":["21:30: Lên tàu đêm tại Ga Hà Nội","06:00: Đến Lào Cai, xe lên Sa Pa","Sáng: Nhận phòng, ăn sáng","Trưa: Tham quan Bản Cát Cát – bản H''Mông truyền thống","Tối: Ngủ lại Sa Pa"]},{"day":2,"title":"Trekking – Ruộng Bậc Thang – Homestay","activities":["Sáng: Trekking từ Sa Pa xuống bản Lao Chải","Ngắm ruộng bậc thang mùa vàng","Trưa: Ăn trưa tại bản","Chiều: Tiếp tục trek lên Tả Van","Tối: Homestay tại bản người Giáy, ăn tối cùng gia đình"]},{"day":3,"title":"Fansipan – Về Hà Nội","activities":["Sáng: Lên đỉnh Fansipan bằng cáp treo (3.143m)","Trưa: Ăn đặc sản địa phương","Chiều: Xe về Lào Cai, tàu về HN"]}]'::jsonb),

('Đà Lạt – Thành Phố Sương Mù 3N2Đ',
 'da-lat-thanh-pho-suong-mu-3n2d',
 'Đà Lạt', 'south', 3, 2, 1900000, 20,
 'https://images.unsplash.com/photo-1555400038-63f5ba517a47?w=800&q=80',
 ARRAY['Đà Lạt về đêm lung linh','Vườn hoa Vạn Thành','Thác Datanla – zipline','Langbiang – trekking ngắm rừng thông','Cà phê vườn & rượu vang địa phương'],
 'Sân bay Liên Khương, sau khi hạ cánh',
 '{"flights": true, "hotel": "3-star", "guide": true, "transfer": true, "meals": ["breakfast x2"], "entrance_fees": true}'::jsonb,
 '[{"day":1,"title":"Bay Đà Lạt – Nhận Phòng","activities":["Đón sân bay Liên Khương","Nhận phòng khách sạn 3★ trung tâm","Chiều: Chợ Đêm Đà Lạt, dạo hồ Xuân Hương","Tối: Thưởng thức nem nướng, bánh tráng nướng"]},{"day":2,"title":"Thác – Hoa – Núi","activities":["Sáng: Thác Datanla + zipline qua thác","Trưa: Vườn hoa Vạn Thành 7 hecta","Chiều: Leo Langbiang (2.167m) ngắm Đà Lạt từ trên cao","Tối: Cà phê vườn, wine Đà Lạt"]},{"day":3,"title":"Làng Cù Lần – Bay Về","activities":["Sáng: Làng Cù Lần (Crazy House)","Tham quan ga xe lửa Đà Lạt cổ kính","Trưa: Ăn lẩu bò Đà Lạt","Chiều: Ra sân bay, bay về"]}]'::jsonb),

('Nha Trang – Biển & Đảo 4N3Đ',
 'nha-trang-bien-dao-4n3d',
 'Nha Trang', 'central', 4, 3, 3800000, 25,
 'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=800&q=80',
 ARRAY['Tour 4 đảo bằng tàu gỗ truyền thống','Lặn biển ngắm san hô','Tắm bùn khoáng Trăm Trứng','Vinpearl Land vui chơi giải trí','Hải sản tươi sống tại chợ Nha Trang'],
 'Sân bay Cam Ranh, sau khi hạ cánh',
 '{"flights": true, "hotel": "4-star", "guide": true, "transfer": true, "meals": ["breakfast x3","lunch x1"], "activities": ["island_tour","snorkeling","mud_bath","vinpearl"]}'::jsonb,
 '[{"day":1,"title":"Bay Nha Trang – Vinpearl","activities":["Đón sân bay Cam Ranh","Nhận phòng KS 4★ gần biển","Chiều: Tham quan Vinpearl Land (tàu cáp biển dài nhất VN)","Tối: Phố đêm, hải sản tươi"]},{"day":2,"title":"Tour 4 Đảo","activities":["06:30: Xuất phát bến tàu, tour 4 đảo","Đảo Mun: Lặn biển ngắm san hô","Đảo Miễu: Tham quan, tắm biển","Ăn trưa hải sản nổi trên biển","Chiều: Tắm bùn khoáng Trăm Trứng"]},{"day":3,"title":"Tự Do & Chợ Đêm","activities":["Ngày tự do tắm biển hoặc thuê xe máy khám phá","Chiều: Tháp Chàm Po Nagar (di tích Chăm 8 thế kỷ)","Tối: Chợ Đầm mua đặc sản khô"]},{"day":4,"title":"Bay Về","activities":["Sáng tự do","Trưa: Ăn bún cá Nha Trang","Chiều: Ra sân bay, bay về"]}]'::jsonb);

-- ── GUIDES ──────────────────────────────────────────────────
INSERT INTO guides (full_name, phone, email, languages, specialties, regions, bio, rating_avg, total_tours, daily_rate, license_number) VALUES

('Trần Hoài Nam', '0901234567', 'hoainam.guide@gmail.com',
 ARRAY['vi','en','ja'],
 ARRAY['culture','history','food'],
 ARRAY['central','north'],
 'HDV 8 năm kinh nghiệm, chuyên tour Hội An và Hạ Long. Từng dẫn đoàn khách Nhật, Mỹ, Úc. Biết nhiều góc chụp ảnh đẹp ít người biết tại Hội An.',
 4.9, 142, 800000, 'HDV-QN-001234'),

('Nguyễn Linh Chi', '0912345678', 'linchi.guide@gmail.com',
 ARRAY['vi','en','ko'],
 ARRAY['beach','island','diving'],
 ARRAY['south','central'],
 'Chuyên gia tour biển đảo với chứng chỉ PADI Divemaster. 6 năm dẫn tour Phú Quốc, Nha Trang. Nhiệt tình, vui vẻ, biết chụp ảnh dưới nước.',
 4.8, 98, 900000, 'HDV-KG-005678'),

('Phan Hữu Tài', '0923456789', 'huutai.guide@gmail.com',
 ARRAY['vi','en','fr'],
 ARRAY['trekking','mountain','culture'],
 ARRAY['north'],
 'Dân bản địa Sa Pa, am hiểu sâu về văn hóa H''Mông, Dao, Giáy. 10 năm dẫn trek Fansipan và ruộng bậc thang. Biết nhiều nhà homestay chất lượng.',
 4.9, 210, 700000, 'HDV-LC-009012'),

('Lê Thu Hương', '0934567890', 'thuhuong.guide@gmail.com',
 ARRAY['vi','en','zh'],
 ARRAY['food','culture','city'],
 ARRAY['south','central'],
 'Chuyên tour ẩm thực và văn hóa. Tốt nghiệp ĐH Du lịch Hà Nội. Dẫn tour cho khách Trung Quốc, Đài Loan 5 năm. Hiểu tâm lý khách châu Á rất tốt.',
 5.0, 176, 750000, 'HDV-HCM-012345'),

('Võ Kim Thành', '0945678901', 'kimthanh.guide@gmail.com',
 ARRAY['vi','en'],
 ARRAY['adventure','cycling','motorbiking'],
 ARRAY['central','north'],
 'Chuyên tour phượt xe máy và đạp xe xuyên Việt. Từng hoàn thành Hà Nội – Sài Gòn bằng xe đạp. Đam mê chia sẻ văn hóa đường trường với khách.',
 4.7, 89, 650000, 'HDV-DN-015678');

-- ── TOUR SCHEDULES (lịch 3 tháng tới) ──────────────────────
DO $$
DECLARE
  hoi_an_id    UUID;
  ha_long_id   UUID;
  phu_quoc_id  UUID;
  sa_pa_id     UUID;
  da_lat_id    UUID;
  nha_trang_id UUID;
BEGIN
  SELECT id INTO hoi_an_id    FROM tours WHERE slug = 'hoi-an-pho-co-am-thuc-3n2d';
  SELECT id INTO ha_long_id   FROM tours WHERE slug = 'ha-long-du-thuyen-cao-cap-5n4d';
  SELECT id INTO phu_quoc_id  FROM tours WHERE slug = 'phu-quoc-premium-resort-7n6d';
  SELECT id INTO sa_pa_id     FROM tours WHERE slug = 'sa-pa-trekking-ban-lang-3n2d';
  SELECT id INTO da_lat_id    FROM tours WHERE slug = 'da-lat-thanh-pho-suong-mu-3n2d';
  SELECT id INTO nha_trang_id FROM tours WHERE slug = 'nha-trang-bien-dao-4n3d';

  -- Hội An — mỗi tuần 1 lịch
  INSERT INTO tour_schedules (tour_id, depart_date, return_date, total_slots, available_slots) VALUES
  (hoi_an_id, CURRENT_DATE + 7,  CURRENT_DATE + 9,  20, 14),
  (hoi_an_id, CURRENT_DATE + 14, CURRENT_DATE + 16, 20, 18),
  (hoi_an_id, CURRENT_DATE + 21, CURRENT_DATE + 23, 20, 20),
  (hoi_an_id, CURRENT_DATE + 28, CURRENT_DATE + 30, 20, 20),
  (hoi_an_id, CURRENT_DATE + 35, CURRENT_DATE + 37, 20, 20);

  -- Hạ Long — 2 tuần 1 lịch
  INSERT INTO tour_schedules (tour_id, depart_date, return_date, total_slots, available_slots) VALUES
  (ha_long_id, CURRENT_DATE + 10, CURRENT_DATE + 14, 30, 22),
  (ha_long_id, CURRENT_DATE + 24, CURRENT_DATE + 28, 30, 30),
  (ha_long_id, CURRENT_DATE + 38, CURRENT_DATE + 42, 30, 28);

  -- Phú Quốc — hàng tháng
  INSERT INTO tour_schedules (tour_id, depart_date, return_date, total_slots, available_slots, price_override) VALUES
  (phu_quoc_id, CURRENT_DATE + 14, CURRENT_DATE + 20, 10, 6,  17000000),
  (phu_quoc_id, CURRENT_DATE + 45, CURRENT_DATE + 51, 10, 10, 15500000);

  -- Sa Pa
  INSERT INTO tour_schedules (tour_id, depart_date, return_date, total_slots, available_slots) VALUES
  (sa_pa_id, CURRENT_DATE + 5,  CURRENT_DATE + 7,  15, 9),
  (sa_pa_id, CURRENT_DATE + 19, CURRENT_DATE + 21, 15, 15),
  (sa_pa_id, CURRENT_DATE + 33, CURRENT_DATE + 35, 15, 15);

  -- Đà Lạt
  INSERT INTO tour_schedules (tour_id, depart_date, return_date, total_slots, available_slots) VALUES
  (da_lat_id, CURRENT_DATE + 6,  CURRENT_DATE + 8,  20, 12),
  (da_lat_id, CURRENT_DATE + 13, CURRENT_DATE + 15, 20, 20),
  (da_lat_id, CURRENT_DATE + 27, CURRENT_DATE + 29, 20, 18);

  -- Nha Trang
  INSERT INTO tour_schedules (tour_id, depart_date, return_date, total_slots, available_slots) VALUES
  (nha_trang_id, CURRENT_DATE + 8,  CURRENT_DATE + 11, 25, 17),
  (nha_trang_id, CURRENT_DATE + 22, CURRENT_DATE + 25, 25, 25),
  (nha_trang_id, CURRENT_DATE + 36, CURRENT_DATE + 39, 25, 25);
END $$;

-- ── TOUR ADDONS ─────────────────────────────────────────────
INSERT INTO tour_addons (tour_id, name, description, price, icon) 
SELECT id, 'Xe đón sân bay riêng', 'Xe riêng biển hiệu tên, đón tận cửa ra', 300000, '🚗' FROM tours WHERE slug = 'hoi-an-pho-co-am-thuc-3n2d';

INSERT INTO tour_addons (tour_id, name, description, price, icon)
SELECT id, 'HDV cá nhân riêng', 'HDV dành riêng cho nhóm, linh hoạt lịch', 800000, '🧑‍💼' FROM tours;

INSERT INTO tour_addons (tour_id, name, description, price, icon)
SELECT id, 'Photographer 4 tiếng', 'Photographer chuyên nghiệp, giao 50 ảnh edit', 1200000, '📸' FROM tours;

INSERT INTO tour_addons (tour_id, name, description, price, icon)
SELECT id, 'Bảo hiểm du lịch', 'Tai nạn, y tế, huỷ chuyến, mất hành lý', 250000, '🛡️' FROM tours;

INSERT INTO tour_addons (tour_id, name, description, price, icon)
SELECT id, 'Spa & Massage 90 phút', 'Spa truyền thống Việt tại resort', 600000, '💆' FROM tours;

-- ── REVIEWS MẪU ─────────────────────────────────────────────
INSERT INTO reviews (tour_id, reviewer_name, rating, guide_rating, comment, is_published)
SELECT id, 'Nguyễn Thanh Hà', 5, 5,
 'Tour Hội An tuyệt vời! Hướng dẫn viên Nam rất nhiệt tình, dẫn đi ăn những quán ngon không có trên Google Maps. Lịch trình vừa đủ, không quá dày. Chắc chắn sẽ đặt lại chuyến Sa Pa!',
 true FROM tours WHERE slug = 'hoi-an-pho-co-am-thuc-3n2d';

INSERT INTO reviews (tour_id, reviewer_name, rating, guide_rating, comment, is_published)
SELECT id, 'Trần Minh Tuấn', 5, 5,
 'Du thuyền Hạ Long 5 sao luôn! Tàu đẹp, đồ ăn ngon, chèo kayak vào hang rất thú vị. HDV Linh Chi nói tiếng Anh tốt, tận tình với cả nhóm gia đình có trẻ nhỏ. Giá hợp lý hơn tự đặt riêng.',
 true FROM tours WHERE slug = 'ha-long-du-thuyen-cao-cap-5n4d';

INSERT INTO reviews (tour_id, reviewer_name, rating, guide_rating, comment, is_published)
SELECT id, 'Phạm Lan Anh', 5, 5,
 'Phú Quốc resort đẳng cấp, xe limousine đón tận nơi, ăn buffet all-inclusive không lo gì cả. Lặn biển ngắm san hô là trải nghiệm nhớ đời. Worth every penny!',
 true FROM tours WHERE slug = 'phu-quoc-premium-resort-7n6d';

INSERT INTO reviews (tour_id, reviewer_name, rating, guide_rating, comment, is_published)
SELECT id, 'Lê Văn Đức', 5, 5,
 'Trek Sa Pa với HDV Tài là lựa chọn đúng đắn nhất! Bác ấy là người bản địa, kể chuyện về người H''Mông rất cuốn. Homestay sạch sẽ, gia đình chủ nhà rất hiếu khách. Ruộng bậc thang mùa vàng đẹp như tranh.',
 true FROM tours WHERE slug = 'sa-pa-trekking-ban-lang-3n2d';

INSERT INTO reviews (tour_id, reviewer_name, rating, guide_rating, comment, is_published)
SELECT id, 'Vũ Thị Mai', 4, 5,
 'Đà Lạt 3 ngày 2 đêm vừa đủ khám phá các điểm chính. Thác Datanla zipline thú vị, vườn hoa Vạn Thành đẹp tuyệt. Chỉ tiếc trời hơi mưa ngày 2 nhưng cũng là đặc trưng của Đà Lạt thôi!',
 true FROM tours WHERE slug = 'da-lat-thanh-pho-suong-mu-3n2d';

-- ── ADMIN USER ───────────────────────────────────────────────
INSERT INTO users (email, full_name, phone, role, is_verified) VALUES
('admin@baggiotravel.com', 'Baggio Admin', '0900000000', 'ADMIN', true);

-- ============================================================
-- KIỂM TRA DỮ LIỆU
-- ============================================================
SELECT 'tours'    AS tbl, COUNT(*) FROM tours    UNION ALL
SELECT 'guides',          COUNT(*) FROM guides   UNION ALL
SELECT 'schedules',       COUNT(*) FROM tour_schedules UNION ALL
SELECT 'addons',          COUNT(*) FROM tour_addons    UNION ALL
SELECT 'reviews',         COUNT(*) FROM reviews;
