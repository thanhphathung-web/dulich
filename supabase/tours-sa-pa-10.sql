-- ═══════════════════════════════════════════════════════════════
-- 10 TOUR SA PA cho khách nước ngoài — slug 10071 → 10080
-- Chạy trong Supabase → SQL Editor. Idempotent: mỗi INSERT có
-- WHERE NOT EXISTS theo slug — chạy lặp không tạo trùng.
-- Giá base_price là ƯỚC TÍNH theo mặt bằng thị trường 2026 (cách làm
-- chủ web đã duyệt ở 5 batch trước). Ảnh Unsplash placeholder.
-- destination='Sa Pa' (thị trấn thuộc Lào Cai) — filter tỉnh đã map sẵn
-- trong index.html (PROVINCE_CITIES['Lào Cai']=['Sa Pa']).
-- LƯU Ý: tất cả là tour chạy HÀNG NGÀY (khớp auto-schedule). Chợ phiên
-- Bắc Hà (chỉ Chủ Nhật) KHÔNG đưa vào batch này — thêm tay nếu cần.
-- Không dùng dấu ' trong chuỗi (tên dân tộc viết "Mông"/"Hmong" tránh phá SQL).
-- Cuối file: gọi extend_day_tour_schedules() để có lịch hàng ngày ngay.
-- ═══════════════════════════════════════════════════════════════

-- Kiểm tra trước: các slug sắp thêm đã tồn tại chưa (mong đợi 0 dòng)
select slug, status from public.tours where slug ~ '-1007[0-9]$' or slug ~ '-10080$';

-- ─────────────────────────────────────────────────────────────
-- 1. Chinh phục Fansipan bằng cáp treo
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
  'Sa Pa – Chinh Phục Fansipan Bằng Cáp Treo: Nóc Nhà Đông Dương',
  'Conquer Fansipan by Cable Car: The Roof of Indochina',
  'cap-treo-fansipan-10071',
  'Sa Pa', 'north', 1, 0,
  950000, 75, 30, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1528181304800-259b08848526?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1528181304800-259b08848526?w=800&q=80','https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800&q=80'],
  ARRAY[
    'Đỉnh Fansipan 3.143m — nóc nhà Đông Dương',
    'Cáp treo ba dây vượt thung lũng Mường Hoa kỷ lục thế giới',
    'Biển mây bồng bềnh và quần thể tâm linh trên đỉnh',
    'Tàu hỏa leo núi Mường Hoa cổ điển (tùy chọn)',
    'Săn mây, ngắm toàn cảnh dãy Hoàng Liên Sơn'
  ],
  ARRAY[
    'The 3,143m Fansipan summit — the roof of Indochina',
    'A record three-rope cable car over the Muong Hoa valley',
    'A sea of clouds and the spiritual complex at the top',
    'The classic Muong Hoa mountain railway (optional)',
    'Cloud hunting and panoramas of the Hoang Lien Son range'
  ],
  '[{"day":1,"title":"Sa Pa – Fansipan – Sa Pa","activities":["08:30 Xe/đi bộ tới ga cáp treo Fansipan Legend","09:00 Lên cáp treo ba dây vượt thung lũng Mường Hoa, ngắm biển mây","09:45 Tới ga đỉnh, tham quan quần thể tâm linh Kim Sơn Bảo Thắng","10:30 Chinh phục cột mốc 3.143m nóc nhà Đông Dương","11:30 Săn mây, chụp ảnh toàn cảnh Hoàng Liên Sơn","12:30 Ăn trưa buffet nhà hàng trên núi","14:00 Xuống cáp treo, dạo vườn hồng và tàu hỏa leo núi","15:30 Về trung tâm Sa Pa, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Sa Pa – Fansipan – Sa Pa","activities":["08:30 Transfer or walk to the Fansipan Legend cable car station","09:00 Board the three-rope cable car over Muong Hoa valley, sea of clouds","09:45 Reach the summit station, visit the Kim Son Bao Thang spiritual complex","10:30 Conquer the 3,143m marker, the roof of Indochina","11:30 Cloud hunting and panoramas of Hoang Lien Son","12:30 Buffet lunch at the mountaintop restaurant","14:00 Cable car down, stroll the rose garden and mountain railway","15:30 Back to central Sa Pa, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Vé cáp treo Fansipan khứ hồi","meals":"Buffet trưa trên núi"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Round-trip Fansipan cable car","meals":"Mountaintop buffet lunch"}'::jsonb,
  'Fansipan cao 3.143m là đỉnh cao nhất Đông Dương, và giờ đây bạn có thể chinh phục nó trong một buổi sáng nhờ tuyến cáp treo ba dây kỷ lục thế giới lướt qua thung lũng Mường Hoa và biển mây bồng bềnh. Trên đỉnh là quần thể tâm linh linh thiêng và tầm nhìn ngút ngàn dãy Hoàng Liên Sơn. Trọn gói vé cáp treo và buffet trưa trên núi.',
  'At 3,143m, Fansipan is the highest peak in Indochina, and now you can conquer it in a single morning thanks to the record three-rope cable car gliding over the Muong Hoa valley and a rolling sea of clouds. At the top stands a sacred spiritual complex with endless views of the Hoang Lien Son range. The round-trip cable car and a mountaintop buffet lunch are included.',
  'Half-to-full-day Fansipan tour by record cable car to the 3,143m roof of Indochina with a buffet lunch.',
  'Tour Fansipan Sa Pa: cáp treo ba dây kỷ lục lên đỉnh 3.143m nóc nhà Đông Dương, biển mây, quần thể tâm linh, buffet trưa. Trọn gói vé cáp treo.',
  '["Tàu hỏa leo núi Mường Hoa (tùy chọn, tính phí riêng)","Đồ uống ngoài chương trình","Tip cho HDV và tài xế"]'::jsonb,
  '["Muong Hoa mountain railway (optional, extra charge)","Drinks outside the program","Tips for guide and driver"]'::jsonb,
  'Đón tại khách sạn trung tâm Sa Pa', '08:30',
  'day_tour', 'moderate', 'vi_en', 'flexible', 'standard',
  '["fansipan","cáp treo","nóc nhà đông dương","săn mây"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'cap-treo-fansipan-10071');

-- ─────────────────────────────────────────────────────────────
-- 2. Trekking bản Cát Cát & thác Tình Yêu
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
  'Sa Pa – Trekking Bản Cát Cát & Thác Tình Yêu',
  'Sa Pa Trekking to Cat Cat Village and Love Waterfall',
  'trekking-ban-cat-cat-thac-tinh-yeu-10072',
  'Sa Pa', 'north', 1, 0,
  650000, 75, 20, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1512552288940-3a300922a275?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1512552288940-3a300922a275?w=800&q=80'],
  ARRAY[
    'Bản Cát Cát cổ của người Mông dưới chân Fansipan',
    'Thác Tình Yêu và suối Vàng thơ mộng giữa rừng',
    'Xem dệt lanh, nhuộm chàm, chạm bạc thủ công',
    'Ruộng bậc thang và guồng nước truyền thống',
    'Trekking nhẹ nhàng, hợp cả người mới bắt đầu'
  ],
  ARRAY[
    'The old Hmong village of Cat Cat below Fansipan',
    'The romantic Love Waterfall and Gold Stream in the forest',
    'Watch linen weaving, indigo dyeing and silver carving',
    'Rice terraces and traditional water wheels',
    'A gentle trek, great for beginners'
  ],
  '[{"day":1,"title":"Sa Pa – Cát Cát – Thác Tình Yêu – Sa Pa","activities":["08:30 HDV đón khách tại khách sạn, đi bộ xuống bản Cát Cát","09:00 Tham quan bản Mông: nhà trình tường, guồng nước, ruộng bậc thang","10:00 Xem dệt lanh, nhuộm chàm, chạm bạc và mua đồ thủ công","11:00 Thác Cát Cát và cầu Si giữa bản","12:00 Ăn trưa đặc sản vùng cao","13:30 Đi Thác Tình Yêu và suối Vàng, trekking nhẹ trong rừng","15:30 Về trung tâm Sa Pa, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Sa Pa – Cat Cat – Love Waterfall – Sa Pa","activities":["08:30 Guide picks you up at the hotel, walk down to Cat Cat village","09:00 Explore the Hmong village: rammed-earth houses, water wheels, terraces","10:00 Watch linen weaving, indigo dyeing, silver carving and shop for crafts","11:00 Cat Cat waterfall and the Si bridge in the village","12:00 Highland specialty lunch","13:30 To Love Waterfall and Gold Stream, an easy forest trek","15:30 Back to central Sa Pa, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Vé bản Cát Cát + thác Tình Yêu","meals":"Ăn trưa đặc sản vùng cao"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Cat Cat and Love Waterfall tickets","meals":"Highland specialty lunch"}'::jsonb,
  'Ngay dưới chân Fansipan, bản Cát Cát của người Mông vẫn giữ nguyên nếp sống trăm năm: nhà trình tường, guồng nước, khung dệt lanh và những thửa ruộng bậc thang xếp tầng. Tour trekking nhẹ dẫn bạn qua bản, xuống thác Cát Cát rồi tới Thác Tình Yêu và suối Vàng thơ mộng. Hợp cả người mới trekking lần đầu và gia đình.',
  'Right below Fansipan, the Hmong village of Cat Cat keeps its centuries-old way of life: rammed-earth houses, water wheels, linen looms and terraced rice fields. This easy trek leads you through the village, down to Cat Cat waterfall, then on to the romantic Love Waterfall and Gold Stream. Great for first-time trekkers and families.',
  'Easy trek through the Hmong village of Cat Cat to the waterfalls and Love Waterfall, with a highland lunch.',
  'Tour trekking Cát Cát Sa Pa: bản người Mông, thác Cát Cát, Thác Tình Yêu, suối Vàng, xem dệt lanh nhuộm chàm. Trekking nhẹ, đón khách sạn.',
  '["Đồ uống ngoài chương trình","Mua đồ thủ công trong bản","Tip cho HDV"]'::jsonb,
  '["Drinks outside the program","Handicraft purchases in the village","Tips for the guide"]'::jsonb,
  'Đón tại khách sạn trung tâm Sa Pa', '08:30',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["cát cát","trekking","thác tình yêu","bản mông"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'trekking-ban-cat-cat-thac-tinh-yeu-10072');

-- ─────────────────────────────────────────────────────────────
-- 3. Trekking Lao Chải – Tả Van – thung lũng Mường Hoa
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
  'Sa Pa – Trekking Lao Chải, Tả Van & Thung Lũng Mường Hoa',
  'Sa Pa Trekking: Lao Chai, Ta Van and Muong Hoa Valley',
  'trekking-lao-chai-ta-van-muong-hoa-10073',
  'Sa Pa', 'north', 1, 0,
  750000, 75, 16, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1502904550040-7534597429ae?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1502904550040-7534597429ae?w=800&q=80'],
  ARRAY[
    'Ruộng bậc thang Mường Hoa đẹp bậc nhất Việt Nam',
    'Đi qua bản Lao Chải (Mông), Tả Van (Giáy)',
    'Bãi đá cổ Sa Pa với hoa văn khắc nghìn năm',
    'Trekking đường mòn giữa lúa chín và núi rừng',
    'Ăn trưa tại nhà dân, giao lưu văn hóa bản địa'
  ],
  ARRAY[
    'The Muong Hoa rice terraces, among the finest in Vietnam',
    'Pass through Lao Chai (Hmong) and Ta Van (Giay) villages',
    'The Sa Pa ancient rock field with millennia-old carvings',
    'Trek trails between ripe rice and mountain forest',
    'Lunch at a local home with cultural exchange'
  ],
  '[{"day":1,"title":"Sa Pa – Lao Chải – Tả Van – Sa Pa","activities":["08:30 HDV đón khách, xe tới đầu bản Lao Chải","09:00 Bắt đầu trekking xuống thung lũng Mường Hoa","10:00 Đi giữa ruộng bậc thang, qua bản Lao Chải của người Mông","11:30 Bãi đá cổ Sa Pa — hoa văn khắc bí ẩn nghìn năm","12:30 Ăn trưa tại nhà dân bản Tả Van (người Giáy)","14:00 Trekking tiếp qua suối Mường Hoa và cầu mây","15:30 Xe đón về trung tâm Sa Pa, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Sa Pa – Lao Chai – Ta Van – Sa Pa","activities":["08:30 Guide pickup, drive to the edge of Lao Chai village","09:00 Start trekking down into the Muong Hoa valley","10:00 Walk among rice terraces through the Hmong village of Lao Chai","11:30 The Sa Pa ancient rock field with mysterious millennia-old carvings","12:30 Lunch at a local home in Ta Van (Giay people)","14:00 Continue trekking past the Muong Hoa stream and rattan bridge","15:30 Van pickup back to central Sa Pa, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"meals":"Ăn trưa tại nhà dân bản Tả Van"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"meals":"Lunch at a local home in Ta Van"}'::jsonb,
  'Thung lũng Mường Hoa với những thửa ruộng bậc thang xếp tầng là hình ảnh biểu tượng của Sa Pa. Tour trekking dẫn bạn men theo đường mòn xuống thung lũng, qua bản Lao Chải của người Mông và Tả Van của người Giáy, ghé bãi đá cổ khắc hoa văn bí ẩn, và dừng ăn trưa ngay trong nhà dân. Một ngày chạm vào đời sống vùng cao đúng nghĩa.',
  'The Muong Hoa valley with its layered rice terraces is the iconic image of Sa Pa. This trek takes you down the trails into the valley, through the Hmong village of Lao Chai and the Giay village of Ta Van, past the ancient rock field with its mysterious carvings, and stops for lunch in a local family home. A day of real highland life.',
  'A day trek through the Muong Hoa valley terraces, the Hmong and Giay villages and a home-cooked lunch.',
  'Tour trekking Lao Chải Tả Van Sa Pa: ruộng bậc thang Mường Hoa, bản Mông và Giáy, bãi đá cổ, ăn trưa nhà dân. Trekking vừa, đón khách sạn.',
  '["Đồ uống ngoài chương trình","Người dân bản dẫn đường tự nguyện (tip tùy tâm)","Tip cho HDV"]'::jsonb,
  '["Drinks outside the program","Village walking companions (optional tip)","Tips for the guide"]'::jsonb,
  'Đón tại khách sạn trung tâm Sa Pa', '08:30',
  'day_tour', 'moderate', 'vi_en', 'flexible', 'standard',
  '["trekking","mường hoa","lao chải","tả van"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'trekking-lao-chai-ta-van-muong-hoa-10073');

-- ─────────────────────────────────────────────────────────────
-- 4. Thác Bạc, đèo Ô Quy Hồ & Cổng Trời
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
  'Sa Pa – Thác Bạc, Đèo Ô Quy Hồ & Cổng Trời',
  'Sa Pa – Silver Waterfall, O Quy Ho Pass and Heavens Gate',
  'thac-bac-o-quy-ho-tram-ton-10074',
  'Sa Pa', 'north', 1, 0,
  700000, 75, 24, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1467377791767-c929b5dc9a23?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1467377791767-c929b5dc9a23?w=800&q=80'],
  ARRAY[
    'Thác Bạc cao 200m đổ trắng xóa giữa núi rừng',
    'Đèo Ô Quy Hồ — một trong tứ đại đỉnh đèo Việt Nam',
    'Cổng Trời Trạm Tôn ngắm toàn cảnh dãy Hoàng Liên',
    'Săn mây và chụp ảnh cung đường đèo hùng vĩ',
    'Ghé vườn quốc gia Hoàng Liên đa dạng sinh học'
  ],
  ARRAY[
    'The 200m Silver Waterfall cascading through the mountains',
    'O Quy Ho Pass — one of Vietnam''s four great passes',
    'Tram Ton Heavens Gate with views over the Hoang Lien range',
    'Cloud hunting and photos of the majestic pass road',
    'A stop at the biodiverse Hoang Lien National Park'
  ],
  '[{"day":1,"title":"Sa Pa – Ô Quy Hồ – Sa Pa","activities":["08:30 Xe đón khách tại khách sạn, đi hướng đèo Ô Quy Hồ","09:00 Thác Bạc: leo bậc thang ngắm thác cao 200m","10:00 Cổng Trời Trạm Tôn — điểm cao nhất cung đèo, săn mây","11:00 Đèo Ô Quy Hồ: dừng các điểm view chụp ảnh biển mây","12:00 Ăn trưa nhà hàng view đèo","13:30 Ghé cổng vườn quốc gia Hoàng Liên","15:00 Về trung tâm Sa Pa, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Sa Pa – O Quy Ho – Sa Pa","activities":["08:30 Hotel pickup, drive toward the O Quy Ho pass","09:00 Silver Waterfall: climb the steps to view the 200m falls","10:00 Tram Ton Heavens Gate — the pass high point, cloud hunting","11:00 O Quy Ho pass: photo stops over the sea of clouds","12:00 Lunch at a pass-view restaurant","13:30 Stop at the Hoang Lien National Park gate","15:00 Back to central Sa Pa, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Vé Thác Bạc + Cổng Trời","meals":"Ăn trưa view đèo"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Silver Waterfall and Heavens Gate tickets","meals":"Pass-view lunch"}'::jsonb,
  'Cung đường Ô Quy Hồ nối Sa Pa với Lai Châu là một trong tứ đại đỉnh đèo huyền thoại của Việt Nam. Tour đưa bạn qua Thác Bạc cao 200m, lên Cổng Trời Trạm Tôn — nơi cao nhất cung đèo để săn mây và ngắm toàn cảnh dãy Hoàng Liên Sơn hùng vĩ. Một ngày cho người mê cảnh núi non và những khung hình biển mây ngoạn mục.',
  'The O Quy Ho road linking Sa Pa to Lai Chau is one of Vietnam''s four legendary mountain passes. This tour takes you past the 200m Silver Waterfall and up to Tram Ton Heavens Gate — the highest point of the pass — for cloud hunting and sweeping views of the majestic Hoang Lien Son range. A day for lovers of mountain scenery and spectacular seas of cloud.',
  'Scenic day tour of Silver Waterfall, the O Quy Ho pass and Tram Ton Heavens Gate with cloud hunting.',
  'Tour Thác Bạc Ô Quy Hồ Sa Pa: thác 200m, Cổng Trời Trạm Tôn, tứ đại đỉnh đèo, săn mây Hoàng Liên Sơn. Trọn gói vé, đón khách sạn.',
  '["Đồ uống ngoài chương trình","Vé vào sâu vườn quốc gia (tùy chọn)","Tip cho HDV và tài xế"]'::jsonb,
  '["Drinks outside the program","Deeper national park entry (optional)","Tips for guide and driver"]'::jsonb,
  'Đón tại khách sạn trung tâm Sa Pa', '08:30',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["thác bạc","ô quy hồ","cổng trời","săn mây"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'thac-bac-o-quy-ho-tram-ton-10074');

-- ─────────────────────────────────────────────────────────────
-- 5. Bản Tả Phìn & tắm lá thuốc người Dao đỏ
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
  'Sa Pa – Bản Tả Phìn & Tắm Lá Thuốc Người Dao Đỏ',
  'Sa Pa – Ta Phin Village and Red Dao Herbal Bath',
  'ban-ta-phin-tam-la-thuoc-dao-do-10075',
  'Sa Pa', 'north', 1, 0,
  750000, 75, 20, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=800&q=80'],
  ARRAY[
    'Bản Tả Phìn của người Dao đỏ và Mông',
    'Tắm lá thuốc Dao đỏ — bí quyết thảo dược trăm năm',
    'Hang động Tả Phìn kỳ bí và tu viện cổ đổ nát',
    'Xem thêu thổ cẩm và làm thuốc nam truyền thống',
    'Thư giãn phục hồi sau những ngày trekking'
  ],
  ARRAY[
    'Ta Phin village of the Red Dao and Hmong people',
    'A Red Dao herbal bath — a centuries-old herbal secret',
    'The mysterious Ta Phin cave and a ruined old monastery',
    'Watch brocade embroidery and traditional herbal medicine',
    'Relax and recover after days of trekking'
  ],
  '[{"day":1,"title":"Sa Pa – Tả Phìn – Sa Pa","activities":["08:30 Xe đón khách tại khách sạn đi bản Tả Phìn (12km)","09:15 Tham quan bản người Dao đỏ, xem thêu thổ cẩm","10:00 Khám phá hang động Tả Phìn kỳ bí","11:00 Ghé tu viện cổ Tả Phìn đổ nát trong sương","12:00 Ăn trưa đặc sản bản địa","13:30 Tắm lá thuốc Dao đỏ trong thùng gỗ pơ mu thư giãn","15:00 Về trung tâm Sa Pa, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Sa Pa – Ta Phin – Sa Pa","activities":["08:30 Hotel pickup, drive to Ta Phin village (12km)","09:15 Explore the Red Dao village, watch brocade embroidery","10:00 Discover the mysterious Ta Phin cave","11:00 Visit the ruined Ta Phin monastery in the mist","12:00 Local specialty lunch","13:30 A relaxing Red Dao herbal bath in a fragrant wooden tub","15:00 Back to central Sa Pa, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"activities":"Tắm lá thuốc Dao đỏ","meals":"Ăn trưa đặc sản bản địa"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"activities":"Red Dao herbal bath","meals":"Local specialty lunch"}'::jsonb,
  'Người Dao đỏ ở Tả Phìn nổi tiếng với bài thuốc tắm lá gồm cả trăm loại thảo dược rừng, giúp phục hồi cơ thể — trải nghiệm không thể bỏ lỡ sau những ngày trekking. Tour đưa bạn thăm bản, khám phá hang động Tả Phìn kỳ bí, ngắm tu viện cổ đổ nát trong sương, rồi ngâm mình trong thùng gỗ pơ mu nghi ngút hương thuốc. Một ngày văn hóa và thư giãn.',
  'The Red Dao of Ta Phin are famous for their herbal bath of a hundred forest plants that restores the body — a must after days of trekking. This tour takes you through the village, into the mysterious Ta Phin cave, past a ruined monastery in the mist, then into a fragrant wooden tub steaming with herbs. A day of culture and relaxation.',
  'Cultural day tour of Ta Phin village with the mysterious cave and a restorative Red Dao herbal bath.',
  'Tour Tả Phìn Sa Pa: bản người Dao đỏ, hang động Tả Phìn, tu viện cổ, tắm lá thuốc Dao đỏ thư giãn. Trọn gói vé, đón khách sạn.',
  '["Đồ uống ngoài chương trình","Mua thổ cẩm/thuốc nam trong bản","Tip cho HDV và tài xế"]'::jsonb,
  '["Drinks outside the program","Brocade or herbal medicine purchases","Tips for guide and driver"]'::jsonb,
  'Đón tại khách sạn trung tâm Sa Pa', '08:30',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["tả phìn","dao đỏ","tắm lá thuốc","hang động"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'ban-ta-phin-tam-la-thuoc-dao-do-10075');

-- ─────────────────────────────────────────────────────────────
-- 6. Núi Hàm Rồng & trung tâm thị trấn
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
  'Sa Pa – Núi Hàm Rồng & Dạo Trung Tâm Thị Trấn Trong Mây',
  'Sa Pa – Ham Rong Mountain and the Misty Town Center',
  'nui-ham-rong-thi-tran-sa-pa-10076',
  'Sa Pa', 'north', 1, 0,
  600000, 75, 24, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1528127269322-539801943592?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1528127269322-539801943592?w=800&q=80'],
  ARRAY[
    'Vườn hoa Hàm Rồng rực rỡ bốn mùa trên núi',
    'Sân Mây và Cổng Trời ngắm toàn cảnh thị trấn Sa Pa',
    'Nhà thờ Đá Sa Pa cổ kính giữa trung tâm',
    'Quảng trường và chợ tình văn hóa vùng cao',
    'Nửa ngày nhẹ nhàng, hợp mọi lứa tuổi'
  ],
  ARRAY[
    'The colorful year-round Ham Rong flower gardens on the mountain',
    'Cloud Yard and Heavens Gate overlooking Sa Pa town',
    'The old Sa Pa Stone Church in the town center',
    'The square and the highland love-market culture',
    'A gentle half-day, suitable for all ages'
  ],
  '[{"day":1,"title":"Sa Pa – Hàm Rồng – thị trấn","activities":["08:30 HDV đón khách tại khách sạn ra cổng núi Hàm Rồng","09:00 Leo núi Hàm Rồng: vườn hoa, vườn lan, vườn đá","10:00 Sân Mây và Cổng Trời ngắm toàn cảnh thị trấn trong mây","11:00 Xem biểu diễn văn nghệ dân tộc trên núi","12:00 Ăn trưa đặc sản Sa Pa (lẩu cá hồi/gà bản)","13:30 Dạo trung tâm: nhà thờ Đá, quảng trường, chợ Sa Pa","15:00 Kết thúc tour tại trung tâm thị trấn"]}]'::jsonb,
  '[{"day":1,"title":"Sa Pa – Ham Rong – town","activities":["08:30 Guide pickup, transfer to the Ham Rong mountain gate","09:00 Climb Ham Rong: flower gardens, orchid garden, stone garden","10:00 Cloud Yard and Heavens Gate overlooking the misty town","11:00 Watch an ethnic culture performance on the mountain","12:00 Sa Pa specialty lunch (salmon hotpot or free-range chicken)","13:30 Stroll the center: Stone Church, square, Sa Pa market","15:00 Tour ends in the town center"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Vé núi Hàm Rồng","meals":"Ăn trưa đặc sản Sa Pa"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Ham Rong mountain ticket","meals":"Sa Pa specialty lunch"}'::jsonb,
  'Ngay giữa thị trấn, núi Hàm Rồng là ban công ngắm Sa Pa đẹp nhất: vườn hoa rực rỡ bốn mùa, vườn lan, rừng đá, và Sân Mây trên đỉnh nhìn xuống cả thung lũng chìm trong sương. Buổi chiều dạo trung tâm thăm nhà thờ Đá cổ, quảng trường và chợ vùng cao. Một tour nhẹ nhàng, không leo trèo nhiều, hợp cả người lớn tuổi và trẻ nhỏ.',
  'Right in the town, Ham Rong mountain is the finest balcony over Sa Pa: flower gardens blooming year-round, an orchid garden, a stone forest, and a Cloud Yard at the top looking down on the whole misty valley. In the afternoon, stroll the center to the old Stone Church, the square and the highland market. A gentle tour with little climbing, good for seniors and children.',
  'Gentle day tour of Ham Rong flower mountain and the Sa Pa town center with its Stone Church.',
  'Tour núi Hàm Rồng Sa Pa: vườn hoa bốn mùa, Sân Mây, Cổng Trời ngắm thị trấn, nhà thờ Đá, chợ Sa Pa. Nhẹ nhàng, đón khách sạn.',
  '["Đồ uống ngoài chương trình","Thuê trang phục dân tộc chụp ảnh","Tip cho HDV"]'::jsonb,
  '["Drinks outside the program","Ethnic costume rental for photos","Tips for the guide"]'::jsonb,
  'Đón tại khách sạn trung tâm Sa Pa', '08:30',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["hàm rồng","thị trấn","nhà thờ đá","vườn hoa"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'nui-ham-rong-thi-tran-sa-pa-10076');

-- ─────────────────────────────────────────────────────────────
-- 7. Cầu kính Rồng Mây & đèo Ô Quy Hồ
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
  'Sa Pa – Cầu Kính Rồng Mây: Thang Máy Lồng Kính & Săn Mây',
  'Sa Pa – Rong May Glass Bridge and Sky Elevator',
  'cau-kinh-rong-may-o-quy-ho-10077',
  'Sa Pa', 'north', 1, 0,
  1050000, 75, 24, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1508261301902-79a2d89f2ff6?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1508261301902-79a2d89f2ff6?w=800&q=80'],
  ARRAY[
    'Cầu kính đi bộ cao nhất Đông Nam Á trên đèo Ô Quy Hồ',
    'Thang máy lồng kính ngoài trời cao 300m',
    'Toàn cảnh đèo Ô Quy Hồ và biển mây dưới chân',
    'Cảm giác mạnh cho người ưa mạo hiểm',
    'Dừng Thác Bạc và các điểm view trên cung đèo'
  ],
  ARRAY[
    'The highest walking glass bridge in Southeast Asia on the O Quy Ho pass',
    'A 300m outdoor glass sky elevator',
    'Panoramas of the O Quy Ho pass and a sea of clouds below',
    'A thrill for adventure lovers',
    'Stops at Silver Waterfall and pass viewpoints'
  ],
  '[{"day":1,"title":"Sa Pa – Rồng Mây – Sa Pa","activities":["08:30 Xe đón khách tại khách sạn đi khu du lịch Rồng Mây","09:15 Dừng Thác Bạc và điểm view đèo Ô Quy Hồ","10:00 Đi thang máy lồng kính ngoài trời cao 300m","10:30 Bước ra cầu kính đi bộ, ngắm biển mây dưới chân","11:30 Khu vườn thượng uyển và các điểm chụp ảnh","12:30 Ăn trưa nhà hàng view đèo","14:00 Xe về Sa Pa, dừng chụp ảnh dọc đường","15:30 Về trung tâm Sa Pa, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Sa Pa – Rong May – Sa Pa","activities":["08:30 Hotel pickup, drive to the Rong May tourist area","09:15 Stop at Silver Waterfall and an O Quy Ho pass viewpoint","10:00 Ride the 300m outdoor glass sky elevator","10:30 Step onto the walking glass bridge over the sea of clouds","11:30 The hilltop garden and photo spots","12:30 Lunch at a pass-view restaurant","14:00 Drive back to Sa Pa with photo stops en route","15:30 Back to central Sa Pa, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Vé Rồng Mây (thang máy + cầu kính)","meals":"Ăn trưa view đèo"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Rong May ticket (elevator and glass bridge)","meals":"Pass-view lunch"}'::jsonb,
  'Trên đèo Ô Quy Hồ, khu Rồng Mây sở hữu cầu kính đi bộ cao nhất Đông Nam Á và thang máy lồng kính ngoài trời cao 300m áp vào vách núi. Bước ra mặt kính trong suốt với biển mây bồng bềnh ngay dưới chân là trải nghiệm cảm giác mạnh khó quên. Tour kết hợp Thác Bạc và các điểm view tuyệt đẹp trên cung đèo huyền thoại.',
  'On the O Quy Ho pass, the Rong May area boasts the highest walking glass bridge in Southeast Asia and a 300m outdoor glass elevator set against the cliff. Stepping onto the transparent floor with a sea of clouds right beneath your feet is an unforgettable thrill. The tour also takes in Silver Waterfall and the finest viewpoints along the legendary pass.',
  'Thrill day tour to the Rong May glass bridge and sky elevator on the O Quy Ho pass, with Silver Waterfall.',
  'Tour cầu kính Rồng Mây Sa Pa: cầu kính cao nhất Đông Nam Á, thang máy lồng kính 300m, đèo Ô Quy Hồ, Thác Bạc, săn mây. Trọn gói vé.',
  '["Đồ uống ngoài chương trình","Dịch vụ chụp ảnh trên cầu kính","Tip cho HDV và tài xế"]'::jsonb,
  '["Drinks outside the program","Photo service on the glass bridge","Tips for guide and driver"]'::jsonb,
  'Đón tại khách sạn trung tâm Sa Pa', '08:30',
  'day_tour', 'easy', 'vi_en', 'flexible', 'premium',
  '["cầu kính","rồng mây","ô quy hồ","cảm giác mạnh"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'cau-kinh-rong-may-o-quy-ho-10077');

-- ─────────────────────────────────────────────────────────────
-- 8. Săn mây bình minh
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
  'Sa Pa – Săn Mây Bình Minh & Cà Phê Trên Đỉnh Đồi',
  'Sa Pa Sunrise Cloud Hunting and Hilltop Coffee',
  'san-may-binh-minh-sa-pa-10078',
  'Sa Pa', 'north', 1, 0,
  800000, 75, 16, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800&q=80'],
  ARRAY[
    'Đón bình minh và biển mây bồng bềnh trên đỉnh đồi',
    'Điểm săn mây đẹp bí mật ít khách du lịch',
    'Cà phê nóng ngắm mặt trời lên sau dãy núi',
    'Trekking nhẹ đường mòn giữa rừng và ruộng',
    'Khởi hành sớm — trọn khoảnh khắc kỳ diệu nhất ngày'
  ],
  ARRAY[
    'Catch the sunrise and a rolling sea of clouds on a hilltop',
    'A beautiful secret cloud-hunting spot with few tourists',
    'Hot coffee as the sun rises behind the mountains',
    'An easy trek on trails through forest and fields',
    'An early start for the most magical moment of the day'
  ],
  '[{"day":1,"title":"Sa Pa – săn mây bình minh","activities":["04:30 HDV đón khách tại khách sạn (còn tối)","05:00 Xe và trekking nhẹ lên điểm săn mây bí mật","05:45 Tới đỉnh đồi, ổn định chỗ chờ bình minh","06:15 Mặt trời lên sau núi, biển mây cuộn dưới chân","06:45 Cà phê/trà nóng, ăn sáng nhẹ ngắm mây","08:00 Trekking xuống qua rừng và ruộng bậc thang","09:30 Về trung tâm Sa Pa, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Sa Pa – sunrise cloud hunting","activities":["04:30 Guide pickup at the hotel (still dark)","05:00 Drive and easy trek up to a secret cloud-hunting spot","05:45 Reach the hilltop and settle in to wait for sunrise","06:15 The sun rises behind the mountains, clouds roll below","06:45 Hot coffee or tea and a light breakfast with the clouds","08:00 Trek down through forest and rice terraces","09:30 Back to central Sa Pa, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"meals":"Cà phê/trà nóng và ăn sáng nhẹ trên đồi"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"meals":"Hot coffee or tea and a light hilltop breakfast"}'::jsonb,
  'Khoảnh khắc kỳ diệu nhất của Sa Pa đến từ rất sớm: khi mặt trời nhô lên sau dãy núi và cả thung lũng chìm trong biển mây trắng cuộn chảy dưới chân. Tour đưa bạn lên một điểm săn mây bí mật còn ít khách, nhâm nhi cà phê nóng chờ bình minh, rồi trekking nhẹ xuống qua rừng và ruộng bậc thang. Dậy sớm một hôm để đổi lấy cảnh tượng cả đời không quên.',
  'The most magical moment in Sa Pa comes very early: as the sun rises behind the mountains and the whole valley drowns in a rolling white sea of clouds beneath your feet. This tour takes you to a secret, still-quiet cloud-hunting spot, sipping hot coffee while you wait for the dawn, then an easy trek down through forest and rice terraces. Rise early once for a sight you will never forget.',
  'Early sunrise cloud-hunting tour to a secret Sa Pa hilltop with coffee and an easy trek down.',
  'Tour săn mây bình minh Sa Pa: đón bình minh, biển mây trên đỉnh đồi bí mật, cà phê nóng, trekking nhẹ. Khởi hành sớm, đón khách sạn.',
  '["Khởi hành rất sớm (04:30) — phụ thuộc thời tiết, mây","Đồ uống ngoài chương trình","Tip cho HDV"]'::jsonb,
  '["Very early start (04:30) — weather and cloud dependent","Drinks outside the program","Tips for the guide"]'::jsonb,
  'Đón tại khách sạn trung tâm Sa Pa', '04:30',
  'day_tour', 'moderate', 'vi_en', 'flexible', 'standard',
  '["săn mây","bình minh","biển mây","trekking"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'san-may-binh-minh-sa-pa-10078');

-- ─────────────────────────────────────────────────────────────
-- 9. Trải nghiệm bản làng cùng người Mông
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
  'Sa Pa – Một Ngày Làm Người Mông: Nhuộm Chàm, Làm Bạc & Ruộng Bậc Thang',
  'A Day as a Hmong: Indigo Dyeing, Silver Crafting and Rice Terraces',
  'trai-nghiem-ban-lang-hmong-10079',
  'Sa Pa', 'north', 1, 0,
  720000, 75, 12, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1531761535209-180857e963b9?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1531761535209-180857e963b9?w=800&q=80'],
  ARRAY[
    'Trải nghiệm cùng gia đình người Mông trong bản',
    'Tự tay nhuộm chàm, vẽ sáp ong lên vải lanh',
    'Xem và thử chạm bạc thủ công truyền thống',
    'Ra ruộng bậc thang cấy lúa, bắt cá suối theo mùa',
    'Ăn cơm bản với gia chủ, hiểu văn hóa vùng cao'
  ],
  ARRAY[
    'Spend the day with a Hmong family in their village',
    'Try indigo dyeing and beeswax drawing on linen',
    'Watch and try traditional silver crafting',
    'Head to the terraces to plant rice or catch stream fish in season',
    'Share a family meal and understand highland culture'
  ],
  '[{"day":1,"title":"Sa Pa – một ngày làm người Mông","activities":["08:30 HDV đón khách, đi tới bản của gia đình người Mông","09:15 Gặp gia chủ, tìm hiểu nếp nhà và trang phục dân tộc","10:00 Học nhuộm chàm và vẽ sáp ong lên vải lanh","11:00 Xem chạm bạc, thử làm một món đồ nhỏ","12:00 Ăn cơm bản cùng gia đình gia chủ","13:30 Ra ruộng bậc thang: cấy lúa hoặc bắt cá suối theo mùa","15:00 Về trung tâm Sa Pa, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Sa Pa – a day as a Hmong","activities":["08:30 Guide pickup, drive to a Hmong family village","09:15 Meet the hosts, learn about the home and ethnic dress","10:00 Learn indigo dyeing and beeswax drawing on linen","11:00 Watch silver crafting and try making a small piece","12:00 A family meal with your hosts","13:30 To the terraces: plant rice or catch stream fish in season","15:00 Back to central Sa Pa, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"activities":"Nhuộm chàm, chạm bạc, làm nông cùng gia chủ","meals":"Ăn cơm bản cùng gia đình"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"activities":"Indigo dyeing, silver crafting and farming with the hosts","meals":"A family meal"}'::jsonb,
  'Thay vì chỉ đi ngang qua bản, tour này cho bạn sống một ngày như người Mông thực thụ: cùng gia chủ nhuộm chàm và vẽ sáp ong lên vải lanh, thử chạm bạc, ra ruộng bậc thang cấy lúa hay bắt cá suối theo mùa, rồi quây quần bên mâm cơm bản. Nhóm nhỏ tối đa 12 khách để trải nghiệm thật gần gũi và ấm cúng.',
  'Instead of just passing through a village, this tour lets you live a day as a real Hmong: dye indigo and draw with beeswax on linen alongside your hosts, try silver crafting, head to the terraces to plant rice or catch stream fish in season, then gather around a family meal. Small groups of max 12 keep the experience close and warm.',
  'Immersive day with a Hmong family: indigo dyeing, silver crafting, terrace farming and a home meal.',
  'Tour trải nghiệm bản làng người Mông Sa Pa: nhuộm chàm, vẽ sáp ong, chạm bạc, làm ruộng bậc thang, ăn cơm bản. Nhóm nhỏ, đón khách sạn.',
  '["Đồ uống ngoài chương trình","Nguyên liệu mang về (vải nhuộm, đồ bạc)","Tip cho HDV và gia chủ"]'::jsonb,
  '["Drinks outside the program","Take-home materials (dyed cloth, silver)","Tips for the guide and host family"]'::jsonb,
  'Đón tại khách sạn trung tâm Sa Pa', '08:30',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["trải nghiệm","người mông","nhuộm chàm","ruộng bậc thang"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'trai-nghiem-ban-lang-hmong-10079');

-- ─────────────────────────────────────────────────────────────
-- 10. Ẩm thực vùng cao & chợ đêm Sa Pa
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
  'Sa Pa – Ẩm Thực Vùng Cao Về Đêm & Chợ Đêm Sa Pa',
  'Sa Pa Highland Night Food Tour and Night Market',
  'am-thuc-vung-cao-cho-dem-sa-pa-10080',
  'Sa Pa', 'north', 1, 0,
  700000, 75, 12, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1541544741938-0af808871cc0?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1541544741938-0af808871cc0?w=800&q=80'],
  ARRAY[
    'Đồ nướng vùng cao: thịt lợn cắp nách, cá suối, trứng nướng',
    'Lẩu cá hồi Sa Pa nóng hổi giữa tiết trời se lạnh',
    'Thắng cố và rượu táo mèo đặc sản người vùng cao',
    'Đồ nướng vỉa hè quanh nhà thờ Đá về đêm',
    'Dạo chợ đêm Sa Pa mua thổ cẩm và đặc sản'
  ],
  ARRAY[
    'Highland grills: mountain pork, stream fish, grilled eggs',
    'Hot Sa Pa salmon hotpot in the cool mountain air',
    'Thang co stew and apple-cider wine, highland specialties',
    'Sidewalk grills around the Stone Church at night',
    'Stroll the Sa Pa night market for brocade and specialties'
  ],
  '[{"day":1,"title":"Sa Pa lên đèn — ẩm thực vùng cao","activities":["17:30 HDV đón khách tại khách sạn","Điểm 1: khu đồ nướng quanh nhà thờ Đá — thịt lợn cắp nách, cá suối, trứng","Điểm 2: lẩu cá hồi Sa Pa nóng hổi","Điểm 3: thử thắng cố và nhấp rượu táo mèo","Điểm 4: đồ nướng và ngô/khoai nướng vỉa hè","20:00 Dạo chợ đêm Sa Pa: thổ cẩm, đặc sản, quà lưu niệm","21:00 HDV đưa về khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Sa Pa lights up — highland food","activities":["17:30 Guide pickup at the hotel","Stop 1: the grill area by the Stone Church — mountain pork, stream fish, eggs","Stop 2: hot Sa Pa salmon hotpot","Stop 3: try thang co stew and a sip of apple-cider wine","Stop 4: sidewalk grills with roasted corn and sweet potato","20:00 Stroll the Sa Pa night market: brocade, specialties, souvenirs","21:00 Guide drops you back at the hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":"Đi bộ quanh trung tâm","insurance":true,"meals":"Toàn bộ món ăn và 1 đồ uống mỗi điểm"}'::jsonb,
  '{"guide":true,"transfer":"Walking around the center","insurance":true,"meals":"All food stops plus one drink per stop"}'::jsonb,
  'Trời càng se lạnh, đồ nướng Sa Pa càng ngon: thịt lợn cắp nách, cá suối, trứng nướng bên bếp than quanh nhà thờ Đá, lẩu cá hồi nóng hổi, thắng cố và ly rượu táo mèo ấm bụng. Cùng HDV bản địa đi qua những hàng quán chính gốc mà khách Tây khó tự tìm, khép lại bằng vòng dạo chợ đêm mua thổ cẩm và đặc sản. Một tối vùng cao ấm áp và no nê.',
  'The cooler the air, the better Sa Pa grilling gets: mountain pork, stream fish and grilled eggs over charcoal by the Stone Church, hot salmon hotpot, thang co stew and a warming cup of apple-cider wine. With a local guide you reach authentic stalls hard to find alone, ending with a stroll through the night market for brocade and specialties. A warm, filling highland evening.',
  'Highland night food tour with grilled specialties, salmon hotpot, thang co and the Sa Pa night market.',
  'Food tour đêm Sa Pa: đồ nướng vùng cao, lẩu cá hồi, thắng cố, rượu táo mèo, chợ đêm thổ cẩm. HDV bản địa, đón khách sạn.',
  '["Đồ uống có cồn ngoài chương trình","Mua sắm tại chợ đêm","Tip cho HDV"]'::jsonb,
  '["Alcoholic drinks beyond the program","Shopping at the night market","Tips for the guide"]'::jsonb,
  'Đón tại khách sạn trung tâm Sa Pa', '17:30',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["food tour","lẩu cá hồi","thắng cố","chợ đêm"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'am-thuc-vung-cao-cho-dem-sa-pa-10080');

-- ─────────────────────────────────────────────────────────────
-- Tạo lịch khởi hành ngay (không cần chờ cron đêm)
-- ─────────────────────────────────────────────────────────────
select public.extend_day_tour_schedules();

-- Kiểm tra: 10 tour Sa Pa ACTIVE, mỗi tour 60 lịch
select t.slug, t.base_price, count(s.id) as so_lich, min(s.depart_date) as ngay_dau
from public.tours t
left join public.tour_schedules s on s.tour_id = t.id and s.depart_date > current_date
where t.destination = 'Sa Pa'
group by t.slug, t.base_price
order by t.slug;
