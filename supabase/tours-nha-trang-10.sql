-- ═══════════════════════════════════════════════════════════════
-- 10 TOUR NHA TRANG cho khách nước ngoài — slug 10051 → 10060
-- Chạy trong Supabase → SQL Editor. Idempotent: mỗi INSERT có
-- WHERE NOT EXISTS theo slug — chạy lặp không tạo trùng.
-- Giá base_price là ƯỚC TÍNH theo mặt bằng thị trường 2026 (cách làm
-- chủ web đã duyệt ở batch TP.HCM, Hà Nội & Đà Nẵng). Ảnh Unsplash placeholder.
-- Cuối file: gọi extend_day_tour_schedules() để có lịch hàng ngày ngay.
-- ═══════════════════════════════════════════════════════════════

-- Kiểm tra trước: các slug sắp thêm đã tồn tại chưa (mong đợi 0 dòng)
select slug, status from public.tours where slug ~ '-1005[0-9]$' or slug ~ '-10060$';

-- ─────────────────────────────────────────────────────────────
-- 1. Tour 4 đảo Hòn Mun — lặn ngắm san hô
-- ─────────────────────────────────────────────────────────────
insert into public.tours
  (name_vi, name_en, slug, destination, region, duration_days, duration_nights,
   base_price, child_price_pct, max_pax, min_pax, status,
   cover_image, images, highlights_vi, highlights_en,
   itinerary_vi, itinerary_en, includes_vi, includes_en,
   description, description_en, summary_en, meta_description,
   notes, excludes_en, meeting_point, depart_time,
   tour_type, difficulty, guide_language, cancel_policy, service_class,
   tags, translation_status)
select
  'Nha Trang – Tour 4 Đảo: Hòn Mun, Hòn Một & Lặn Ngắm San Hô',
  'Nha Trang Four Islands Tour with Snorkeling at Hon Mun',
  'tour-4-dao-hon-mun-10051',
  'Nha Trang', 'central', 1, 0,
  650000, 75, 30, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1544550581-5f7ceaf7f992?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1544550581-5f7ceaf7f992?w=800&q=80','https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&q=80'],
  ARRAY[
    'Vịnh Nha Trang — một trong những vịnh đẹp nhất thế giới',
    'Lặn ống thở ngắm san hô ở khu bảo tồn biển Hòn Mun',
    'Tắm biển Bãi Tranh nước trong xanh trên Hòn Một',
    'Tiệc trái cây và giao lưu nhạc "bar nổi" giữa biển',
    'Ăn trưa hải sản trên du thuyền'
  ],
  ARRAY[
    'Nha Trang Bay — one of the most beautiful bays in the world',
    'Snorkel the coral reefs of the Hon Mun marine reserve',
    'Swim at clear-water Bai Tranh beach on Hon Mot island',
    'Fruit party and the famous floating-bar music session',
    'Seafood lunch on board the cruise boat'
  ],
  '[{"day":1,"title":"Nha Trang – 4 đảo trên vịnh – Nha Trang","activities":["08:00 Xe đón khách tại khách sạn ra cảng Cầu Đá","08:45 Du thuyền rời bến, ngắm toàn cảnh vịnh Nha Trang","09:30 Hòn Mun: lặn ống thở ngắm san hô khu bảo tồn biển","11:00 Hòn Một: tắm biển Bãi Tranh, chơi thể thao nước","12:30 Ăn trưa hải sản trên thuyền","13:30 Tiệc trái cây và ban nhạc bar nổi giữa biển","15:00 Hòn Tằm/Bãi Sỏi thư giãn tự do","16:00 Thuyền về cảng, xe đưa về khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Nha Trang – four islands on the bay – Nha Trang","activities":["08:00 Hotel pickup, transfer to Cau Da port","08:45 Cruise departs, panoramic views of Nha Trang Bay","09:30 Hon Mun: snorkel the coral reefs of the marine reserve","11:00 Hon Mot: swim at Bai Tranh beach and try water sports","12:30 Seafood lunch on board","13:30 Fruit party and the floating-bar band at sea","15:00 Free relaxation at Hon Tam / Bai Soi","16:00 Boat returns to port, transfer back to hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Vé các đảo + phí bảo tồn biển","boat":"Du thuyền + đồ lặn ống thở","meals":"Ăn trưa hải sản trên thuyền"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Island tickets and marine reserve fee","boat":"Cruise boat and snorkel gear","meals":"Seafood lunch on board"}'::jsonb,
  'Vịnh Nha Trang lọt top những vịnh biển đẹp nhất hành tinh, và tour 4 đảo là cách kinh điển để cảm nhận: lặn ống thở giữa rạn san hô Hòn Mun, tắm biển Bãi Tranh nước xanh như ngọc, ăn hải sản trên du thuyền rồi cụng ly cùng "bar nổi" giữa biển. Trọn gói xe đón, vé đảo và đồ lặn — chỉ việc lên thuyền.',
  'Nha Trang Bay ranks among the most beautiful bays on the planet, and the four-islands cruise is the classic way to feel it: snorkel the Hon Mun coral reefs, swim in the jade water of Bai Tranh, feast on seafood aboard the boat and toast at the famous floating bar. Pickup, island tickets and snorkel gear all included — just hop on.',
  'Classic Nha Trang four-islands cruise with coral snorkeling at Hon Mun, beach swimming, seafood lunch and the floating bar.',
  'Tour 4 đảo Nha Trang: du thuyền vịnh, lặn ngắm san hô Hòn Mun, tắm Bãi Tranh, ăn trưa hải sản, bar nổi. Trọn gói xe đón, vé đảo, đồ lặn.',
  '["Đồ uống ngoài chương trình","Thuê thiết bị thể thao nước có động cơ","Tip cho HDV và thuyền viên"]'::jsonb,
  '["Drinks outside the program","Motorized water-sport equipment rental","Tips for guide and crew"]'::jsonb,
  'Đón tại khách sạn trung tâm Nha Trang', '08:00',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["4 đảo","hòn mun","lặn san hô","du thuyền"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'tour-4-dao-hon-mun-10051');

-- ─────────────────────────────────────────────────────────────
-- 2. VinWonders Vinpearl + cáp treo vượt biển
-- ─────────────────────────────────────────────────────────────
insert into public.tours
  (name_vi, name_en, slug, destination, region, duration_days, duration_nights,
   base_price, child_price_pct, max_pax, min_pax, status,
   cover_image, images, highlights_vi, highlights_en,
   itinerary_vi, itinerary_en, includes_vi, includes_en,
   description, description_en, summary_en, meta_description,
   notes, excludes_en, meeting_point, depart_time,
   tour_type, difficulty, guide_language, cancel_policy, service_class,
   tags, translation_status)
select
  'Nha Trang – VinWonders Vinpearl & Cáp Treo Vượt Biển 1 Ngày',
  'VinWonders Vinpearl Theme Park and Sea Cable Car Day Tour',
  'vinwonders-vinpearl-cap-treo-10052',
  'Nha Trang', 'central', 1, 0,
  1250000, 75, 30, 1, 'ACTIVE',
  'https://images.unsplash.com/photo-1513889961551-628c1e5e2ee9?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1513889961551-628c1e5e2ee9?w=800&q=80'],
  ARRAY[
    'Cáp treo vượt biển dài 3.320m — một trong những tuyến dài nhất thế giới',
    'Công viên giải trí VinWonders trên đảo Hòn Tre',
    'Thủy cung, công viên nước và khu trò chơi cảm giác mạnh',
    'Bãi biển riêng cát trắng trong khuôn viên',
    'Vé vào cổng trọn gói tất cả trò chơi'
  ],
  ARRAY[
    'A 3,320m over-the-sea cable car — one of the longest in the world',
    'VinWonders theme park on Hon Tre island',
    'Aquarium, water park and thrill rides',
    'A private white-sand beach inside the park',
    'All-inclusive entry ticket covering every ride'
  ],
  '[{"day":1,"title":"Nha Trang – Hòn Tre – VinWonders – Nha Trang","activities":["08:30 Xe đón khách tại khách sạn ra ga cáp treo","09:00 Cáp treo vượt biển 3.320m sang đảo Hòn Tre","09:30 Khu vui chơi: tàu lượn siêu tốc, tháp rơi, đu quay","11:00 Thủy cung: đường hầm cá mập, biểu diễn nàng tiên cá","12:30 Tự do ăn trưa trong công viên (chi phí tự túc)","13:30 Công viên nước: đường trượt, sông lười, hồ tạo sóng","15:30 Tắm biển bãi riêng hoặc khu vườn thượng uyển","17:00 Cáp treo về đất liền, xe đưa về khách sạn"]}]'::jsonb,
  '[{"day":1,"title":"Nha Trang – Hon Tre – VinWonders – Nha Trang","activities":["08:30 Hotel pickup, transfer to the cable car station","09:00 Cross the 3,320m sea cable car to Hon Tre island","09:30 Rides zone: roller coaster, drop tower, carousel","11:00 Aquarium: shark tunnel and mermaid show","12:30 Free lunch inside the park (own expense)","13:30 Water park: slides, lazy river, wave pool","15:30 Private beach or the hilltop garden","17:00 Cable car back to the mainland, transfer to hotel"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Vé cáp treo khứ hồi + vé VinWonders trọn gói"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Round-trip cable car and all-inclusive VinWonders ticket"}'::jsonb,
  'Vượt biển bằng cáp treo dài hơn 3km để đặt chân lên "đảo thiên đường" Hòn Tre — nơi có công viên giải trí VinWonders với thủy cung, công viên nước, khu cảm giác mạnh và cả bãi biển riêng. Tour lo trọn vé cáp treo khứ hồi và vé vào cổng chơi tất cả trò, cùng xe đón tận khách sạn. Điểm đến số một cho gia đình có trẻ nhỏ.',
  'Glide over the sea on a cable car more than 3km long to reach the "paradise island" of Hon Tre — home to VinWonders theme park with its aquarium, water park, thrill rides and a private beach. The tour covers the round-trip cable car, the all-inclusive entry ticket and hotel pickup. The number-one pick for families with children.',
  'Full-day VinWonders Vinpearl tour with the over-the-sea cable car, aquarium, water park and all-rides ticket.',
  'Tour VinWonders Vinpearl Nha Trang: cáp treo vượt biển 3.320m, thủy cung, công viên nước, trò cảm giác mạnh. Trọn gói vé, đón khách sạn.',
  '["Ăn trưa trong công viên","Đồ uống và dịch vụ tự chọn","Tip cho HDV và tài xế"]'::jsonb,
  '["Lunch inside the park","Drinks and optional services","Tips for guide and driver"]'::jsonb,
  'Đón tại khách sạn trung tâm Nha Trang', '08:30',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["vinwonders","vinpearl","cáp treo","hòn tre"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'vinwonders-vinpearl-cap-treo-10052');

-- ─────────────────────────────────────────────────────────────
-- 3. City tour: Tháp Bà Ponagar, tắm bùn khoáng
-- ─────────────────────────────────────────────────────────────
insert into public.tours
  (name_vi, name_en, slug, destination, region, duration_days, duration_nights,
   base_price, child_price_pct, max_pax, min_pax, status,
   cover_image, images, highlights_vi, highlights_en,
   itinerary_vi, itinerary_en, includes_vi, includes_en,
   description, description_en, summary_en, meta_description,
   notes, excludes_en, meeting_point, depart_time,
   tour_type, difficulty, guide_language, cancel_policy, service_class,
   tags, translation_status)
select
  'Nha Trang – City Tour: Tháp Bà Ponagar & Tắm Bùn Khoáng',
  'Nha Trang City Tour with Ponagar Towers and Mud Bath',
  'city-tour-thap-ba-tam-bun-10053',
  'Nha Trang', 'central', 1, 0,
  750000, 75, 24, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1528127269322-539801943592?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1528127269322-539801943592?w=800&q=80'],
  ARRAY[
    'Tháp Bà Ponagar — quần thể đền tháp Chăm Pa nghìn năm',
    'Ngâm mình trong bồn bùn khoáng nóng thư giãn cơ thể',
    'Chùa Long Sơn với tượng Phật trắng khổng lồ trên đồi',
    'Nhà thờ Núi (Nhà thờ Đá) kiến trúc Gothic Pháp',
    'Ngắm toàn cảnh thành phố biển từ trên cao'
  ],
  ARRAY[
    'Ponagar Towers — a thousand-year-old Cham temple complex',
    'Soak in a warm mineral mud bath to relax the body',
    'Long Son Pagoda with its giant white Buddha on the hill',
    'The Stone Church, a French Gothic landmark',
    'Panoramic views over the seaside city'
  ],
  '[{"day":1,"title":"Vòng quanh thành phố biển Nha Trang","activities":["08:00 Xe đón khách tại khách sạn","08:30 Tháp Bà Ponagar: đền tháp Chăm cổ, xem múa Chăm","09:45 Chùa Long Sơn: tượng Phật trắng và tượng Phật nằm trên đồi","10:45 Nhà thờ Núi (Nhà thờ Đá) kiến trúc Gothic","12:00 Ăn trưa đặc sản Nha Trang: bún cá, nem nướng","13:30 Khu tắm bùn khoáng: ngâm bùn, tắm khoáng nóng, hồ bơi","16:00 Xe đưa về khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Around the seaside city of Nha Trang","activities":["08:00 Hotel pickup","08:30 Ponagar Towers: ancient Cham temples and a Cham dance show","09:45 Long Son Pagoda: the white Buddha and reclining Buddha on the hill","10:45 The Stone Church (Mountain Church) in Gothic style","12:00 Nha Trang specialty lunch: fish noodle soup, grilled pork rolls","13:30 Mud-bath resort: mineral mud soak, hot spring, swimming pool","16:00 Transfer back to hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Vé Tháp Bà + tắm bùn khoáng","meals":"Ăn trưa đặc sản Nha Trang"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Ponagar ticket and mud-bath entry","meals":"Nha Trang specialty lunch"}'::jsonb,
  'Nha Trang không chỉ có biển: buổi sáng khám phá đền tháp Chăm Pa nghìn tuổi Tháp Bà Ponagar, viếng tượng Phật trắng chùa Long Sơn và nhà thờ Đá kiểu Gothic; buổi chiều thả mình trong bồn bùn khoáng nóng nổi tiếng để phục hồi sau những ngày rong ruổi. Một ngày cân bằng giữa văn hóa và thư giãn, có xe đón tận nơi.',
  'Nha Trang is more than a beach: spend the morning at the thousand-year-old Ponagar Cham towers, the white Buddha of Long Son Pagoda and the Gothic Stone Church; then in the afternoon sink into the famous warm mineral mud baths to recover from your travels. A day that balances culture and relaxation, with hotel pickup included.',
  'City tour blending the Ponagar Cham towers, Long Son Pagoda, the Stone Church and a relaxing mineral mud bath.',
  'City tour Nha Trang: Tháp Bà Ponagar, chùa Long Sơn, nhà thờ Đá, tắm bùn khoáng nóng, ăn trưa đặc sản. Trọn gói vé và xe đón khách sạn.',
  '["Đồ uống ngoài chương trình","Dịch vụ spa nâng cấp tại khu tắm bùn","Tip cho HDV và tài xế"]'::jsonb,
  '["Drinks outside the program","Upgraded spa services at the mud-bath resort","Tips for guide and driver"]'::jsonb,
  'Đón tại khách sạn trung tâm Nha Trang', '08:00',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["city tour","tháp bà","tắm bùn","long sơn"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'city-tour-thap-ba-tam-bun-10053');

-- ─────────────────────────────────────────────────────────────
-- 4. Đảo Bình Hưng & Bình Ba — thiên đường tôm hùm
-- ─────────────────────────────────────────────────────────────
insert into public.tours
  (name_vi, name_en, slug, destination, region, duration_days, duration_nights,
   base_price, child_price_pct, max_pax, min_pax, status,
   cover_image, images, highlights_vi, highlights_en,
   itinerary_vi, itinerary_en, includes_vi, includes_en,
   description, description_en, summary_en, meta_description,
   notes, excludes_en, meeting_point, depart_time,
   tour_type, difficulty, guide_language, cancel_policy, service_class,
   tags, translation_status)
select
  'Nha Trang – Đảo Bình Hưng: Thiên Đường Tôm Hùm & Biển Xanh',
  'Binh Hung Island Day Trip from Nha Trang: Lobster Paradise',
  'dao-binh-hung-tom-hum-10054',
  'Nha Trang', 'central', 1, 0,
  1050000, 75, 24, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1505228395891-9a51e7e86bf6?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1505228395891-9a51e7e86bf6?w=800&q=80'],
  ARRAY[
    'Đảo Bình Hưng hoang sơ — "đảo tôm hùm" của Khánh Hòa',
    'Bãi Kinh, Hòn Chuối nước trong vắt để lặn ngắm san hô',
    'Thưởng thức tôm hùm và hải sản tươi giá gốc trên đảo',
    'Ngọn hải đăng và những bãi đá độc đáo bên biển',
    'Cung đường ven biển Bình Tiên – Núi Chúa tuyệt đẹp'
  ],
  ARRAY[
    'Untouched Binh Hung island — the "lobster island" of Khanh Hoa',
    'Bai Kinh and Hon Chuoi with crystal water for snorkeling',
    'Fresh lobster and seafood at island prices',
    'A lighthouse and dramatic rock formations by the sea',
    'The stunning Binh Tien – Nui Chua coastal road'
  ],
  '[{"day":1,"title":"Nha Trang – Bình Hưng – Nha Trang","activities":["07:00 Xe đón khách tại khách sạn, đi cung đường ven biển Bình Tiên","09:00 Xuống cano/thuyền ra đảo Bình Hưng","09:30 Lặn ống thở ngắm san hô tại Bãi Kinh và Hòn Chuối","11:30 Tham quan ngọn hải đăng và bãi đá trứng","12:30 Ăn trưa hải sản trên đảo (tôm hùm tính riêng)","14:00 Tắm biển, chèo sup hoặc thư giãn bãi Nhà Cũ","15:30 Thuyền về đất liền, xe đưa về Nha Trang","17:30 Về đến khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Nha Trang – Binh Hung – Nha Trang","activities":["07:00 Hotel pickup, drive the Binh Tien coastal road","09:00 Board a speedboat to Binh Hung island","09:30 Snorkel the coral at Bai Kinh and Hon Chuoi","11:30 Visit the lighthouse and the egg-rock beach","12:30 Seafood lunch on the island (lobster charged separately)","14:00 Swim, paddle a SUP or relax at Nha Cu beach","15:30 Boat back to the mainland, drive to Nha Trang","17:30 Drop off at your hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"boat":"Cano/thuyền ra đảo + đồ lặn ống thở","meals":"Ăn trưa hải sản (tôm hùm tự chọn)"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"boat":"Speedboat and snorkel gear","meals":"Seafood lunch (lobster optional)"}'::jsonb,
  'Còn hoang sơ hơn hẳn các đảo trung tâm, Bình Hưng được dân phượt gọi là "đảo tôm hùm": nước biển trong đến mức nhìn thấy san hô từ trên thuyền, hải sản tươi rói giá gốc và cung đường ven biển Bình Tiên đẹp nghẹt thở trên đường ra đảo. Một ngày trốn khỏi phố xá để lặn, tắm biển và ăn tôm hùm đúng nghĩa.',
  'Wilder than the central islands, Binh Hung is nicknamed the "lobster island" by backpackers: water so clear you can see coral from the boat, fresh seafood at local prices and the breathtaking Binh Tien coastal road on the way out. A full day escaping the city to snorkel, swim and eat lobster the real way.',
  'Day trip to unspoiled Binh Hung island with snorkeling, a scenic coastal drive and fresh island seafood.',
  'Tour đảo Bình Hưng từ Nha Trang: đảo tôm hùm hoang sơ, lặn ngắm san hô Bãi Kinh, cung đường ven biển Bình Tiên, ăn trưa hải sản. Đón khách sạn.',
  '["Tôm hùm và hải sản gọi thêm","Đồ uống ngoài chương trình","Thuê SUP/thiết bị lặn nâng cấp","Tip cho HDV và thuyền viên"]'::jsonb,
  '["Lobster and extra seafood orders","Drinks outside the program","SUP or upgraded diving gear rental","Tips for guide and crew"]'::jsonb,
  'Đón tại khách sạn trung tâm Nha Trang', '07:00',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["bình hưng","tôm hùm","đảo","lặn san hô"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'dao-binh-hung-tom-hum-10054');

-- ─────────────────────────────────────────────────────────────
-- 5. Đảo Điệp Sơn — con đường giữa biển
-- ─────────────────────────────────────────────────────────────
insert into public.tours
  (name_vi, name_en, slug, destination, region, duration_days, duration_nights,
   base_price, child_price_pct, max_pax, min_pax, status,
   cover_image, images, highlights_vi, highlights_en,
   itinerary_vi, itinerary_en, includes_vi, includes_en,
   description, description_en, summary_en, meta_description,
   notes, excludes_en, meeting_point, depart_time,
   tour_type, difficulty, guide_language, cancel_policy, service_class,
   tags, translation_status)
select
  'Nha Trang – Đảo Điệp Sơn: Con Đường Đi Bộ Giữa Biển',
  'Diep Son Island Tour: The Walking Path Across the Sea',
  'dao-diep-son-con-duong-giua-bien-10055',
  'Nha Trang', 'central', 1, 0,
  1050000, 75, 24, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800&q=80'],
  ARRAY[
    'Con đường cát nổi giữa biển nối 3 hòn đảo — độc nhất Việt Nam',
    'Đi bộ trên mặt nước khi thủy triều rút',
    'Vịnh Vân Phong nước xanh biếc, bãi cát trắng mịn',
    'Lặn ngắm san hô và tắm biển vắng người',
    'Trải nghiệm "sống ảo" nổi tiếng mạng xã hội'
  ],
  ARRAY[
    'A sandbar path across the sea linking three islets — unique in Vietnam',
    'Walk on the water when the tide recedes',
    'Van Phong Bay with turquoise water and fine white sand',
    'Snorkel the coral and swim on quiet beaches',
    'The famous social-media walking-path experience'
  ],
  '[{"day":1,"title":"Nha Trang – Điệp Sơn – Nha Trang","activities":["06:30 Xe đón khách tại khách sạn, đi Vạn Ninh (60km)","08:00 Xuống cano ra đảo Điệp Sơn trên vịnh Vân Phong","08:30 Đi bộ trên con đường cát nổi giữa biển (canh thủy triều)","10:00 Lặn ống thở, chèo sup, tắm biển bãi vắng","12:00 Ăn trưa hải sản trên đảo","13:30 Tự do chụp ảnh, thư giãn dưới hàng dừa","15:00 Cano về đất liền, xe đưa về Nha Trang","16:30 Về đến khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Nha Trang – Diep Son – Nha Trang","activities":["06:30 Hotel pickup, drive to Van Ninh (60km)","08:00 Speedboat to Diep Son island on Van Phong Bay","08:30 Walk the sandbar path across the sea (tide-timed)","10:00 Snorkel, paddle a SUP and swim on empty beaches","12:00 Seafood lunch on the island","13:30 Free photo time and rest under the coconut palms","15:00 Speedboat back, drive to Nha Trang","16:30 Drop off at your hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"boat":"Cano ra đảo + đồ lặn ống thở","meals":"Ăn trưa hải sản"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"boat":"Speedboat and snorkel gear","meals":"Seafood lunch"}'::jsonb,
  'Giữa vịnh Vân Phong có một dải cát kỳ lạ nổi lên khi thủy triều rút, nối liền ba hòn đảo — bạn có thể đi bộ giữa biển, nước hai bên chỉ đến đầu gối. Điệp Sơn là điểm "sống ảo" nổi tiếng nhưng vẫn còn hoang sơ: bãi cát trắng, hàng dừa nghiêng và làn nước xanh biếc để lặn ngắm san hô. Tour canh đúng giờ thủy triều để bạn không lỡ khoảnh khắc.',
  'In the middle of Van Phong Bay a strange sandbar rises when the tide recedes, linking three islets — you can walk across the sea with water only knee-deep on either side. Diep Son is a famous photo spot yet still unspoiled: white sand, leaning coconut palms and turquoise water for snorkeling. The tour is timed to the tide so you never miss the moment.',
  'Day tour to Diep Son island to walk the sandbar path across the sea, snorkel and swim on Van Phong Bay.',
  'Tour Điệp Sơn từ Nha Trang: con đường đi bộ giữa biển, vịnh Vân Phong, lặn ngắm san hô, ăn trưa hải sản. Canh thủy triều, đón khách sạn.',
  '["Đồ uống ngoài chương trình","Thuê SUP/kayak nâng cấp","Tip cho HDV và thuyền viên","Con đường cát phụ thuộc thủy triều theo ngày"]'::jsonb,
  '["Drinks outside the program","Upgraded SUP or kayak rental","Tips for guide and crew","The sandbar path depends on the daily tide"]'::jsonb,
  'Đón tại khách sạn trung tâm Nha Trang', '06:30',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["điệp sơn","con đường giữa biển","vân phong","đảo"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'dao-diep-son-con-duong-giua-bien-10055');

-- ─────────────────────────────────────────────────────────────
-- 6. Lặn biển Hòn Mun ngắm san hô (scuba)
-- ─────────────────────────────────────────────────────────────
insert into public.tours
  (name_vi, name_en, slug, destination, region, duration_days, duration_nights,
   base_price, child_price_pct, max_pax, min_pax, status,
   cover_image, images, highlights_vi, highlights_en,
   itinerary_vi, itinerary_en, includes_vi, includes_en,
   description, description_en, summary_en, meta_description,
   notes, excludes_en, meeting_point, depart_time,
   tour_type, difficulty, guide_language, cancel_policy, service_class,
   tags, translation_status)
select
  'Nha Trang – Lặn Biển Hòn Mun: Khám Phá San Hô Cùng HLV',
  'Nha Trang Scuba Diving at Hon Mun with a Certified Instructor',
  'lan-bien-hon-mun-san-ho-10056',
  'Nha Trang', 'central', 1, 0,
  1450000, 80, 12, 1, 'ACTIVE',
  'https://images.unsplash.com/photo-1682687982501-1e58ab814714?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1682687982501-1e58ab814714?w=800&q=80'],
  ARRAY[
    'Lặn bình dưỡng khí tại khu bảo tồn biển Hòn Mun',
    'Dành cho cả người chưa biết bơi — có HLV kèm 1-1',
    '2 lượt lặn ngắm rạn san hô và đàn cá nhiệt đới',
    'Đầy đủ thiết bị lặn đạt chuẩn PADI',
    'Nhóm nhỏ, an toàn, có ảnh/video dưới nước (tự chọn)'
  ],
  ARRAY[
    'Scuba diving in the Hon Mun marine protected area',
    'Open to non-swimmers — one-on-one instructor guidance',
    'Two dives over coral reefs and tropical fish',
    'Full PADI-standard diving equipment',
    'Small group, safe, optional underwater photos/video'
  ],
  '[{"day":1,"title":"Nha Trang – lặn biển Hòn Mun – Nha Trang","activities":["07:30 Xe đón khách tại khách sạn ra cảng","08:15 Thuyền ra khu bảo tồn biển Hòn Mun","08:45 Hướng dẫn kỹ thuật lặn và an toàn cùng HLV","09:30 Lượt lặn 1: làm quen, ngắm san hô nông","11:00 Nghỉ ngơi, ăn nhẹ trên thuyền","11:45 Lượt lặn 2: khám phá rạn san hô sâu hơn","13:00 Ăn trưa trên thuyền, thuyền về cảng","14:30 Xe đưa về khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Nha Trang – Hon Mun diving – Nha Trang","activities":["07:30 Hotel pickup, transfer to the port","08:15 Boat to the Hon Mun marine protected area","08:45 Diving briefing and safety training with the instructor","09:30 Dive 1: get comfortable, explore shallow coral","11:00 Rest and a snack on board","11:45 Dive 2: explore the deeper reef","13:00 Lunch on board, boat returns to port","14:30 Transfer back to hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"activities":"2 lượt lặn có HLV kèm + toàn bộ thiết bị lặn","meals":"Ăn nhẹ và ăn trưa trên thuyền"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"activities":"Two guided dives plus all diving equipment","meals":"Snack and lunch on board"}'::jsonb,
  'Hòn Mun là khu bảo tồn biển đầu tiên của Việt Nam, nơi rạn san hô và cá nhiệt đới phong phú bậc nhất. Bạn không cần biết bơi hay có bằng lặn: huấn luyện viên kèm sát 1-1, hướng dẫn kỹ thuật trên thuyền rồi cùng bạn xuống hai lượt lặn khám phá thế giới dưới nước. Nhóm nhỏ tối đa 12 khách để đảm bảo an toàn.',
  'Hon Mun is Vietnam''s first marine protected area, with some of the richest coral reefs and tropical fish in the country. You need not be a swimmer or hold a diving license: a one-on-one instructor briefs you on board, then guides you through two dives into the underwater world. Small groups of max 12 keep it safe.',
  'Guided Hon Mun scuba diving for beginners with two dives, full gear and one-on-one instruction.',
  'Tour lặn biển Hòn Mun Nha Trang: lặn bình khí khu bảo tồn, HLV kèm 1-1 cho cả người chưa biết bơi, 2 lượt lặn, đủ thiết bị. Đón khách sạn.',
  '["Ảnh/video dưới nước (thuê riêng)","Đồ uống ngoài chương trình","Tip cho HLV và thuyền viên","Không phù hợp người có bệnh tim mạch/hô hấp nặng"]'::jsonb,
  '["Underwater photos/video (rented separately)","Drinks outside the program","Tips for instructor and crew","Not suitable for serious heart or respiratory conditions"]'::jsonb,
  'Đón tại khách sạn trung tâm Nha Trang', '07:30',
  'day_tour', 'moderate', 'vi_en', 'flexible', 'premium',
  '["lặn biển","hòn mun","san hô","scuba"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'lan-bien-hon-mun-san-ho-10056');

-- ─────────────────────────────────────────────────────────────
-- 7. Thác Yang Bay — suối khoáng nóng & văn hóa Raglai
-- ─────────────────────────────────────────────────────────────
insert into public.tours
  (name_vi, name_en, slug, destination, region, duration_days, duration_nights,
   base_price, child_price_pct, max_pax, min_pax, status,
   cover_image, images, highlights_vi, highlights_en,
   itinerary_vi, itinerary_en, includes_vi, includes_en,
   description, description_en, summary_en, meta_description,
   notes, excludes_en, meeting_point, depart_time,
   tour_type, difficulty, guide_language, cancel_policy, service_class,
   tags, translation_status)
select
  'Nha Trang – Công Viên Thác Yang Bay: Suối Khoáng & Văn Hóa Raglai',
  'Yang Bay Waterfall Park: Hot Springs and Raglai Culture',
  'thac-yang-bay-suoi-khoang-10057',
  'Nha Trang', 'central', 1, 0,
  850000, 75, 30, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1432405972618-c60b0225b8f9?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1432405972618-c60b0225b8f9?w=800&q=80'],
  ARRAY[
    'Thác Yang Bay đổ giữa rừng nguyên sinh trên núi',
    'Ngâm suối khoáng nóng tự nhiên giữa thiên nhiên',
    'Xem biểu diễn cồng chiêng và nhạc dân tộc Raglai',
    'Trò chơi dân gian: đua heo, đua đà điểu vui nhộn',
    'Không khí mát lành, tránh xa nắng biển'
  ],
  ARRAY[
    'Yang Bay waterfall tumbling through primeval mountain forest',
    'Soak in natural hot mineral springs surrounded by nature',
    'Watch gong music and Raglai ethnic performances',
    'Folk games: the fun pig races and ostrich races',
    'Cool fresh air, a break from the beach sun'
  ],
  '[{"day":1,"title":"Nha Trang – Yang Bay – Nha Trang","activities":["08:00 Xe đón khách tại khách sạn, đi Khánh Vĩnh (45km)","09:15 Đến công viên Yang Bay giữa rừng núi","09:30 Tham quan thác Yang Bay và thác Ho Cho","10:30 Xem biểu diễn cồng chiêng, nhạc cụ dân tộc Raglai","11:15 Trò chơi dân gian: đua heo, đua đà điểu, câu cá sấu","12:30 Ăn trưa đặc sản núi rừng","14:00 Ngâm suối khoáng nóng tự nhiên thư giãn","15:30 Xe đưa về Nha Trang","16:45 Về đến khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Nha Trang – Yang Bay – Nha Trang","activities":["08:00 Hotel pickup, drive to Khanh Vinh (45km)","09:15 Arrive at Yang Bay park amid the mountain forest","09:30 Visit Yang Bay and Ho Cho waterfalls","10:30 Gong music and Raglai ethnic performances","11:15 Folk games: pig races, ostrich races, crocodile fishing","12:30 Mountain specialty lunch","14:00 Relax in the natural hot mineral springs","15:30 Drive back to Nha Trang","16:45 Drop off at your hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Vé công viên + suối khoáng nóng","meals":"Ăn trưa đặc sản núi rừng"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Park entry and hot spring","meals":"Mountain specialty lunch"}'::jsonb,
  'Khi đã chán nắng biển, hãy lên núi: cách Nha Trang 45km, công viên Yang Bay nằm giữa rừng nguyên sinh với thác nước đổ ào ào, suối khoáng nóng tự nhiên để ngâm mình thư giãn và những màn cồng chiêng, đua heo vui nhộn của người Raglai. Một ngày đổi gió mát lành cho cả gia đình, có xe đón tận khách sạn.',
  'When you tire of the beach sun, head for the hills: 45km from Nha Trang, Yang Bay park sits in primeval forest with roaring waterfalls, natural hot springs to soak in and the lively gong music and pig races of the Raglai people. A cool change of scene for the whole family, with hotel pickup included.',
  'Day trip to Yang Bay park with waterfalls, natural hot springs and Raglai ethnic culture in the mountains.',
  'Tour Thác Yang Bay từ Nha Trang: thác nước rừng núi, suối khoáng nóng, cồng chiêng Raglai, đua heo, ăn trưa đặc sản. Trọn gói vé, đón khách sạn.',
  '["Đồ uống ngoài chương trình","Trò chơi/dịch vụ có thu phí riêng trong công viên","Tip cho HDV và tài xế"]'::jsonb,
  '["Drinks outside the program","Separately charged games or services in the park","Tips for guide and driver"]'::jsonb,
  'Đón tại khách sạn trung tâm Nha Trang', '08:00',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["yang bay","thác","suối khoáng","raglai"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'thac-yang-bay-suoi-khoang-10057');

-- ─────────────────────────────────────────────────────────────
-- 8. Sông Cái — làng quê, chùa & thác Ba Hồ
-- ─────────────────────────────────────────────────────────────
insert into public.tours
  (name_vi, name_en, slug, destination, region, duration_days, duration_nights,
   base_price, child_price_pct, max_pax, min_pax, status,
   cover_image, images, highlights_vi, highlights_en,
   itinerary_vi, itinerary_en, includes_vi, includes_en,
   description, description_en, summary_en, meta_description,
   notes, excludes_en, meeting_point, depart_time,
   tour_type, difficulty, guide_language, cancel_policy, service_class,
   tags, translation_status)
select
  'Nha Trang – Sông Cái: Làng Quê, Làng Nghề & Thác Ba Hồ',
  'Cai River Countryside Tour with Craft Villages and Ba Ho Waterfall',
  'song-cai-lang-que-thac-ba-ho-10058',
  'Nha Trang', 'central', 1, 0,
  790000, 75, 20, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1470770841072-f978cf4d019e?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1470770841072-f978cf4d019e?w=800&q=80'],
  ARRAY[
    'Du thuyền trên sông Cái ngắm làng quê Khánh Hòa',
    'Ghé làng nghề: dệt chiếu, làm nón, nấu rượu, đan mây tre',
    'Thác Ba Hồ ba tầng hồ nước trong giữa rừng',
    'Nghe đờn ca tài tử Nam Bộ trên thuyền',
    'Trải nghiệm đời sống bản địa yên bình, ít khách du lịch'
  ],
  ARRAY[
    'Cruise the Cai River past the Khanh Hoa countryside',
    'Visit craft villages: mat weaving, conical hats, rice wine, rattan',
    'Ba Ho waterfall with three clear forest pools',
    'Live traditional southern folk music on board',
    'A peaceful taste of local life, away from the crowds'
  ],
  '[{"day":1,"title":"Nha Trang – sông Cái – thác Ba Hồ – Nha Trang","activities":["08:00 Xe đón khách tại khách sạn ra bến thuyền sông Cái","08:30 Du thuyền ngược sông, nghe đờn ca tài tử","09:15 Ghé làng nghề: xem dệt chiếu, làm nón lá, nấu rượu","10:30 Tham quan xưởng thủ công mây tre, mua quà lưu niệm","11:30 Ăn trưa đồng quê bên sông","13:30 Đến thác Ba Hồ: leo nhẹ, tắm hồ nước trong giữa rừng","15:30 Xe đưa về Nha Trang","16:30 Về đến khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Nha Trang – Cai River – Ba Ho – Nha Trang","activities":["08:00 Hotel pickup, transfer to the Cai River pier","08:30 Cruise upriver with live folk music","09:15 Craft villages: mat weaving, conical hats, rice-wine making","10:30 Rattan and bamboo workshop, buy souvenirs","11:30 Countryside lunch by the river","13:30 Ba Ho waterfall: an easy climb and a swim in clear forest pools","15:30 Drive back to Nha Trang","16:30 Drop off at your hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"boat":"Du thuyền sông Cái","meals":"Ăn trưa đồng quê"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"boat":"Cai River cruise","meals":"Countryside lunch"}'::jsonb,
  'Rời xa bãi biển đông đúc, tour sông Cái đưa bạn về miền quê Khánh Hòa yên ả: du thuyền ngược dòng nghe đờn ca tài tử, ghé các làng nghề dệt chiếu, làm nón, nấu rượu, rồi leo nhẹ lên thác Ba Hồ tắm trong ba tầng hồ nước trong vắt giữa rừng. Một ngày chậm rãi, chạm vào đời sống bản địa thật.',
  'Away from the crowded beaches, the Cai River tour takes you into the calm Khanh Hoa countryside: cruise upriver to live folk music, visit villages weaving mats, making conical hats and rice wine, then take an easy climb to Ba Ho waterfall to swim in three clear forest pools. A slow day touching real local life.',
  'Countryside day tour with a Cai River cruise, craft villages, folk music and a swim at Ba Ho waterfall.',
  'Tour sông Cái Nha Trang: du thuyền làng quê, làng nghề dệt chiếu-làm nón, đờn ca tài tử, thác Ba Hồ tắm hồ rừng. Trọn gói, đón khách sạn.',
  '["Đồ uống ngoài chương trình","Mua sắm tại làng nghề","Tip cho HDV, tài xế và thuyền viên"]'::jsonb,
  '["Drinks outside the program","Purchases at the craft villages","Tips for guide, driver and boat crew"]'::jsonb,
  'Đón tại khách sạn trung tâm Nha Trang', '08:00',
  'day_tour', 'moderate', 'vi_en', 'flexible', 'standard',
  '["sông cái","làng quê","thác ba hồ","làng nghề"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'song-cai-lang-que-thac-ba-ho-10058');

-- ─────────────────────────────────────────────────────────────
-- 9. Dốc Lết — bãi biển cát trắng & đồng muối Hòn Khói
-- ─────────────────────────────────────────────────────────────
insert into public.tours
  (name_vi, name_en, slug, destination, region, duration_days, duration_nights,
   base_price, child_price_pct, max_pax, min_pax, status,
   cover_image, images, highlights_vi, highlights_en,
   itinerary_vi, itinerary_en, includes_vi, includes_en,
   description, description_en, summary_en, meta_description,
   notes, excludes_en, meeting_point, depart_time,
   tour_type, difficulty, guide_language, cancel_policy, service_class,
   tags, translation_status)
select
  'Nha Trang – Dốc Lết: Bãi Biển Cát Trắng & Đồng Muối Hòn Khói',
  'Doc Let White-Sand Beach and Hon Khoi Salt Fields Tour',
  'doc-let-bai-bien-dong-muoi-10059',
  'Nha Trang', 'central', 1, 0,
  720000, 75, 30, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800&q=80'],
  ARRAY[
    'Bãi biển Dốc Lết cát trắng mịn, nước cạn thoải, sóng êm',
    'Cánh đồng muối Hòn Khói lấp lánh dưới nắng',
    'Diêm dân thu hoạch muối lúc bình minh — ảnh đẹp mê',
    'Rừng dương xanh mát ven bãi biển vắng',
    'Phù hợp gia đình có trẻ nhỏ, biển an toàn'
  ],
  ARRAY[
    'Doc Let beach with fine white sand, shallow water and gentle waves',
    'The Hon Khoi salt fields glittering under the sun',
    'Salt farmers harvesting at dawn — stunning photos',
    'Cool casuarina groves along a quiet beach',
    'Great for families with children, safe swimming'
  ],
  '[{"day":1,"title":"Nha Trang – Hòn Khói – Dốc Lết – Nha Trang","activities":["07:30 Xe đón khách tại khách sạn, đi Ninh Hòa (50km)","08:45 Cánh đồng muối Hòn Khói: xem diêm dân làm muối, chụp ảnh","10:00 Đến bãi biển Dốc Lết cát trắng","10:15 Tắm biển, chơi thể thao bãi biển, nghỉ rừng dương","12:30 Ăn trưa hải sản ven biển","14:00 Tự do thư giãn, tắm nắng","15:30 Xe đưa về Nha Trang","16:45 Về đến khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Nha Trang – Hon Khoi – Doc Let – Nha Trang","activities":["07:30 Hotel pickup, drive to Ninh Hoa (50km)","08:45 Hon Khoi salt fields: watch the salt farmers, take photos","10:00 Arrive at white-sand Doc Let beach","10:15 Swim, beach games, rest in the casuarina grove","12:30 Seafood lunch by the sea","14:00 Free relaxation and sunbathing","15:30 Drive back to Nha Trang","16:45 Drop off at your hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"meals":"Ăn trưa hải sản ven biển"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"meals":"Seafood lunch by the sea"}'::jsonb,
  'Cách Nha Trang 50km, Dốc Lết là bãi biển cát trắng mịn nước cạn thoải sóng êm — thiên đường cho gia đình có trẻ nhỏ. Trên đường đi, ghé cánh đồng muối Hòn Khói lấp lánh, nơi diêm dân cào muối thành từng ụ trắng như tuyết, tạo nên khung hình đẹp nhất Khánh Hòa. Một ngày biển yên bình xa đám đông phố thị.',
  'Fifty kilometres from Nha Trang, Doc Let is a fine white-sand beach with shallow water and gentle waves — a paradise for families with children. On the way, stop at the glittering Hon Khoi salt fields, where farmers rake salt into snow-white mounds for the most photogenic scene in Khanh Hoa. A peaceful beach day away from the city crowds.',
  'Beach day at white-sand Doc Let with a stop at the photogenic Hon Khoi salt fields.',
  'Tour Dốc Lết từ Nha Trang: bãi biển cát trắng nước cạn êm, đồng muối Hòn Khói, ăn trưa hải sản. Hợp gia đình, trọn gói, đón khách sạn.',
  '["Đồ uống ngoài chương trình","Thuê ghế/dù/thể thao biển","Tip cho HDV và tài xế"]'::jsonb,
  '["Drinks outside the program","Beach chair, umbrella or sports rental","Tips for guide and driver"]'::jsonb,
  'Đón tại khách sạn trung tâm Nha Trang', '07:30',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["dốc lết","bãi biển","đồng muối","hòn khói"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'doc-let-bai-bien-dong-muoi-10059');

-- ─────────────────────────────────────────────────────────────
-- 10. Food tour đêm Nha Trang & chợ đêm
-- ─────────────────────────────────────────────────────────────
insert into public.tours
  (name_vi, name_en, slug, destination, region, duration_days, duration_nights,
   base_price, child_price_pct, max_pax, min_pax, status,
   cover_image, images, highlights_vi, highlights_en,
   itinerary_vi, itinerary_en, includes_vi, includes_en,
   description, description_en, summary_en, meta_description,
   notes, excludes_en, meeting_point, depart_time,
   tour_type, difficulty, guide_language, cancel_policy, service_class,
   tags, translation_status)
select
  'Nha Trang – Food Tour Đêm: Nem Nướng, Bún Cá & Chợ Đêm',
  'Nha Trang Night Street Food Tour with Local Specialties',
  'nha-trang-food-tour-dem-10060',
  'Nha Trang', 'central', 1, 0,
  890000, 75, 12, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1559314809-0d155014e29e?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1559314809-0d155014e29e?w=800&q=80'],
  ARRAY[
    '5+ đặc sản Nha Trang: nem nướng, bún cá, bánh căn, bánh xèo mực',
    'Đi bộ và xe điện qua các quán ăn địa phương chính gốc',
    'Hải sản tươi kiểu chợ đêm bên bờ biển',
    'Chè và trái cây nhiệt đới tráng miệng',
    'Dạo chợ đêm Nha Trang mua quà và trái cây'
  ],
  ARRAY[
    'Five-plus Nha Trang specialties: grilled pork rolls, fish noodle soup, banh can, squid pancakes',
    'Walk and ride an electric cart between authentic local eateries',
    'Fresh night-market seafood by the seaside',
    'Sweet che and tropical fruit for dessert',
    'Stroll the Nha Trang night market for snacks and gifts'
  ],
  '[{"day":1,"title":"Nha Trang lên đèn — hành trình ẩm thực","activities":["17:30 HDV đón khách tại khách sạn","Điểm 1: nem nướng Ninh Hòa cuốn bánh tráng rau sống","Điểm 2: bún cá sứa và bánh canh chả cá đặc sản biển","Điểm 3: bánh căn, bánh xèo mực nóng hổi vỉa hè","Điểm 4: hải sản nướng kiểu chợ đêm bên bờ biển","Điểm 5: chè và trái cây nhiệt đới tráng miệng","20:30 Dạo chợ đêm Nha Trang, mua quà và trái cây","21:15 HDV đưa về khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Nha Trang after dark — a food journey","activities":["17:30 Your guide picks you up at the hotel","Stop 1: Ninh Hoa grilled pork rolls with rice paper and herbs","Stop 2: jellyfish fish noodle soup and fish-cake banh canh","Stop 3: sizzling banh can and squid banh xeo on the sidewalk","Stop 4: night-market grilled seafood by the seaside","Stop 5: che and tropical fruit for dessert","20:30 Stroll the Nha Trang night market for gifts and fruit","21:15 Your guide drops you back at the hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":"Đi bộ + xe điện giữa các điểm","insurance":true,"meals":"Toàn bộ món ăn và 1 đồ uống mỗi điểm"}'::jsonb,
  '{"guide":true,"transfer":"Walking plus electric cart between stops","insurance":true,"meals":"All food stops plus one drink per stop"}'::jsonb,
  'Nha Trang nổi tiếng biển đẹp nhưng dân sành ăn còn mê ẩm thực về đêm: nem nướng Ninh Hòa cuốn tay, bún cá sứa mát lành, bánh căn nóng hổi, hải sản nướng chợ đêm bên biển và chè tráng miệng ngọt lịm. Cùng HDV bản địa đi bộ và xe điện qua những quán chính gốc mà khách Tây khó tự tìm, khép lại bằng vòng dạo chợ đêm.',
  'Nha Trang is famous for its beaches, but foodies come for the night eats: hand-rolled Ninh Hoa grilled pork, cooling jellyfish fish noodle soup, sizzling banh can, night-market grilled seafood by the sea and sweet che for dessert. Walk and ride with a local guide to authentic spots hard to find on your own, ending with a stroll through the night market.',
  'Night street-food tour with five-plus Nha Trang specialties, seaside seafood and the night market.',
  'Food tour đêm Nha Trang: nem nướng Ninh Hòa, bún cá sứa, bánh căn, hải sản chợ đêm, chè tráng miệng, dạo chợ đêm. HDV bản địa, đón khách sạn.',
  '["Đồ uống có cồn ngoài chương trình","Mua sắm tại chợ đêm","Tip cho HDV"]'::jsonb,
  '["Alcoholic drinks beyond the program","Shopping at the night market","Tips for the guide"]'::jsonb,
  'Đón tại khách sạn trung tâm Nha Trang', '17:30',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["food tour","nem nướng","bún cá","chợ đêm"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'nha-trang-food-tour-dem-10060');

-- ─────────────────────────────────────────────────────────────
-- Tạo lịch khởi hành ngay (không cần chờ cron đêm)
-- ─────────────────────────────────────────────────────────────
select public.extend_day_tour_schedules();

-- Kiểm tra: 10 tour Nha Trang ACTIVE, mỗi tour 60 lịch
select t.slug, t.base_price, count(s.id) as so_lich, min(s.depart_date) as ngay_dau
from public.tours t
left join public.tour_schedules s on s.tour_id = t.id and s.depart_date > current_date
where t.destination = 'Nha Trang'
group by t.slug, t.base_price
order by t.slug;
