-- ═══════════════════════════════════════════════════════════════
-- 10 TOUR HẠ LONG cho khách nước ngoài — slug 10081 → 10090
-- Chạy trong Supabase → SQL Editor. Idempotent: mỗi INSERT có
-- WHERE NOT EXISTS theo slug — chạy lặp không tạo trùng.
-- Giá base_price là ƯỚC TÍNH theo mặt bằng thị trường 2026 (cách làm
-- chủ web đã duyệt ở 6 batch trước). Ảnh Unsplash placeholder.
-- destination='Hạ Long' (TP thuộc Quảng Ninh) — filter tỉnh đã map sẵn
-- trong index.html (PROVINCE_CITIES['Quảng Ninh']=['Hạ Long']).
-- LƯU Ý: chỉ day tour chạy HÀNG NGÀY (du thuyền 1 ngày, KHÔNG cruise ngủ đêm).
-- Không dùng dấu ' trong chuỗi để tránh phá SQL literal.
-- Cuối file: gọi extend_day_tour_schedules() để có lịch hàng ngày ngay.
-- ═══════════════════════════════════════════════════════════════

-- Kiểm tra trước: các slug sắp thêm đã tồn tại chưa (mong đợi 0 dòng)
select slug, status from public.tours where slug ~ '-1008[1-9]$' or slug ~ '-10090$';

-- ─────────────────────────────────────────────────────────────
-- 1. Du thuyền 1 ngày vịnh Hạ Long: hang Sửng Sốt, đảo Ti Tốp, kayak
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
  'Hạ Long – Du Thuyền 1 Ngày: Hang Sửng Sốt, Đảo Ti Tốp & Kayak',
  'Ha Long Bay Full-Day Cruise: Sung Sot Cave, Ti Top Island and Kayaking',
  'du-thuyen-1-ngay-vinh-ha-long-10081',
  'Hạ Long', 'north', 1, 0,
  850000, 75, 30, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1528127269322-539801943592?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1528127269322-539801943592?w=800&q=80','https://images.unsplash.com/photo-1573790387438-4da905039392?w=800&q=80'],
  ARRAY[
    'Di sản thiên nhiên thế giới UNESCO — vịnh Hạ Long',
    'Hang Sửng Sốt lộng lẫy nhũ đá kỳ vĩ',
    'Leo đỉnh đảo Ti Tốp ngắm toàn cảnh vịnh',
    'Chèo kayak luồn qua các đảo đá vôi',
    'Ăn trưa hải sản trên du thuyền giữa vịnh'
  ],
  ARRAY[
    'A UNESCO World Natural Heritage site — Ha Long Bay',
    'The magnificent Sung Sot Cave with dramatic stalactites',
    'Climb Ti Top island peak for a panorama of the bay',
    'Kayak through the limestone karsts',
    'Seafood lunch on the cruise boat amid the bay'
  ],
  '[{"day":1,"title":"Hạ Long – du thuyền vịnh 1 ngày","activities":["08:00 Xe đón khách tại khách sạn ra cảng tàu Tuần Châu","08:45 Du thuyền rời bến, ngắm hòn Trống Mái, hòn Đỉnh Hương","10:00 Thăm hang Sửng Sốt — hang động đẹp nhất vịnh","11:30 Ăn trưa hải sản trên du thuyền","13:00 Đảo Ti Tốp: leo 400 bậc ngắm toàn cảnh, tắm biển","14:30 Chèo kayak hoặc thuyền nan luồn đảo đá","16:00 Du thuyền về cảng","16:45 Xe đưa về khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Ha Long – full-day bay cruise","activities":["08:00 Hotel pickup, transfer to Tuan Chau harbor","08:45 Cruise departs, view the Fighting Cocks and Incense Burner islets","10:00 Visit Sung Sot Cave — the finest cave in the bay","11:30 Seafood lunch on the cruise boat","13:00 Ti Top island: climb 400 steps for the panorama, then swim","14:30 Kayak or bamboo boat through the karst islands","16:00 Cruise back to harbor","16:45 Transfer back to hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Vé thăm vịnh + hang Sửng Sốt + đảo Ti Tốp","boat":"Du thuyền + chèo kayak","meals":"Ăn trưa hải sản trên tàu"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Bay, Sung Sot Cave and Ti Top island tickets","boat":"Cruise boat and kayak","meals":"Seafood lunch on board"}'::jsonb,
  'Vịnh Hạ Long với hàng nghìn đảo đá vôi nhô lên giữa làn nước xanh ngọc là kỳ quan thiên nhiên thế giới. Du thuyền một ngày đưa bạn vào hang Sửng Sốt lộng lẫy nhũ đá, leo đỉnh Ti Tốp ngắm toàn cảnh vịnh từ trên cao, chèo kayak luồn qua những hòn đảo và thưởng thức hải sản ngay trên tàu. Trọn gói xe đón, vé vịnh và bữa trưa.',
  'Ha Long Bay, with thousands of limestone islands rising from jade-green water, is a natural wonder of the world. This full-day cruise takes you into the stalactite-filled Sung Sot Cave, up Ti Top island for a panorama of the bay, kayaking through the karsts and a seafood lunch on board. Hotel pickup, bay tickets and lunch all included.',
  'Full-day Ha Long Bay cruise with Sung Sot Cave, Ti Top island climb, kayaking and a seafood lunch.',
  'Tour du thuyền 1 ngày vịnh Hạ Long: hang Sửng Sốt, đảo Ti Tốp, chèo kayak, ăn trưa hải sản. Trọn gói vé vịnh, đón khách sạn.',
  '["Đồ uống ngoài chương trình","Vé kayak nâng cấp (nếu chọn thuyền riêng)","Tip cho HDV và thuyền viên"]'::jsonb,
  '["Drinks outside the program","Upgraded private kayak (if chosen)","Tips for guide and crew"]'::jsonb,
  'Đón tại khách sạn trung tâm Hạ Long', '08:00',
  'day_tour', 'moderate', 'vi_en', 'flexible', 'standard',
  '["vịnh hạ long","sửng sốt","ti tốp","kayak"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'du-thuyen-1-ngay-vinh-ha-long-10081');

-- ─────────────────────────────────────────────────────────────
-- 2. Du thuyền vịnh Lan Hạ & Cát Bà 1 ngày
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
  'Hạ Long – Du Thuyền Vịnh Lan Hạ & Đảo Cát Bà 1 Ngày',
  'Lan Ha Bay and Cat Ba Island Full-Day Cruise',
  'du-thuyen-vinh-lan-ha-cat-ba-10082',
  'Hạ Long', 'north', 1, 0,
  950000, 75, 24, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1573843981267-be1999ff37cd?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1573843981267-be1999ff37cd?w=800&q=80'],
  ARRAY[
    'Vịnh Lan Hạ hoang sơ, ít đông hơn Hạ Long',
    'Hàng trăm bãi tắm nhỏ giữa các đảo đá',
    'Chèo kayak và tắm biển ở những vụng vắng',
    'Làng chài nổi Cái Bèo cổ nhất Việt Nam',
    'Ăn trưa hải sản tươi trên du thuyền'
  ],
  ARRAY[
    'Pristine Lan Ha Bay, less crowded than Ha Long',
    'Hundreds of small beaches tucked among the karsts',
    'Kayak and swim in quiet coves',
    'Cai Beo floating fishing village, one of the oldest in Vietnam',
    'Fresh seafood lunch on the cruise boat'
  ],
  '[{"day":1,"title":"Hạ Long – vịnh Lan Hạ – Cát Bà","activities":["08:00 Xe đón khách tại khách sạn ra bến tàu","08:45 Du thuyền vào vịnh Lan Hạ, ngắm đảo đá và bãi tắm nhỏ","10:00 Làng chài nổi Cái Bèo — làng chài cổ nhất Việt Nam","11:00 Chèo kayak luồn hang, tắm biển vụng vắng","12:30 Ăn trưa hải sản trên tàu","14:00 Dừng bãi tắm hoang sơ, thư giãn","15:30 Du thuyền về bến","16:30 Xe đưa về khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Ha Long – Lan Ha Bay – Cat Ba","activities":["08:00 Hotel pickup, transfer to the pier","08:45 Cruise into Lan Ha Bay, view karsts and small beaches","10:00 Cai Beo floating village — one of the oldest in Vietnam","11:00 Kayak through caves and swim in a quiet cove","12:30 Seafood lunch on board","14:00 Stop at a pristine beach to relax","15:30 Cruise back to the pier","16:30 Transfer back to hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"boat":"Du thuyền + chèo kayak","meals":"Ăn trưa hải sản trên tàu"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"boat":"Cruise boat and kayak","meals":"Seafood lunch on board"}'::jsonb,
  'Ngay sát vịnh Hạ Long nhưng vắng hơn nhiều, vịnh Lan Hạ có hàng trăm bãi tắm nhỏ nằm khuất giữa các đảo đá vôi và làn nước trong veo. Du thuyền một ngày đưa bạn chèo kayak luồn hang, tắm biển ở những vụng vắng, ghé làng chài nổi Cái Bèo cổ nhất Việt Nam và ăn hải sản trên tàu. Lựa chọn cho ai muốn tránh đám đông.',
  'Right beside Ha Long Bay but far quieter, Lan Ha Bay has hundreds of small beaches hidden among the limestone karsts and crystal water. This full-day cruise lets you kayak through caves, swim in quiet coves, visit the ancient Cai Beo floating village and eat seafood on board. The choice for those who want to escape the crowds.',
  'Full-day cruise of quiet Lan Ha Bay with kayaking, hidden beaches and an ancient floating village.',
  'Tour du thuyền vịnh Lan Hạ Cát Bà 1 ngày: đảo đá hoang sơ, chèo kayak, tắm biển vụng vắng, làng chài Cái Bèo, ăn trưa hải sản. Đón khách sạn.',
  '["Đồ uống ngoài chương trình","Vé kayak/thiết bị nâng cấp","Tip cho HDV và thuyền viên"]'::jsonb,
  '["Drinks outside the program","Upgraded kayak or gear","Tips for guide and crew"]'::jsonb,
  'Đón tại khách sạn trung tâm Hạ Long', '08:00',
  'day_tour', 'moderate', 'vi_en', 'flexible', 'standard',
  '["vịnh lan hạ","cát bà","kayak","làng chài"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'du-thuyen-vinh-lan-ha-cat-ba-10082');

-- ─────────────────────────────────────────────────────────────
-- 3. Du thuyền vịnh Bái Tử Long hoang sơ
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
  'Hạ Long – Du Thuyền Vịnh Bái Tử Long Hoang Sơ 1 Ngày',
  'Bai Tu Long Bay Wild Full-Day Cruise',
  'du-thuyen-vinh-bai-tu-long-10083',
  'Hạ Long', 'north', 1, 0,
  1050000, 75, 20, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=800&q=80'],
  ARRAY[
    'Vịnh Bái Tử Long — vườn quốc gia, gần như chưa khai thác',
    'Hang Thiên Cảnh Sơn và các đảo đá nguyên sơ',
    'Ít tàu thuyền, không gian tĩnh lặng riêng tư',
    'Chèo kayak và tắm biển bãi Cống Đầm hoang vắng',
    'Ăn trưa hải sản đánh bắt tại chỗ'
  ],
  ARRAY[
    'Bai Tu Long Bay — a national park, almost untouched',
    'Thien Canh Son Cave and pristine karst islands',
    'Few boats, a quiet and private atmosphere',
    'Kayak and swim at the deserted Cong Dam beach',
    'Seafood lunch caught on the spot'
  ],
  '[{"day":1,"title":"Hạ Long – vịnh Bái Tử Long","activities":["07:45 Xe đón khách tại khách sạn ra bến tàu","08:30 Du thuyền hướng vịnh Bái Tử Long, ngắm đảo đá nguyên sơ","10:00 Thăm hang Thiên Cảnh Sơn nhũ đá kỳ ảo","11:00 Chèo kayak khu vực Cống Đầm vắng người","12:30 Ăn trưa hải sản trên tàu","14:00 Tắm biển bãi hoang, thư giãn giữa thiên nhiên","15:30 Du thuyền về bến","16:30 Xe đưa về khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Ha Long – Bai Tu Long Bay","activities":["07:45 Hotel pickup, transfer to the pier","08:30 Cruise toward Bai Tu Long Bay, view pristine karst islands","10:00 Visit Thien Canh Son Cave with its fantastic stalactites","11:00 Kayak in the deserted Cong Dam area","12:30 Seafood lunch on board","14:00 Swim at a wild beach, relax in nature","15:30 Cruise back to the pier","16:30 Transfer back to hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"boat":"Du thuyền + chèo kayak","meals":"Ăn trưa hải sản trên tàu"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"boat":"Cruise boat and kayak","meals":"Seafood lunch on board"}'::jsonb,
  'Là vườn quốc gia liền kề nhưng gần như chưa bị khai thác du lịch, vịnh Bái Tử Long giữ nguyên vẻ hoang sơ mà Hạ Long đã đánh mất phần nào vì quá đông. Du thuyền một ngày đưa bạn tới hang Thiên Cảnh Sơn, chèo kayak ở những vụng vắng bóng người, tắm biển bãi hoang và ăn hải sản đánh bắt tại chỗ. Dành cho người tìm sự tĩnh lặng và thiên nhiên thật.',
  'An adjoining national park yet almost untouched by tourism, Bai Tu Long Bay keeps the wild beauty that busy Ha Long has partly lost. This full-day cruise takes you to Thien Canh Son Cave, kayaking in deserted coves, swimming at wild beaches and eating seafood caught on the spot. For those seeking quiet and true nature.',
  'Full-day cruise of the untouched Bai Tu Long Bay national park with a cave, kayaking and wild beaches.',
  'Tour du thuyền vịnh Bái Tử Long 1 ngày: vườn quốc gia hoang sơ, hang Thiên Cảnh Sơn, chèo kayak, bãi biển vắng, ăn trưa hải sản. Đón khách sạn.',
  '["Đồ uống ngoài chương trình","Phí tham quan bổ sung ngoài lịch trình","Tip cho HDV và thuyền viên"]'::jsonb,
  '["Drinks outside the program","Extra sightseeing fees beyond the program","Tips for guide and crew"]'::jsonb,
  'Đón tại khách sạn trung tâm Hạ Long', '07:45',
  'day_tour', 'moderate', 'vi_en', 'flexible', 'premium',
  '["bái tử long","hoang sơ","kayak","vườn quốc gia"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'du-thuyen-vinh-bai-tu-long-10083');

-- ─────────────────────────────────────────────────────────────
-- 4. Sun World Hạ Long: cáp treo Nữ Hoàng & vòng quay Mặt Trời
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
  'Hạ Long – Sun World: Cáp Treo Nữ Hoàng & Vòng Quay Mặt Trời',
  'Sun World Ha Long: Queen Cable Car and Sun Wheel',
  'sun-world-ha-long-cap-treo-nu-hoang-10084',
  'Hạ Long', 'north', 1, 0,
  750000, 75, 30, 1, 'ACTIVE',
  'https://images.unsplash.com/photo-1513026705753-bc3fffca8bf4?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1513026705753-bc3fffca8bf4?w=800&q=80'],
  ARRAY[
    'Cáp treo Nữ Hoàng cabin 2 tầng lớn nhất thế giới',
    'Vòng quay Mặt Trời trên đỉnh Ba Đèo ngắm toàn vịnh',
    'Công viên Rồng: trò chơi cảm giác mạnh',
    'Vườn Nhật Zen và khu tắm khoáng nóng Yoko Onsen',
    'Toàn cảnh vịnh Hạ Long từ trên cao'
  ],
  ARRAY[
    'The Queen Cable Car with the largest two-story cabins in the world',
    'The Sun Wheel atop Ba Deo hill overlooking the whole bay',
    'Dragon Park: thrill rides',
    'The Japanese Zen garden and Yoko Onsen hot springs',
    'Panoramas of Ha Long Bay from above'
  ],
  '[{"day":1,"title":"Hạ Long – Sun World","activities":["08:30 Xe đón khách tại khách sạn ra ga cáp treo","09:00 Cáp treo Nữ Hoàng cabin 2 tầng vượt vịnh Cửa Lục","09:30 Lên đỉnh Ba Đèo: vòng quay Mặt Trời ngắm toàn cảnh vịnh","10:30 Vườn Nhật Zen, tháp chuông và các điểm chụp ảnh","12:00 Ăn trưa (tự túc trong khu vui chơi)","13:30 Công viên Rồng: tàu lượn, trò chơi cảm giác mạnh","15:30 Tự do hoặc trải nghiệm Yoko Onsen (tùy chọn)","16:30 Xe đưa về khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Ha Long – Sun World","activities":["08:30 Hotel pickup, transfer to the cable car station","09:00 Queen Cable Car two-story cabins over Cua Luc bay","09:30 Up Ba Deo hill: the Sun Wheel with a panorama of the bay","10:30 Japanese Zen garden, bell tower and photo spots","12:00 Lunch (own expense inside the park)","13:30 Dragon Park: roller coaster and thrill rides","15:30 Free time or the Yoko Onsen experience (optional)","16:30 Transfer back to hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Vé cáp treo Nữ Hoàng + vòng quay + công viên Rồng"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Queen Cable Car, Sun Wheel and Dragon Park ticket"}'::jsonb,
  'Không cần lên tàu bạn vẫn ngắm được toàn cảnh vịnh Hạ Long: cáp treo Nữ Hoàng với cabin hai tầng lớn nhất thế giới đưa bạn lên đỉnh Ba Đèo, nơi có vòng quay Mặt Trời, vườn Nhật Zen và công viên Rồng đầy trò chơi. Toàn bộ vịnh di sản trải ra dưới chân. Trọn gói vé, xe đón — lựa chọn tuyệt vời cho gia đình và ngày biển động không ra vịnh được.',
  'You can take in the whole of Ha Long Bay without boarding a boat: the Queen Cable Car, with the largest two-story cabins in the world, carries you up Ba Deo hill to the Sun Wheel, a Japanese Zen garden and the ride-filled Dragon Park. The entire heritage bay unfolds below. Ticket and pickup included — a great pick for families and days when the sea is too rough to cruise.',
  'Full-day Sun World Ha Long tour with the Queen Cable Car, Sun Wheel and Dragon Park rides.',
  'Tour Sun World Hạ Long: cáp treo Nữ Hoàng cabin 2 tầng, vòng quay Mặt Trời, công viên Rồng, vườn Nhật. Ngắm toàn vịnh từ cao, trọn gói vé.',
  '["Ăn trưa trong công viên","Yoko Onsen tắm khoáng (tùy chọn, tính phí riêng)","Tip cho HDV và tài xế"]'::jsonb,
  '["Lunch inside the park","Yoko Onsen hot springs (optional, extra charge)","Tips for guide and driver"]'::jsonb,
  'Đón tại khách sạn trung tâm Hạ Long', '08:30',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["sun world","cáp treo nữ hoàng","vòng quay mặt trời","công viên"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'sun-world-ha-long-cap-treo-nu-hoang-10084');

-- ─────────────────────────────────────────────────────────────
-- 5. Yên Tử: chùa Đồng & cáp treo danh sơn
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
  'Hạ Long – Yên Tử: Chùa Đồng & Cáp Treo Danh Sơn 1 Ngày',
  'Yen Tu Sacred Mountain Day Trip: Bronze Pagoda and Cable Car',
  'yen-tu-chua-dong-cap-treo-10085',
  'Hạ Long', 'north', 1, 0,
  900000, 75, 24, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1509233725247-49e657c54213?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1509233725247-49e657c54213?w=800&q=80'],
  ARRAY[
    'Yên Tử — kinh đô Phật giáo Trúc Lâm của Việt Nam',
    'Chùa Đồng trên đỉnh 1.068m giữa biển mây',
    'Cáp treo vượt rừng tùng cổ trăm năm',
    'Vườn tháp Huệ Quang và chùa Hoa Yên cổ kính',
    'Hành hương tâm linh giữa non thiêng'
  ],
  ARRAY[
    'Yen Tu — the cradle of Vietnams Truc Lam Zen Buddhism',
    'The Bronze Pagoda atop the 1,068m peak amid a sea of clouds',
    'Cable car over century-old ancient pine forest',
    'The Hue Quang stupa garden and the old Hoa Yen pagoda',
    'A spiritual pilgrimage on a sacred mountain'
  ],
  '[{"day":1,"title":"Hạ Long – Yên Tử – Hạ Long","activities":["07:30 Xe đón khách tại khách sạn đi Uông Bí (Yên Tử)","09:00 Tới chân núi Yên Tử, tham quan Trung tâm văn hóa Trúc Lâm","09:45 Cáp treo tuyến 1 lên chùa Hoa Yên, vườn tháp Huệ Quang","10:45 Cáp treo tuyến 2 và leo bộ lên chùa Đồng đỉnh 1.068m","12:00 Viếng chùa Đồng, ngắm biển mây trên đỉnh","13:00 Ăn trưa chay/đặc sản dưới chân núi","14:30 Xe về Hạ Long","16:30 Về đến khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Ha Long – Yen Tu – Ha Long","activities":["07:30 Hotel pickup, drive to Uong Bi (Yen Tu)","09:00 Arrive at the foot of Yen Tu, visit the Truc Lam cultural center","09:45 Cable car line 1 to Hoa Yen pagoda and the Hue Quang stupa garden","10:45 Cable car line 2 and a climb to the Bronze Pagoda at 1,068m","12:00 Visit the Bronze Pagoda and the sea of clouds at the summit","13:00 Vegetarian or specialty lunch at the mountain foot","14:30 Drive back to Ha Long","16:30 Drop off at your hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Vé cáp treo Yên Tử 2 tuyến khứ hồi","meals":"Ăn trưa chay/đặc sản"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Round-trip Yen Tu cable car, both lines","meals":"Vegetarian or specialty lunch"}'::jsonb,
  'Yên Tử là non thiêng nơi vua Trần Nhân Tông rời ngai vàng đi tu, khai sinh Thiền phái Trúc Lâm thuần Việt. Trên đỉnh 1.068m là chùa Đồng bằng đồng nguyên khối, quanh năm ẩn hiện trong biển mây. Tour một ngày kết hợp cáp treo vượt rừng tùng cổ và leo bộ nhẹ, đưa bạn hành hương lên nóc chốn tổ Phật giáo Việt Nam. Trọn gói vé cáp treo và xe đón từ Hạ Long.',
  'Yen Tu is the sacred mountain where King Tran Nhan Tong left the throne to become a monk, founding the purely Vietnamese Truc Lam Zen school. At the 1,068m summit stands the solid-bronze Bronze Pagoda, year-round wreathed in clouds. This full-day tour combines a cable car over ancient pine forest with a gentle climb, a pilgrimage to the cradle of Vietnamese Buddhism. Cable car ticket and pickup from Ha Long included.',
  'Day pilgrimage to Yen Tu sacred mountain with cable cars, the summit Bronze Pagoda and a sea of clouds.',
  'Tour Yên Tử 1 ngày từ Hạ Long: chùa Đồng đỉnh 1.068m, cáp treo rừng tùng cổ, chùa Hoa Yên, vườn tháp. Kinh đô Trúc Lâm, trọn gói vé.',
  '["Đồ uống ngoài chương trình","Đoạn leo bộ lên chùa Đồng (không có cáp treo tới đỉnh)","Tip cho HDV và tài xế"]'::jsonb,
  '["Drinks outside the program","The final climb to the Bronze Pagoda (no cable car to the very top)","Tips for guide and driver"]'::jsonb,
  'Đón tại khách sạn trung tâm Hạ Long', '07:30',
  'day_tour', 'moderate', 'vi_en', 'flexible', 'standard',
  '["yên tử","chùa đồng","cáp treo","tâm linh"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'yen-tu-chua-dong-cap-treo-10085');

-- ─────────────────────────────────────────────────────────────
-- 6. Chèo kayak vịnh & làng chài Cửa Vạn
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
  'Hạ Long – Chèo Kayak Trên Vịnh & Làng Chài Cửa Vạn',
  'Ha Long Kayaking and Cua Van Fishing Village Tour',
  'kayak-vinh-lang-chai-cua-van-10086',
  'Hạ Long', 'north', 1, 0,
  700000, 75, 20, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=800&q=80'],
  ARRAY[
    'Tự tay chèo kayak luồn qua hang và đảo đá',
    'Làng chài nổi Cửa Vạn — làng chài đẹp nhất thế giới',
    'Nghe hát giao duyên và đời sống ngư dân trên vịnh',
    'Thăm trung tâm văn hóa nổi làng chài',
    'Ăn trưa hải sản trên du thuyền'
  ],
  ARRAY[
    'Paddle a kayak yourself through caves and karst islands',
    'Cua Van floating village — once named the most beautiful fishing village in the world',
    'Hear traditional love songs and learn about fishermen life on the bay',
    'Visit the floating village cultural center',
    'Seafood lunch on the cruise boat'
  ],
  '[{"day":1,"title":"Hạ Long – kayak & làng chài Cửa Vạn","activities":["08:00 Xe đón khách tại khách sạn ra bến tàu","08:45 Du thuyền vào khu vực làng chài Cửa Vạn","09:45 Thăm trung tâm văn hóa nổi, nghe hát giao duyên","10:30 Chèo kayak luồn qua hang Luồn và các đảo đá","12:00 Ăn trưa hải sản trên tàu","13:30 Chèo kayak tiếp hoặc đi thuyền nan của ngư dân","15:00 Du thuyền về bến","16:00 Xe đưa về khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Ha Long – kayaking and Cua Van village","activities":["08:00 Hotel pickup, transfer to the pier","08:45 Cruise to the Cua Van fishing village area","09:45 Visit the floating cultural center, hear traditional love songs","10:30 Kayak through Luon Cave and the karst islands","12:00 Seafood lunch on board","13:30 More kayaking or a ride on a fishermans bamboo boat","15:00 Cruise back to the pier","16:00 Transfer back to hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"boat":"Du thuyền + kayak + thuyền nan","meals":"Ăn trưa hải sản trên tàu"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"boat":"Cruise boat, kayak and bamboo boat","meals":"Seafood lunch on board"}'::jsonb,
  'Cách tuyệt nhất để cảm nhận vịnh Hạ Long là tự tay chèo kayak luồn qua những hang đá và vụng nước lặng. Tour đưa bạn tới làng chài nổi Cửa Vạn từng được bình chọn đẹp nhất thế giới, nghe hát giao duyên, tìm hiểu đời sống ngư dân bao đời sống trên mặt nước, rồi chèo kayak khám phá hang Luồn. Trưa ăn hải sản trên tàu. Một ngày gần gũi với vịnh và con người nơi đây.',
  'The best way to feel Ha Long Bay is to paddle a kayak yourself through the caves and still coves. This tour takes you to Cua Van floating village, once voted the most beautiful in the world, to hear traditional love songs, learn about the fishermen who have lived on the water for generations, then kayak through Luon Cave. Seafood lunch on board. A day close to the bay and its people.',
  'Kayaking day tour of Ha Long with Luon Cave and the famous Cua Van floating fishing village.',
  'Tour chèo kayak Hạ Long & làng chài Cửa Vạn: luồn hang đá, làng chài nổi đẹp nhất thế giới, hát giao duyên, ăn trưa hải sản. Đón khách sạn.',
  '["Đồ uống ngoài chương trình","Thuê thiết bị kayak nâng cấp","Tip cho HDV và thuyền viên"]'::jsonb,
  '["Drinks outside the program","Upgraded kayak equipment rental","Tips for guide and crew"]'::jsonb,
  'Đón tại khách sạn trung tâm Hạ Long', '08:00',
  'day_tour', 'moderate', 'vi_en', 'flexible', 'standard',
  '["kayak","cửa vạn","làng chài","vịnh hạ long"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'kayak-vinh-lang-chai-cua-van-10086');

-- ─────────────────────────────────────────────────────────────
-- 7. Đảo Tuần Châu: show nhạc nước & biểu diễn cá heo
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
  'Hạ Long – Đảo Tuần Châu: Show Nhạc Nước & Biểu Diễn Cá Heo',
  'Tuan Chau Island: Water Music Show and Dolphin Performance',
  'dao-tuan-chau-show-ca-heo-10087',
  'Hạ Long', 'north', 1, 0,
  650000, 75, 30, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1560275619-4662e36fa65c?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1560275619-4662e36fa65c?w=800&q=80'],
  ARRAY[
    'Show nhạc nước và trình diễn ánh sáng hoành tráng',
    'Biểu diễn cá heo, hải cẩu và xiếc thú',
    'Bãi biển nhân tạo Tuần Châu cát trắng',
    'Câu lạc bộ biểu diễn cá sấu và đua ngựa (tùy lịch)',
    'Buổi tối lung linh, hợp gia đình có trẻ nhỏ'
  ],
  ARRAY[
    'A grand water-music and light show',
    'Dolphin, seal and animal circus performances',
    'The white-sand man-made Tuan Chau beach',
    'Crocodile show and horse racing (schedule permitting)',
    'A dazzling evening, great for families with children'
  ],
  '[{"day":1,"title":"Hạ Long – đảo Tuần Châu về chiều tối","activities":["15:00 Xe đón khách tại khách sạn ra đảo Tuần Châu","15:30 Tắm biển bãi cát trắng nhân tạo, dạo bến du thuyền","16:30 Xem biểu diễn cá heo, hải cẩu và xiếc thú","18:00 Ăn tối hải sản trên đảo","19:30 Xem show nhạc nước và trình diễn ánh sáng","20:30 Xe đưa về khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Ha Long – Tuan Chau island in the evening","activities":["15:00 Hotel pickup, transfer to Tuan Chau island","15:30 Swim at the man-made white-sand beach, stroll the marina","16:30 Watch the dolphin, seal and animal circus show","18:00 Seafood dinner on the island","19:30 Watch the water-music and light show","20:30 Transfer back to hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Vé show cá heo + show nhạc nước","meals":"Ăn tối hải sản trên đảo"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Dolphin show and water-music show tickets","meals":"Seafood dinner on the island"}'::jsonb,
  'Đảo Tuần Châu ngay cạnh cảng tàu Hạ Long là khu vui chơi giải trí về đêm sôi động nhất vùng vịnh: bãi biển nhân tạo cát trắng, show biểu diễn cá heo và hải cẩu đáng yêu, cao trào là màn nhạc nước kết hợp ánh sáng hoành tráng trên mặt hồ. Tour buổi chiều tối lung linh, đặc biệt hợp với gia đình có trẻ nhỏ sau một ngày khám phá vịnh.',
  'Tuan Chau island, right next to Ha Long harbor, is the liveliest evening entertainment complex on the bay: a white-sand man-made beach, adorable dolphin and seal shows, and the highlight, a grand water-music and light spectacle on the lake. A dazzling late-afternoon-and-evening tour, especially good for families with children after a day exploring the bay.',
  'Evening tour of Tuan Chau island with dolphin performances and a grand water-music light show.',
  'Tour đảo Tuần Châu Hạ Long: show nhạc nước, biểu diễn cá heo hải cẩu, bãi biển cát trắng, ăn tối hải sản. Chiều tối, hợp gia đình, đón khách sạn.',
  '["Đồ uống ngoài chương trình","Trò chơi/dịch vụ có thu phí riêng trên đảo","Tip cho HDV và tài xế"]'::jsonb,
  '["Drinks outside the program","Separately charged games or services on the island","Tips for guide and driver"]'::jsonb,
  'Đón tại khách sạn trung tâm Hạ Long', '15:00',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["tuần châu","nhạc nước","cá heo","về đêm"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'dao-tuan-chau-show-ca-heo-10087');

-- ─────────────────────────────────────────────────────────────
-- 8. City tour: bảo tàng Quảng Ninh, núi Bài Thơ & chợ đêm
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
  'Hạ Long – City Tour: Bảo Tàng Quảng Ninh, Núi Bài Thơ & Chợ Đêm',
  'Ha Long City Tour: Quang Ninh Museum, Bai Tho Mountain and Night Market',
  'city-tour-bao-tang-quang-ninh-10088',
  'Hạ Long', 'north', 1, 0,
  600000, 75, 24, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1558005530-a7958896ec60?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1558005530-a7958896ec60?w=800&q=80'],
  ARRAY[
    'Bảo tàng Quảng Ninh kiến trúc "cung điện đen" độc đáo',
    'Leo núi Bài Thơ ngắm toàn cảnh vịnh và thành phố',
    'Chùa Long Tiên cổ dưới chân núi',
    'Cầu Bãi Cháy và đường bao biển hiện đại',
    'Dạo chợ đêm Hạ Long mua đặc sản và quà'
  ],
  ARRAY[
    'The Quang Ninh Museum, a striking black-glass building',
    'Climb Bai Tho Mountain for a panorama of the bay and city',
    'The old Long Tien Pagoda at the foot of the mountain',
    'Bai Chay Bridge and the modern seaside boulevard',
    'Stroll the Ha Long night market for specialties and gifts'
  ],
  '[{"day":1,"title":"Hạ Long – khám phá thành phố","activities":["14:00 Xe đón khách tại khách sạn","14:30 Bảo tàng Quảng Ninh — cung điện kính đen, tìm hiểu vùng mỏ","15:45 Chùa Long Tiên cổ dưới chân núi Bài Thơ","16:15 Leo núi Bài Thơ ngắm hoàng hôn toàn cảnh vịnh","17:30 Dạo đường bao biển, ngắm cầu Bãi Cháy lên đèn","18:30 Ăn tối đặc sản Hạ Long: chả mực, bún bề bề","19:30 Dạo chợ đêm Hạ Long","20:30 Xe đưa về khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Ha Long – exploring the city","activities":["14:00 Hotel pickup","14:30 Quang Ninh Museum — the black-glass palace and the coal-mining story","15:45 The old Long Tien Pagoda below Bai Tho Mountain","16:15 Climb Bai Tho Mountain for a sunset panorama of the bay","17:30 Stroll the seaside boulevard, view Bai Chay Bridge lit up","18:30 Ha Long specialty dinner: grilled squid cake, mantis-shrimp noodles","19:30 Stroll the Ha Long night market","20:30 Transfer back to hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"meals":"Ăn tối đặc sản Hạ Long"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"meals":"Ha Long specialty dinner"}'::jsonb,
  'Hạ Long không chỉ có vịnh: thành phố mỏ này còn có bảo tàng Quảng Ninh kiến trúc cung điện kính đen độc đáo, núi Bài Thơ nơi ngắm hoàng hôn toàn cảnh vịnh đẹp nhất, chùa Long Tiên cổ và con đường bao biển hiện đại. Chiều tối kết thúc bằng đặc sản chả mực giã tay trứ danh và vòng dạo chợ đêm. Một tour nhẹ nhàng cho ngày không ra vịnh.',
  'Ha Long is more than its bay: this coal-mining city has the striking black-glass Quang Ninh Museum, Bai Tho Mountain with the finest sunset panorama over the bay, the old Long Tien Pagoda and a modern seaside boulevard. The evening ends with the famous hand-pounded grilled squid cake and a stroll through the night market. A gentle tour for a day off the water.',
  'City tour of Ha Long with the Quang Ninh Museum, a Bai Tho Mountain sunset and the night market.',
  'City tour Hạ Long: bảo tàng Quảng Ninh, leo núi Bài Thơ ngắm hoàng hôn, chùa Long Tiên, chả mực, chợ đêm. Nhẹ nhàng, đón khách sạn.',
  '["Đồ uống ngoài chương trình","Mua sắm tại chợ đêm","Tip cho HDV và tài xế"]'::jsonb,
  '["Drinks outside the program","Shopping at the night market","Tips for guide and driver"]'::jsonb,
  'Đón tại khách sạn trung tâm Hạ Long', '14:00',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["city tour","bảo tàng quảng ninh","núi bài thơ","chợ đêm"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'city-tour-bao-tang-quang-ninh-10088');

-- ─────────────────────────────────────────────────────────────
-- 9. Du thuyền hoàng hôn & tiệc hải sản trên vịnh
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
  'Hạ Long – Du Thuyền Hoàng Hôn & Tiệc Hải Sản Trên Vịnh',
  'Ha Long Sunset Cruise with a Seafood Dinner on the Bay',
  'du-thuyen-hoang-hon-tiec-hai-san-10089',
  'Hạ Long', 'north', 1, 0,
  950000, 75, 24, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1505228395891-9a51e7e86bf6?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1505228395891-9a51e7e86bf6?w=800&q=80'],
  ARRAY[
    'Ngắm hoàng hôn buông trên vịnh Hạ Long từ du thuyền',
    'Tiệc hải sản tươi phục vụ trên boong tàu',
    'Thưởng thức đồ uống ngắm đảo đá chuyển màu',
    'Câu mực đêm và ngắm vịnh lên đèn',
    'Không gian lãng mạn, hợp cặp đôi và nhóm bạn'
  ],
  ARRAY[
    'Watch the sunset fall over Ha Long Bay from the cruise',
    'A fresh seafood dinner served on deck',
    'Enjoy a drink as the karsts change color',
    'Night squid fishing and the bay lighting up',
    'A romantic setting for couples and groups of friends'
  ],
  '[{"day":1,"title":"Hạ Long – du thuyền hoàng hôn","activities":["16:00 Xe đón khách tại khách sạn ra cảng tàu","16:30 Du thuyền rời bến, ngắm đảo đá trong nắng chiều","17:15 Đồ uống chào mừng, chọn góc ngắm hoàng hôn đẹp nhất","17:45 Mặt trời lặn sau đảo đá, vịnh nhuộm vàng cam","18:30 Tiệc hải sản tươi phục vụ trên boong","19:30 Câu mực đêm, ngắm vịnh và bờ thành phố lên đèn","20:30 Du thuyền về bến, xe đưa về khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Ha Long – sunset cruise","activities":["16:00 Hotel pickup, transfer to the harbor","16:30 Cruise departs, view the karsts in the afternoon light","17:15 Welcome drink and the best spot to watch the sunset","17:45 The sun sets behind the islands, the bay turns amber","18:30 Fresh seafood dinner served on deck","19:30 Night squid fishing as the bay and city lights come on","20:30 Cruise back, transfer to hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"boat":"Du thuyền + đồ câu mực","meals":"Tiệc hải sản tối + 1 đồ uống chào mừng"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"boat":"Cruise boat and squid-fishing gear","meals":"Seafood dinner and one welcome drink"}'::jsonb,
  'Vịnh Hạ Long đẹp nhất vào lúc hoàng hôn, khi nắng nhuộm vàng những đảo đá vôi và mặt nước phẳng lặng như gương. Du thuyền chiều tối đưa bạn ra vịnh đúng giờ đẹp nhất, nhâm nhi đồ uống ngắm mặt trời lặn, dự tiệc hải sản tươi trên boong rồi thử câu mực đêm khi vịnh và bờ thành phố lên đèn. Không gian lãng mạn cho cặp đôi và những nhóm bạn.',
  'Ha Long Bay is at its finest at sunset, when the light gilds the limestone islands and the water lies mirror-still. This late-afternoon cruise takes you out at the perfect hour: sip a drink as the sun goes down, enjoy a fresh seafood dinner on deck, then try night squid fishing as the bay and city shore light up. A romantic setting for couples and groups of friends.',
  'Sunset cruise on Ha Long Bay with a seafood dinner on deck and night squid fishing.',
  'Tour du thuyền hoàng hôn Hạ Long: ngắm mặt trời lặn trên vịnh, tiệc hải sản trên boong, câu mực đêm, vịnh lên đèn. Lãng mạn, đón khách sạn.',
  '["Đồ uống có cồn ngoài chương trình","Nâng cấp menu hải sản cao cấp","Tip cho HDV và thuyền viên"]'::jsonb,
  '["Alcoholic drinks beyond the program","Premium seafood menu upgrade","Tips for guide and crew"]'::jsonb,
  'Đón tại khách sạn trung tâm Hạ Long', '16:00',
  'day_tour', 'easy', 'vi_en', 'flexible', 'premium',
  '["hoàng hôn","du thuyền","hải sản","câu mực"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'du-thuyen-hoang-hon-tiec-hai-san-10089');

-- ─────────────────────────────────────────────────────────────
-- 10. Food tour đêm & chợ đêm Hạ Long
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
  'Hạ Long – Food Tour Đêm: Chả Mực Giã Tay, Bún Bề Bề & Chợ Đêm',
  'Ha Long Night Food Tour with Grilled Squid Cake and Mantis Shrimp',
  'ha-long-food-tour-dem-10090',
  'Hạ Long', 'north', 1, 0,
  700000, 75, 12, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1517244683847-7456b63c5969?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1517244683847-7456b63c5969?w=800&q=80'],
  ARRAY[
    'Chả mực giã tay Hạ Long — đặc sản trứ danh',
    'Bún bề bề (tôm tít) ngọt nước chính gốc',
    'Ngán nướng, hàu nướng và hải sản vỉa hè',
    'Bánh cuốn chả mực nóng hổi ăn sáng-tối',
    'Dạo chợ đêm và phố hải sản Bãi Cháy'
  ],
  ARRAY[
    'Ha Long hand-pounded grilled squid cake — a famous specialty',
    'Authentic mantis-shrimp noodle soup with sweet broth',
    'Grilled clams, oysters and sidewalk seafood',
    'Rice rolls with squid cake, hot off the pan',
    'Stroll the night market and the Bai Chay seafood street'
  ],
  '[{"day":1,"title":"Hạ Long lên đèn — ẩm thực biển","activities":["18:00 HDV đón khách tại khách sạn","Điểm 1: chả mực giã tay ăn kèm xôi trắng/bánh cuốn","Điểm 2: bún bề bề (tôm tít) nước ngọt thanh","Điểm 3: phố hải sản Bãi Cháy — ngán nướng, hàu nướng mỡ hành","Điểm 4: ốc và hải sản vỉa hè theo mùa","Điểm 5: chè và hoa quả tráng miệng","20:30 Dạo chợ đêm Hạ Long mua đặc sản làm quà","21:00 HDV đưa về khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Ha Long lights up — seafood eats","activities":["18:00 Guide pickup at the hotel","Stop 1: hand-pounded grilled squid cake with sticky rice or rice rolls","Stop 2: mantis-shrimp noodle soup with a clean sweet broth","Stop 3: Bai Chay seafood street — grilled clams and oysters with scallion oil","Stop 4: seasonal snails and sidewalk seafood","Stop 5: che and fruit for dessert","20:30 Stroll the Ha Long night market for specialties as gifts","21:00 Guide drops you back at the hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":"Đi bộ + xe điện giữa các điểm","insurance":true,"meals":"Toàn bộ món ăn và 1 đồ uống mỗi điểm"}'::jsonb,
  '{"guide":true,"transfer":"Walking plus electric cart between stops","insurance":true,"meals":"All food stops plus one drink per stop"}'::jsonb,
  'Vùng mỏ bên vịnh có đặc sản khiến ai đến cũng phải mang về: chả mực giã tay dai giòn không nơi nào bắt chước được, bún bề bề nước ngọt thanh, ngán nướng và hàu nướng mỡ hành nghi ngút. Cùng HDV bản địa đi qua phố hải sản Bãi Cháy và những quán chính gốc, nếm đủ vị biển Hạ Long, khép lại bằng vòng dạo chợ đêm. Một tối no nê đậm vị vùng mỏ.',
  'The coal-country city by the bay has specialties everyone takes home: hand-pounded grilled squid cake with an inimitable springy crunch, mantis-shrimp noodle soup with a clean sweet broth, grilled clams and oysters with scallion oil. With a local guide you walk the Bai Chay seafood street and authentic stalls, tasting the full range of Ha Long seafood, ending with a stroll through the night market. A filling evening of coal-country flavor.',
  'Night food tour with Ha Long grilled squid cake, mantis-shrimp noodles, grilled shellfish and the night market.',
  'Food tour đêm Hạ Long: chả mực giã tay, bún bề bề, ngán nướng, hàu nướng, phố hải sản Bãi Cháy, chợ đêm. HDV bản địa, đón khách sạn.',
  '["Đồ uống có cồn ngoài chương trình","Mua sắm đặc sản tại chợ đêm","Tip cho HDV"]'::jsonb,
  '["Alcoholic drinks beyond the program","Buying specialties at the night market","Tips for the guide"]'::jsonb,
  'Đón tại khách sạn trung tâm Hạ Long', '18:00',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["food tour","chả mực","bún bề bề","chợ đêm"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'ha-long-food-tour-dem-10090');

-- ─────────────────────────────────────────────────────────────
-- Tạo lịch khởi hành ngay (không cần chờ cron đêm)
-- ─────────────────────────────────────────────────────────────
select public.extend_day_tour_schedules();

-- Kiểm tra: 10 tour Hạ Long ACTIVE, mỗi tour 60 lịch
select t.slug, t.base_price, count(s.id) as so_lich, min(s.depart_date) as ngay_dau
from public.tours t
left join public.tour_schedules s on s.tour_id = t.id and s.depart_date > current_date
where t.destination = 'Hạ Long'
group by t.slug, t.base_price
order by t.slug;
