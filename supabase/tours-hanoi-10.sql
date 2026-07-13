-- ═══════════════════════════════════════════════════════════════
-- 10 TOUR HÀ NỘI cho khách nước ngoài — slug 10031 → 10040
-- Chạy trong Supabase → SQL Editor. Idempotent: mỗi INSERT có
-- WHERE NOT EXISTS theo slug — chạy lặp không tạo trùng.
-- Giá base_price là ƯỚC TÍNH theo mặt bằng thị trường 2026 (chủ web
-- đã duyệt cách làm này ở batch TP.HCM, tự chỉnh trong CMS nếu cần).
-- Ảnh: Unsplash placeholder (đã kiểm tra 200 OK) — thay ảnh thật sau.
-- Cuối file: gọi extend_day_tour_schedules() để có lịch hàng ngày ngay
-- (từ đó về sau pg_cron 'baggio-extend-day-tour-schedules' tự nối).
-- ═══════════════════════════════════════════════════════════════

-- Kiểm tra trước: các slug sắp thêm đã tồn tại chưa (mong đợi 0 dòng)
select slug, status from public.tours where slug ~ '-1003[0-9]$' or slug ~ '-10040$';

-- ─────────────────────────────────────────────────────────────
-- 1. Ninh Bình 1 ngày: Hoa Lư – Tràng An – Hang Múa
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
  'Hà Nội – Ninh Bình 1 Ngày: Hoa Lư, Tràng An & Hang Múa',
  'Ninh Binh Day Trip: Hoa Lu, Trang An Boat Ride and Mua Cave',
  'ninh-binh-trang-an-hang-mua-1-ngay-10031',
  'Hà Nội', 'north', 1, 0,
  1150000, 75, 24, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1573270689103-d7a4e42b609a?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1573270689103-d7a4e42b609a?w=800&q=80','https://images.unsplash.com/photo-1482938289607-e9573fc25ebb?w=800&q=80'],
  ARRAY[
    'Thuyền chèo tay Tràng An len giữa núi đá vôi và hang động xuyên thủy',
    'Leo 500 bậc Hang Múa — view "triệu like" nhìn xuống thung lũng Tam Cốc',
    'Cố đô Hoa Lư nghìn năm với đền vua Đinh - vua Lê',
    'Đạp xe đường làng giữa đồng lúa (theo mùa)',
    'Buffet trưa món Việt với đặc sản thịt dê núi, cơm cháy'
  ],
  ARRAY[
    'Rowing boat through Trang An limestone karsts and water caves',
    'Climb 500 steps at Mua Cave for the famous Tam Coc valley view',
    'Thousand-year-old Hoa Lu citadel with the Dinh and Le temples',
    'Countryside cycling between rice paddies (seasonal)',
    'Vietnamese buffet lunch with mountain goat and crispy rice'
  ],
  '[{"day":1,"title":"Hà Nội – Hoa Lư – Tràng An – Hang Múa – Hà Nội","activities":["07:30 Xe limousine đón khách khu Phố Cổ / Hoàn Kiếm","09:30 Đến cố đô Hoa Lư — thăm đền vua Đinh Tiên Hoàng và vua Lê Đại Hành","11:00 Đạp xe đường làng ngắm đồng lúa và núi đá vôi (tùy mùa)","12:00 Buffet trưa món Việt: thịt dê núi, cơm cháy Ninh Bình","13:30 Xuống thuyền chèo tay Tràng An — 2 tiếng xuyên hang động và thung nước","15:45 Hang Múa: leo 500 bậc đá lên đỉnh Núi Ngọa Long ngắm toàn cảnh","17:00 Lên xe về Hà Nội","19:00 Về đến Phố Cổ, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Hanoi – Hoa Lu – Trang An – Mua Cave – Hanoi","activities":["07:30 Limousine pickup in the Old Quarter / Hoan Kiem area","09:30 Hoa Lu ancient capital — temples of Kings Dinh and Le","11:00 Countryside cycling among rice paddies and karsts (seasonal)","12:00 Vietnamese buffet lunch: mountain goat, Ninh Binh crispy rice","13:30 Two-hour Trang An rowing boat through water caves and lagoons","15:45 Mua Cave: climb 500 stone steps for the panoramic valley view","17:00 Drive back to Hanoi","19:00 Drop off in the Old Quarter, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":"Xe limousine đưa đón khứ hồi","insurance":true,"entrance_fees":true,"boat":"Thuyền chèo tay Tràng An","meals":"Buffet trưa món Việt"}'::jsonb,
  '{"guide":true,"transfer":"Round-trip limousine bus","insurance":true,"entrance_fees":true,"boat":"Trang An rowing boat","meals":"Vietnamese buffet lunch"}'::jsonb,
  'Ninh Bình — "Vịnh Hạ Long trên cạn" — là chuyến đi trong ngày được khách quốc tế đặt nhiều nhất từ Hà Nội. Một ngày gói trọn: cố đô Hoa Lư nghìn năm, 2 tiếng thuyền chèo tay xuyên hang động Tràng An (di sản UNESCO) và cú leo 500 bậc Hang Múa để ôm trọn thung lũng Tam Cốc trong tầm mắt.',
  'Ninh Binh, the Ha Long Bay on land, is the most-booked day trip from Hanoi. One day covers it all: the thousand-year-old Hoa Lu citadel, a two-hour rowing boat through the UNESCO-listed Trang An caves, and the 500-step climb at Mua Cave for the iconic view over Tam Coc valley.',
  'Full-day Ninh Binh trip with Hoa Lu citadel, Trang An boat ride, Mua Cave viewpoint, cycling and buffet lunch.',
  'Tour Ninh Bình 1 ngày từ Hà Nội: thuyền Tràng An, Hang Múa 500 bậc, cố đô Hoa Lư, đạp xe, buffet trưa. Xe limousine đón khu Phố Cổ.',
  '["Đồ uống ngoài chương trình","Tip cho HDV, tài xế và người chèo thuyền","Chi phí cá nhân khác"]'::jsonb,
  '["Drinks outside the program","Tips for guide, driver and rowers","Other personal expenses"]'::jsonb,
  'Đón tại khách sạn khu Phố Cổ / Hoàn Kiếm, Hà Nội', '07:30',
  'day_tour', 'moderate', 'vi_en', 'flexible', 'standard',
  '["ninh bình","tràng an","hang múa","1 ngày"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'ninh-binh-trang-an-hang-mua-1-ngay-10031');

-- ─────────────────────────────────────────────────────────────
-- 2. Vịnh Hạ Long 1 ngày từ Hà Nội (du thuyền + limousine)
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
  'Hà Nội – Vịnh Hạ Long 1 Ngày: Du Thuyền & Chèo Kayak',
  'Ha Long Bay Day Cruise from Hanoi with Kayaking',
  'ha-long-1-ngay-tu-ha-noi-10032',
  'Hà Nội', 'north', 1, 0,
  1550000, 75, 30, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1509030450996-dd1a26dda07a?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1509030450996-dd1a26dda07a?w=800&q=80'],
  ARRAY[
    'Du thuyền 6 tiếng giữa kỳ quan thiên nhiên thế giới UNESCO',
    'Chèo kayak hoặc thuyền nan qua hang Luồn giữa núi đá vôi',
    'Thăm hang Sửng Sốt — hang đẹp nhất vịnh Hạ Long',
    'Buffet hải sản tươi phục vụ ngay trên du thuyền',
    'Xe limousine cao tốc khứ hồi, chỉ 2,5 tiếng mỗi chiều'
  ],
  ARRAY[
    'Six-hour cruise through the UNESCO World Natural Wonder',
    'Kayak or bamboo boat through Luon Cave between the karsts',
    'Visit Sung Sot (Surprise) Cave, the finest grotto in the bay',
    'Fresh seafood buffet served on board',
    'Round-trip express limousine bus, only 2.5 hours each way'
  ],
  '[{"day":1,"title":"Hà Nội – Vịnh Hạ Long – Hà Nội","activities":["07:00 Xe limousine đón khách khu Phố Cổ, đi cao tốc Hà Nội - Hạ Long","09:30 Đến cảng Tuần Châu, làm thủ tục lên du thuyền","10:00 Du thuyền rời bến — ngắm hòn Gà Chọi, hòn Đỉnh Hương","11:30 Buffet trưa hải sản tươi trên tàu giữa vịnh","13:00 Chèo kayak hoặc ngồi thuyền nan qua hang Luồn, khu làng chài","14:15 Thăm hang Sửng Sốt với thạch nhũ triệu năm","15:30 Tàu về bến, trà chiều và ngắm vịnh lần cuối","16:00 Lên xe limousine về Hà Nội","18:45 Về đến Phố Cổ, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Hanoi – Ha Long Bay – Hanoi","activities":["07:00 Limousine pickup in the Old Quarter, take the Hanoi - Ha Long expressway","09:30 Arrive at Tuan Chau marina, board the day cruise","10:00 Set sail past the Fighting Cocks and Incense Burner islets","11:30 Fresh seafood buffet lunch on board in the middle of the bay","13:00 Kayak or bamboo boat through Luon Cave and the floating village area","14:15 Explore Sung Sot Cave with its million-year-old stalactites","15:30 Cruise back with afternoon tea and final bay views","16:00 Limousine back to Hanoi","18:45 Drop off in the Old Quarter, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":"Xe limousine cao tốc khứ hồi","insurance":true,"entrance_fees":true,"boat":"Du thuyền tham quan 6 tiếng + kayak","meals":"Buffet trưa hải sản trên tàu"}'::jsonb,
  '{"guide":true,"transfer":"Round-trip express limousine","insurance":true,"entrance_fees":true,"boat":"Six-hour day cruise plus kayak","meals":"Seafood buffet lunch on board"}'::jsonb,
  'Không đủ thời gian ngủ đêm trên vịnh? Tour trong ngày này đưa bạn từ Hà Nội đến thẳng kỳ quan Hạ Long bằng cao tốc chỉ 2,5 tiếng, lênh đênh 6 tiếng trên du thuyền qua hòn Gà Chọi, chèo kayak xuyên hang Luồn, thăm hang Sửng Sốt và ăn buffet hải sản giữa vịnh — về lại Hà Nội trước giờ tối.',
  'Short on time for an overnight cruise? This day tour whisks you from Hanoi to Ha Long on the expressway in just 2.5 hours, then spends six hours on the water: past the Fighting Cocks islet, kayaking through Luon Cave, exploring Sung Sot grotto and enjoying a seafood buffet in the middle of the bay — back in Hanoi by evening.',
  'Ha Long Bay day cruise from Hanoi with expressway transfer, kayaking, Sung Sot Cave and seafood buffet.',
  'Tour Hạ Long 1 ngày từ Hà Nội: du thuyền 6 tiếng, kayak hang Luồn, hang Sửng Sốt, buffet hải sản. Limousine cao tốc khứ hồi, đón Phố Cổ.',
  '["Đồ uống trên tàu","Tip cho HDV, tài xế và thủy thủ đoàn","Chi phí cá nhân khác"]'::jsonb,
  '["Drinks on board","Tips for guide, driver and crew","Other personal expenses"]'::jsonb,
  'Đón tại khách sạn khu Phố Cổ / Hoàn Kiếm, Hà Nội', '07:00',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["hạ long","du thuyền","kayak","1 ngày"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'ha-long-1-ngay-tu-ha-noi-10032');

-- ─────────────────────────────────────────────────────────────
-- 3. Food tour phố cổ đi bộ (buổi tối)
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
  'Hà Nội – Food Tour Phố Cổ Về Chiều Tối',
  'Hanoi Old Quarter Evening Street Food Walking Tour',
  'ha-noi-food-tour-pho-co-10033',
  'Hà Nội', 'north', 1, 0,
  750000, 75, 12, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1509440159596-0249088772ff?w=800&q=80'],
  ARRAY[
    '6+ món trứ danh: phở, bún chả, bánh mì, nem rán, bánh cuốn, chè',
    'Cà phê trứng — đặc sản chỉ Hà Nội mới có, tại quán gốc',
    'Len lỏi 36 phố phường bằng đôi chân cùng HDV bản địa',
    'Bia hơi vỉa hè ngã tư Tạ Hiện — "ngã tư quốc tế" không ngủ',
    'Nhóm nhỏ tối đa 12 khách, ăn ở quán dân địa phương xếp hàng'
  ],
  ARRAY[
    'Six-plus iconic dishes: pho, bun cha, banh mi, fried spring rolls, banh cuon, che',
    'Egg coffee at an original cafe — a Hanoi-only specialty',
    'Weave through the 36 streets on foot with a local guide',
    'Sidewalk fresh beer at Ta Hien, the international crossroads that never sleeps',
    'Small group of max 12, eating where locals queue'
  ],
  '[{"day":1,"title":"Chiều tối len lỏi 36 phố phường","activities":["17:30 Gặp HDV tại quảng trường Đông Kinh Nghĩa Thục (hồ Hoàn Kiếm)","Điểm 1: bánh cuốn nóng tráng tay trên phố Hàng Gà","Điểm 2: bún chả than hoa — món Obama từng ăn ở Hà Nội","Điểm 3: bánh mì pate cửa hàng gia truyền","Đi bộ qua phố Hàng Mã, chợ đêm cuối tuần và ga tàu phố cổ","Điểm 4: nem rán + phở cuốn phố Ngũ Xã","Điểm 5: cà phê trứng tại quán gốc gia truyền từ 1946","Điểm 6: bia hơi vỉa hè Tạ Hiện + lạc rang, nem chua rán","21:00 Kết thúc tại hồ Hoàn Kiếm, HDV chỉ đường về khách sạn"]}]'::jsonb,
  '[{"day":1,"title":"An evening weaving through the 36 streets","activities":["17:30 Meet your guide at Dong Kinh Nghia Thuc Square (Hoan Kiem Lake)","Stop 1: steaming hand-rolled banh cuon on Hang Ga street","Stop 2: charcoal bun cha — the dish Obama ate in Hanoi","Stop 3: pate banh mi from a family-run bakery","Walk through Hang Ma street, the weekend night market and the Old Quarter train tracks","Stop 4: fried spring rolls and pho cuon in Ngu Xa quarter","Stop 5: egg coffee at the original cafe running since 1946","Stop 6: sidewalk fresh beer at Ta Hien with roasted peanuts and fried fermented pork","21:00 Finish at Hoan Kiem Lake, guide helps with directions back"]}]'::jsonb,
  '{"guide":true,"insurance":true,"meals":"Toàn bộ 6+ món ăn và 1 cà phê trứng + 1 bia hơi"}'::jsonb,
  '{"guide":true,"insurance":true,"meals":"All six-plus dishes plus one egg coffee and one fresh beer"}'::jsonb,
  'Ẩm thực Hà Nội ngon nhất khi ăn đúng chỗ dân bản địa xếp hàng — và đó chính xác là lộ trình của tour đi bộ này. Ba tiếng rưỡi len lỏi 36 phố phường: bánh cuốn tráng tay, bún chả than hoa, bánh mì gia truyền, cà phê trứng quán gốc và chốt đêm bằng bia hơi Tạ Hiện. Vừa no, vừa hiểu Hà Nội.',
  'Hanoi food is at its best where locals queue, and that is exactly where this walking tour goes. Three and a half hours through the 36 streets: hand-rolled banh cuon, charcoal-grilled bun cha, heritage banh mi, egg coffee at the original cafe, and a fresh beer nightcap at Ta Hien corner. Leave full and understanding Hanoi.',
  'Evening walking food tour through the Old Quarter with six-plus dishes, egg coffee and fresh beer.',
  'Food tour phố cổ Hà Nội buổi tối: bánh cuốn, bún chả, bánh mì, cà phê trứng, bia hơi Tạ Hiện. Đi bộ nhóm nhỏ 12 khách cùng HDV bản địa.',
  '["Đồ uống thêm ngoài chương trình","Tip cho HDV","Chi phí cá nhân khác"]'::jsonb,
  '["Extra drinks beyond the program","Tips for the guide","Other personal expenses"]'::jsonb,
  'Quảng trường Đông Kinh Nghĩa Thục, hồ Hoàn Kiếm', '17:30',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["food tour","phố cổ","đi bộ","về đêm"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'ha-noi-food-tour-pho-co-10033');

-- ─────────────────────────────────────────────────────────────
-- 4. City tour Hà Nội trọn ngày
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
  'Hà Nội – City Tour Trọn Ngày Nghìn Năm Văn Hiến',
  'Hanoi Full-Day City Tour: Thousand Years of History',
  'ha-noi-city-tour-10034',
  'Hà Nội', 'north', 1, 0,
  950000, 75, 16, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1583417267826-aebc4d1542e1?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1583417267826-aebc4d1542e1?w=800&q=80'],
  ARRAY[
    'Quảng trường Ba Đình, Lăng Chủ tịch Hồ Chí Minh và chùa Một Cột',
    'Văn Miếu - Quốc Tử Giám: trường đại học đầu tiên của Việt Nam',
    'Nhà tù Hỏa Lò — "Hanoi Hilton" trong ký ức phi công Mỹ',
    'Hồ Hoàn Kiếm, đền Ngọc Sơn và cầu Thê Húc đỏ son',
    'Bún chả trưa + xích lô dạo 36 phố phường'
  ],
  ARRAY[
    'Ba Dinh Square, the Ho Chi Minh Mausoleum and One Pillar Pagoda',
    'Temple of Literature: Vietnam first national university',
    'Hoa Lo Prison — the Hanoi Hilton of American pilots memoirs',
    'Hoan Kiem Lake, Ngoc Son Temple and the scarlet The Huc Bridge',
    'Bun cha lunch plus a cyclo ride through the 36 streets'
  ],
  '[{"day":1,"title":"Một ngày, nghìn năm Hà Nội","activities":["08:00 Đón khách tại khách sạn khu Phố Cổ / Hoàn Kiếm","Quảng trường Ba Đình — viếng Lăng Chủ tịch Hồ Chí Minh (ngoài, khi mở cửa)","Khu Phủ Chủ tịch, nhà sàn Bác Hồ và chùa Một Cột","10:30 Văn Miếu - Quốc Tử Giám với 82 bia tiến sĩ đá","12:00 Ăn trưa bún chả than hoa tại quán địa phương","13:30 Nhà tù Hỏa Lò — chứng tích hai cuộc chiến","15:00 Hồ Hoàn Kiếm: đền Ngọc Sơn, cầu Thê Húc, tháp Rùa","16:00 Xích lô 45 phút dạo 36 phố phường","17:00 Về lại khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"One day, a thousand years of Hanoi","activities":["08:00 Hotel pickup in the Old Quarter / Hoan Kiem area","Ba Dinh Square — Ho Chi Minh Mausoleum (outside view, when open)","Presidential Palace grounds, Uncle Ho stilt house and One Pillar Pagoda","10:30 Temple of Literature with its 82 stone doctor steles","12:00 Charcoal bun cha lunch at a local eatery","13:30 Hoa Lo Prison — relics of two wars","15:00 Hoan Kiem Lake: Ngoc Son Temple, The Huc Bridge, Turtle Tower","16:00 45-minute cyclo ride through the 36 streets","17:00 Return to your hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"meals":"Ăn trưa bún chả","activities":"Xích lô 45 phút phố cổ"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"meals":"Bun cha lunch","activities":"45-minute cyclo ride"}'::jsonb,
  'Hà Nội nghìn năm gói trong một ngày: từ quảng trường Ba Đình trang nghiêm và Văn Miếu cổ kính, qua ký ức chiến tranh ở nhà tù Hỏa Lò, đến nhịp sống 36 phố phường nhìn từ ghế xích lô. HDV song ngữ kể chuyện từng địa danh, trưa ăn bún chả than hoa đúng vị Hà Nội.',
  'A thousand years of Hanoi in one day: from solemn Ba Dinh Square and the ancient Temple of Literature, through wartime memories at Hoa Lo Prison, to the rhythm of the 36 streets seen from a cyclo seat. A bilingual guide narrates every landmark, with a proper charcoal bun cha lunch in between.',
  'Full-day Hanoi city tour covering the Mausoleum area, Temple of Literature, Hoa Lo Prison, Hoan Kiem Lake and a cyclo ride.',
  'City tour Hà Nội trọn ngày: Lăng Bác, chùa Một Cột, Văn Miếu, Hỏa Lò, hồ Hoàn Kiếm, xích lô phố cổ. Kèm ăn trưa bún chả, vé tham quan, HDV song ngữ.',
  '["Đồ uống ngoài chương trình","Tip cho HDV và tài xế","Chi phí mua sắm cá nhân"]'::jsonb,
  '["Drinks outside the program","Tips for guide and driver","Personal shopping expenses"]'::jsonb,
  'Đón tại khách sạn khu Phố Cổ / Hoàn Kiếm, Hà Nội', '08:00',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["city tour","lịch sử","văn miếu","1 ngày"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'ha-noi-city-tour-10034');

-- ─────────────────────────────────────────────────────────────
-- 5. Chùa Hương 1 ngày
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
  'Hà Nội – Chùa Hương 1 Ngày: Suối Yến & Động Hương Tích',
  'Perfume Pagoda Day Trip: Yen Stream Boat and Huong Tich Cave',
  'chua-huong-1-ngay-10035',
  'Hà Nội', 'north', 1, 0,
  1150000, 75, 20, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1504457047772-27faf1c00561?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1504457047772-27faf1c00561?w=800&q=80'],
  ARRAY[
    'Thuyền chèo tay 1 tiếng trên suối Yến giữa núi đá vôi và đồng sen',
    'Động Hương Tích — "Nam thiên đệ nhất động" với bàn thờ trong lòng núi',
    'Cáp treo lên động ngắm toàn cảnh dãy Hương Sơn (đã gồm vé)',
    'Chùa Thiên Trù cổ kính giữa sân gạch rêu phong',
    'Cơm trưa món chay - món quê đặc trưng vùng chùa Hương'
  ],
  ARRAY[
    'One-hour rowing boat on Yen Stream between karsts and lotus fields',
    'Huong Tich Cave — the First Cave under the Southern Sky with altars inside the mountain',
    'Cable car up to the cave with panoramic Huong Son views (ticket included)',
    'Ancient Thien Tru Pagoda with its mossy brick courtyards',
    'Countryside lunch with local vegetarian specialties'
  ],
  '[{"day":1,"title":"Hà Nội – Chùa Hương – Hà Nội","activities":["07:00 Xe đón khách khu Phố Cổ / Hoàn Kiếm, đi Mỹ Đức (65km)","09:00 Xuống thuyền chèo tay bến Đục — 1 tiếng xuôi suối Yến","10:15 Thăm chùa Thiên Trù — bếp Trời cổ kính của quần thể Hương Sơn","11:30 Cơm trưa món chay và đặc sản quê tại nhà hàng chân núi","13:00 Cáp treo lên động Hương Tích, chiêm bái Nam thiên đệ nhất động","15:00 Thuyền quay lại bến Đục, ngắm hoàng hôn trên suối Yến","16:00 Lên xe về Hà Nội","18:00 Về đến Phố Cổ, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Hanoi – Perfume Pagoda – Hanoi","activities":["07:00 Pickup in the Old Quarter / Hoan Kiem area, drive to My Duc (65km)","09:00 Board a rowing boat at Duc Wharf — one hour down Yen Stream","10:15 Visit Thien Tru Pagoda, the ancient Heaven Kitchen of the Huong Son complex","11:30 Countryside lunch with vegetarian specialties at the foot of the mountain","13:00 Cable car up to Huong Tich Cave, the First Cave under the Southern Sky","15:00 Boat back to Duc Wharf as the light softens over Yen Stream","16:00 Drive back to Hanoi","18:00 Drop off in the Old Quarter, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"boat":"Thuyền chèo tay suối Yến khứ hồi","meals":"Cơm trưa món chay - món quê","activities":"Vé cáp treo khứ hồi"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"boat":"Round-trip Yen Stream rowing boat","meals":"Countryside vegetarian lunch","activities":"Round-trip cable car ticket"}'::jsonb,
  'Chùa Hương là hành trình tâm linh đẹp nhất miền Bắc: một tiếng thuyền chèo tay xuôi suối Yến giữa núi đá vôi, chùa Thiên Trù rêu phong và động Hương Tích linh thiêng trong lòng núi — nơi vua Trịnh Sâm khắc năm chữ "Nam thiên đệ nhất động". Đã gồm cáp treo, thuyền và cơm trưa.',
  'The Perfume Pagoda is northern Vietnam most scenic spiritual journey: an hour by rowing boat down Yen Stream between limestone peaks, the moss-covered Thien Tru Pagoda, and the sacred Huong Tich Cave inside the mountain — crowned by a lord inscription naming it the First Cave under the Southern Sky. Cable car, boat and lunch included.',
  'Day trip to the Perfume Pagoda with Yen Stream rowing boat, cable car, Huong Tich Cave and countryside lunch.',
  'Tour chùa Hương 1 ngày từ Hà Nội: thuyền suối Yến, chùa Thiên Trù, cáp treo động Hương Tích, cơm chay. Trọn gói vé, đón khu Phố Cổ.',
  '["Đồ lễ, hương hoa","Đồ uống ngoài chương trình","Tip cho HDV, tài xế và người chèo thuyền"]'::jsonb,
  '["Offerings and incense","Drinks outside the program","Tips for guide, driver and rowers"]'::jsonb,
  'Đón tại khách sạn khu Phố Cổ / Hoàn Kiếm, Hà Nội', '07:00',
  'day_tour', 'moderate', 'vi_en', 'flexible', 'standard',
  '["chùa hương","tâm linh","suối yến","1 ngày"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'chua-huong-1-ngay-10035');

-- ─────────────────────────────────────────────────────────────
-- 6. Làng gốm Bát Tràng nửa ngày
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
  'Hà Nội – Làng Gốm Bát Tràng Nửa Ngày & Tự Tay Nặn Gốm',
  'Bat Trang Ceramic Village Half-Day Tour with Pottery Class',
  'bat-trang-lang-gom-nua-ngay-10036',
  'Hà Nội', 'north', 1, 0,
  650000, 75, 15, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1561053720-76cd73ff22c3?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1561053720-76cd73ff22c3?w=800&q=80'],
  ARRAY[
    'Làng nghề gốm sứ 700 năm tuổi bên sông Hồng',
    'Tự tay chuốt gốm trên bàn xoay — sản phẩm nung xong mang về',
    'Thăm lò nung và xưởng vẽ men của nghệ nhân',
    'Bảo tàng gốm Bát Tràng kiến trúc bàn xoay khổng lồ',
    'Chợ gốm — thiên đường mua quà lưu niệm giá gốc'
  ],
  ARRAY[
    'A 700-year-old ceramic village on the Red River',
    'Throw your own pot on the wheel — fired and yours to keep',
    'Visit working kilns and glaze-painting workshops',
    'Bat Trang Pottery Museum shaped like giant throwing wheels',
    'The ceramic market — souvenir heaven at source prices'
  ],
  '[{"day":1,"title":"Buổi sáng bên bàn xoay Bát Tràng","activities":["08:30 Xe đón khách khu Phố Cổ / Hoàn Kiếm, đi Bát Tràng (14km)","09:15 Dạo làng cổ: nhà gốm, sân phơi và những bức tường than xưa","09:45 Thăm xưởng nghệ nhân — xem chuốt gốm, vẽ men, vào lò nung","10:30 Lớp nặn gốm: tự chuốt sản phẩm trên bàn xoay, thợ hướng dẫn từng bước","11:30 Tham quan Bảo tàng gốm Bát Tràng hình bàn xoay khổng lồ","12:00 Tự do mua sắm ở chợ gốm","12:45 Xe về Hà Nội, 13:30 kết thúc tour (sản phẩm nung xong gửi về khách sạn sau 2 ngày)"]}]'::jsonb,
  '[{"day":1,"title":"A morning at the Bat Trang potter wheel","activities":["08:30 Pickup in the Old Quarter / Hoan Kiem area, drive to Bat Trang (14km)","09:15 Stroll the old village: pottery houses, drying yards and coal-cake walls","09:45 Visit an artisan workshop — wheel throwing, glaze painting, the kilns","10:30 Pottery class: throw your own piece on the wheel with step-by-step help","11:30 Visit the Bat Trang Pottery Museum shaped like giant wheels","12:00 Free time at the ceramic market","12:45 Drive back to Hanoi, 13:30 tour ends (your fired piece is delivered to your hotel in 2 days)"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"activities":"Lớp nặn gốm + nung sản phẩm mang về"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"activities":"Pottery class with fired piece to keep"}'::jsonb,
  'Chỉ cách Hà Nội 14km, Bát Tràng đã đỏ lửa lò gốm suốt 700 năm. Buổi sáng ở đây bạn sẽ xem nghệ nhân chuốt gốm vẽ men, tự tay làm một sản phẩm trên bàn xoay (nung xong gửi về tận khách sạn), thăm bảo tàng gốm hình bàn xoay khổng lồ và mua quà lưu niệm giá gốc ở chợ gốm.',
  'Just 14km from Hanoi, Bat Trang has kept its kilns burning for 700 years. In one morning you will watch artisans throw and glaze, make your own piece on the wheel (fired and delivered to your hotel), visit the museum shaped like giant potter wheels, and shop the ceramic market at source prices.',
  'Half-day trip to Bat Trang ceramic village with a hands-on pottery class and the piece fired to keep.',
  'Tour Bát Tràng nửa ngày từ Hà Nội: làng gốm 700 năm, tự nặn gốm bàn xoay mang về, bảo tàng gốm, chợ gốm. Đón khu Phố Cổ, về trưa.',
  '["Phí ship sản phẩm ra ngoài Hà Nội","Đồ uống ngoài chương trình","Tip cho HDV và nghệ nhân"]'::jsonb,
  '["Shipping the fired piece outside Hanoi","Drinks outside the program","Tips for guide and artisan"]'::jsonb,
  'Đón tại khách sạn khu Phố Cổ / Hoàn Kiếm, Hà Nội', '08:30',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["bát tràng","làng nghề","nặn gốm","nửa ngày"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'bat-trang-lang-gom-nua-ngay-10036');

-- ─────────────────────────────────────────────────────────────
-- 7. Cooking class + chợ Đồng Xuân
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
  'Hà Nội – Lớp Nấu Ăn Bắc Bộ & Đi Chợ Đồng Xuân',
  'Hanoi Cooking Class with Dong Xuan Market Tour',
  'cooking-class-cho-dong-xuan-10037',
  'Hà Nội', 'north', 1, 0,
  1150000, 75, 10, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=800&q=80'],
  ARRAY[
    'Đi chợ Đồng Xuân — chợ lớn nhất phố cổ — chọn nguyên liệu cùng đầu bếp',
    'Tự tay nấu 3 món Bắc: nem rán, bún chả, phở gà',
    'Học đánh cà phê trứng chuẩn công thức Hà Nội',
    'Thưởng thức thành quả trong không gian nhà cổ',
    'Bộ công thức tiếng Anh + chứng nhận mang về'
  ],
  ARRAY[
    'Shop Dong Xuan, the Old Quarter biggest market, with your chef',
    'Cook 3 northern classics yourself: fried spring rolls, bun cha, chicken pho',
    'Learn to whip a proper Hanoi egg coffee',
    'Enjoy your dishes in a heritage house setting',
    'English recipe booklet and certificate to take home'
  ],
  '[{"day":1,"title":"Từ sạp chợ Đồng Xuân đến gian bếp nhà cổ","activities":["08:30 Gặp đầu bếp tại cổng chợ Đồng Xuân","Dạo chợ 45 phút: chọn bún, rau thơm, thịt, học phân biệt gia vị Bắc","09:30 Về gian bếp nhà cổ cách chợ 5 phút đi bộ","Bài 1: cuốn và rán nem — kỹ thuật rán hai lửa giòn tan","Bài 2: nướng chả than hoa và pha nước chấm bún chả","Bài 3: nấu nước dùng phở gà trong veo","11:45 Học đánh cà phê trứng bồng bềnh đúng kiểu Hà Nội","12:00 Thưởng thức bữa trưa tự nấu","13:00 Nhận công thức + chứng nhận, kết thúc chương trình"]}]'::jsonb,
  '[{"day":1,"title":"From Dong Xuan stalls to a heritage-house kitchen","activities":["08:30 Meet your chef at the Dong Xuan Market gate","45-minute market walk: pick noodles, herbs and meat, decode northern spices","09:30 Walk 5 minutes to the heritage-house kitchen","Lesson 1: roll and double-fry crispy spring rolls","Lesson 2: grill bun cha patties over charcoal and mix the dipping sauce","Lesson 3: simmer a clear chicken pho broth","11:45 Whip a frothy Hanoi-style egg coffee","12:00 Sit down to the lunch you cooked","13:00 Receive recipes and certificate, program ends"]}]'::jsonb,
  '{"guide":true,"insurance":true,"activities":"Lớp nấu 3 món + cà phê trứng + đi chợ","meals":"Thưởng thức toàn bộ món tự nấu"}'::jsonb,
  '{"guide":true,"insurance":true,"activities":"3-dish class plus egg coffee plus market tour","meals":"All dishes you cook"}'::jsonb,
  'Món Bắc tinh tế ở sự cân bằng — và bạn sẽ học được điều đó từ sạp chợ Đồng Xuân đến gian bếp nhà cổ. Đầu bếp song ngữ hướng dẫn làm nem rán hai lửa, bún chả than hoa, phở gà nước trong và ly cà phê trứng bồng bềnh. Kết thúc bằng bữa trưa do chính tay bạn nấu.',
  'Northern Vietnamese food is all about balance, and you will learn it from the Dong Xuan market stalls to a heritage-house kitchen. A bilingual chef guides you through double-fried spring rolls, charcoal bun cha, clear chicken pho and a frothy egg coffee. It ends with the lunch you cooked yourself.',
  'Hands-on Hanoi cooking class with Dong Xuan market tour, three northern dishes, egg coffee and recipes to keep.',
  'Lớp nấu ăn Hà Nội: đi chợ Đồng Xuân cùng đầu bếp, tự nấu nem rán, bún chả, phở gà, cà phê trứng. Nhóm nhỏ 10 khách, công thức mang về.',
  '["Đưa đón khách sạn (điểm hẹn tại chợ Đồng Xuân)","Đồ uống ngoài chương trình","Tip cho đầu bếp"]'::jsonb,
  '["Hotel transfer (meeting point at Dong Xuan Market)","Drinks outside the program","Tips for the chef"]'::jsonb,
  'Cổng chính chợ Đồng Xuân, phố Đồng Xuân', '08:30',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["cooking class","ẩm thực","chợ đồng xuân","trải nghiệm"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'cooking-class-cho-dong-xuan-10037');

-- ─────────────────────────────────────────────────────────────
-- 8. Food tour xe máy Hà Nội đêm
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
  'Hà Nội – Food Tour Xe Máy Về Đêm & Cầu Long Biên',
  'Hanoi After Dark: Street Food by Motorbike and Long Bien Bridge',
  'ha-noi-food-tour-xe-may-dem-10038',
  'Hà Nội', 'north', 1, 0,
  1250000, 75, 12, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1477959858617-67f85cf4f1df?w=800&q=80'],
  ARRAY[
    'Ngồi sau xe máy cùng rider bản địa xuyên Hà Nội lên đèn',
    '5+ điểm ăn: phở cuốn Ngũ Xã, ốc luộc, bún chả, kem Tràng Tiền',
    'Chạy chậm qua cầu Long Biên trăm tuổi ngắm sông Hồng đêm',
    'Bia hơi vỉa hè và chuyện đời sống Hà Nội từ chính rider',
    'Nhóm nhỏ tối đa 12 khách, mỗi khách một xe một rider'
  ],
  ARRAY[
    'Ride pillion with local riders through Hanoi as the lights come on',
    'Five-plus stops: Ngu Xa pho rolls, boiled snails, bun cha, Trang Tien ice cream',
    'Slow ride across the century-old Long Bien Bridge over the night Red River',
    'Sidewalk fresh beer and real Hanoi life stories from your rider',
    'Small group of max 12, one bike and one rider per guest'
  ],
  '[{"day":1,"title":"Hà Nội lên đèn trên yên xe máy","activities":["18:00 Rider đón khách bằng xe máy tại khách sạn khu Phố Cổ","Điểm 1: phở cuốn và phở chiên phồng làng Ngũ Xã bên hồ Trúc Bạch","Điểm 2: ốc luộc chấm mắm gừng sả — món nhậu quốc dân Hà Nội","Chạy chậm qua cầu Long Biên trăm tuổi, dừng ngắm sông Hồng về đêm","Điểm 3: bún chả nướng than hoa quán trong ngõ","Điểm 4: kem Tràng Tiền ăn đứng đúng kiểu người Hà Nội","Điểm 5: bia hơi vỉa hè + lạc rang chốt đêm","21:30 Rider đưa khách về khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Hanoi lighting up from the back of a motorbike","activities":["18:00 Your rider picks you up by motorbike at your Old Quarter hotel","Stop 1: pho rolls and crispy fried pho in Ngu Xa village by Truc Bach Lake","Stop 2: boiled snails with ginger-lemongrass fish sauce — Hanoi favorite bar snack","Slow ride across the century-old Long Bien Bridge over the night Red River","Stop 3: charcoal-grilled bun cha in a hidden alley","Stop 4: Trang Tien ice cream eaten standing, the true Hanoi way","Stop 5: sidewalk fresh beer with roasted peanuts to close the night","21:30 Ride back to your hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":"Xe máy + nón bảo hiểm, mỗi khách một rider","insurance":true,"meals":"Toàn bộ món ăn và 1 đồ uống mỗi điểm"}'::jsonb,
  '{"guide":true,"transfer":"Motorbike with helmet, one rider per guest","insurance":true,"meals":"All food stops plus one drink per stop"}'::jsonb,
  'Hà Nội về đêm dịu lại — và ngon hơn. Ngồi sau xe máy cùng rider bản địa, bạn sẽ ăn phở cuốn bên hồ Trúc Bạch, ốc luộc chấm mắm gừng, bún chả trong ngõ nhỏ, kem Tràng Tiền, và chạy chậm qua cầu Long Biên trăm tuổi lộng gió sông Hồng. Một Hà Nội mà khách đi bộ không bao giờ chạm tới.',
  'Hanoi softens after dark, and tastes better too. Riding pillion with a local, you will eat pho rolls by Truc Bach Lake, boiled snails with ginger fish sauce, alley-hidden bun cha and Trang Tien ice cream, then cruise slowly across the century-old Long Bien Bridge above the Red River breeze. A Hanoi that walking tourists never reach.',
  'Evening motorbike food adventure with local riders, five-plus tasting stops and a Long Bien Bridge night ride.',
  'Food tour xe máy đêm Hà Nội: phở cuốn Ngũ Xã, ốc luộc, bún chả, kem Tràng Tiền, cầu Long Biên. Mỗi khách một rider, đón tận khách sạn.',
  '["Đồ uống có cồn ngoài chương trình","Tip cho rider","Chi phí cá nhân khác"]'::jsonb,
  '["Alcoholic drinks beyond the program","Tips for riders","Other personal expenses"]'::jsonb,
  'Đón tại khách sạn khu Phố Cổ / Hoàn Kiếm, Hà Nội', '18:00',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["food tour","xe máy","về đêm","cầu long biên"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'ha-noi-food-tour-xe-may-dem-10038');

-- ─────────────────────────────────────────────────────────────
-- 9. Làng cổ Đường Lâm 1 ngày
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
  'Hà Nội – Làng Cổ Đường Lâm 1 Ngày: Đá Ong & Tương Nếp',
  'Duong Lam Ancient Village Day Trip: Laterite Houses and Village Life',
  'duong-lam-lang-co-1-ngay-10039',
  'Hà Nội', 'north', 1, 0,
  1250000, 75, 16, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1528605248644-14dd04022da1?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1528605248644-14dd04022da1?w=800&q=80'],
  ARRAY[
    'Làng Việt cổ 1.200 năm — quê hương hai vua Phùng Hưng, Ngô Quyền',
    'Nhà cổ đá ong 300-400 năm tuổi còn nguyên người ở',
    'Đình Mông Phụ — tinh hoa kiến trúc Bắc Bộ thế kỷ 17',
    'Đạp xe qua cổng làng, giếng nước, ao sen và đồng lúa',
    'Cơm quê trong sân nhà cổ: gà mía, tương nếp, chè lam'
  ],
  ARRAY[
    'A 1,200-year-old Vietnamese village, birthplace of two kings',
    'Laterite-brick houses 300-400 years old and still lived in',
    'Mong Phu communal house — 17th-century northern architecture at its finest',
    'Cycle past the village gate, wells, lotus ponds and paddies',
    'Home-cooked lunch in an ancient courtyard: Mia chicken, soybean sauce, ginger candy'
  ],
  '[{"day":1,"title":"Hà Nội – Đường Lâm – Hà Nội","activities":["07:30 Xe đón khách khu Phố Cổ / Hoàn Kiếm, đi Sơn Tây (50km)","09:00 Qua cổng làng Mông Phụ rêu phong dưới gốc đa cổ thụ","Thăm đình Mông Phụ 400 năm — kiến trúc Việt cổ tinh xảo nhất xứ Đoài","Ghé nhà cổ đá ong, nghe chủ nhà kể chuyện 12 đời sinh sống","Xem làm tương nếp truyền thống và thử chè lam kẹo dồi","12:00 Cơm quê trong sân nhà cổ: gà mía, rau vườn, cà dầm tương","13:30 Đạp xe qua đồng lúa đến đền thờ Phùng Hưng và lăng Ngô Quyền","15:00 Ghé chùa Mía với 287 pho tượng cổ","16:00 Lên xe về Hà Nội, 17:30 kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Hanoi – Duong Lam – Hanoi","activities":["07:30 Pickup in the Old Quarter / Hoan Kiem area, drive to Son Tay (50km)","09:00 Enter through the mossy Mong Phu village gate under its ancient banyan","Visit the 400-year-old Mong Phu communal house, the finest of the western region","Step inside a laterite ancient house and hear 12 generations of family stories","Watch traditional soybean sauce making and taste ginger candy","12:00 Home-cooked lunch in an ancient courtyard: Mia chicken, garden greens","13:30 Cycle through the paddies to the Phung Hung temple and Ngo Quyen tomb","15:00 Visit Mia Pagoda with its 287 ancient statues","16:00 Drive back to Hanoi, 17:30 tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"meals":"Cơm quê trong nhà cổ","activities":"Xe đạp dạo làng"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"meals":"Home-cooked village lunch","activities":"Village cycling"}'::jsonb,
  'Đường Lâm là "bảo tàng sống" của làng quê Bắc Bộ: cổng làng dưới gốc đa, giếng nước sân đình, gần trăm nếp nhà đá ong 300-400 tuổi vẫn còn người ở. Một ngày ở đây bạn sẽ ăn cơm quê trong sân nhà cổ, xem làm tương nếp, đạp xe qua đồng lúa và hiểu vì sao nơi này sinh ra tới hai vị vua.',
  'Duong Lam is a living museum of the northern Vietnamese village: a banyan-shaded gate, communal wells, and nearly a hundred laterite houses aged 300-400 years and still inhabited. A day here means a home-cooked lunch in an ancient courtyard, watching soybean sauce being made, cycling through the paddies — and understanding why this soil produced two kings.',
  'Day trip to Duong Lam ancient village with laterite houses, communal house, village cycling and home-cooked lunch.',
  'Tour làng cổ Đường Lâm 1 ngày từ Hà Nội: nhà đá ong 400 tuổi, đình Mông Phụ, chùa Mía, đạp xe đồng lúa, cơm quê gà mía. Đón khu Phố Cổ.',
  '["Đồ uống ngoài chương trình","Tip cho HDV, tài xế và chủ nhà cổ","Chi phí cá nhân khác"]'::jsonb,
  '["Drinks outside the program","Tips for guide, driver and host family","Other personal expenses"]'::jsonb,
  'Đón tại khách sạn khu Phố Cổ / Hoàn Kiếm, Hà Nội', '07:30',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["đường lâm","làng cổ","văn hóa","1 ngày"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'duong-lam-lang-co-1-ngay-10039');

-- ─────────────────────────────────────────────────────────────
-- 10. Xích lô + cà phê trứng + Train Street (chiều tối)
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
  'Hà Nội – Xích Lô Phố Cổ, Cà Phê Trứng & Phố Đường Tàu',
  'Hanoi Cyclo Ride, Egg Coffee and the Famous Train Street',
  'xich-lo-ca-phe-trung-train-street-10040',
  'Hà Nội', 'north', 1, 0,
  850000, 75, 12, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1543731068-7e0f5beff43a?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1543731068-7e0f5beff43a?w=800&q=80','https://images.unsplash.com/photo-1519098901909-b1553a1190af?w=800&q=80'],
  ARRAY[
    'Xích lô 45 phút xuyên 36 phố phường — nhịp Hà Nội chậm rãi nhất',
    'Ngồi quán ven đường ray chờ khoảnh khắc tàu lướt qua sát vai',
    'Cà phê trứng bồng bềnh tại quán gia truyền',
    'Hoàng hôn hồ Hoàn Kiếm và đền Ngọc Sơn lên đèn',
    'Lý tưởng cho buổi chiều đầu tiên làm quen Hà Nội'
  ],
  ARRAY[
    'A 45-minute cyclo glide through the 36 streets — Hanoi at its slowest rhythm',
    'Sit trackside and wait for the train to sweep past inches away',
    'Frothy egg coffee at a heritage cafe',
    'Sunset over Hoan Kiem Lake as Ngoc Son Temple lights up',
    'The perfect first-afternoon introduction to Hanoi'
  ],
  '[{"day":1,"title":"Chiều Hà Nội: chậm, thơm và sát đường ray","activities":["15:00 Gặp HDV tại quảng trường Đông Kinh Nghĩa Thục (hồ Hoàn Kiếm)","15:15 Lên xích lô — 45 phút xuyên Hàng Bạc, Hàng Mã, Hàng Đào","16:15 Ghé quán cà phê trứng gia truyền, nghe chuyện ra đời ly cà phê trứng 1946","17:00 Đi bộ đến phố đường tàu Phùng Hưng, chọn chỗ ngồi ven ray","17:30 Khoảnh khắc đoàn tàu lướt qua cách vai chưa đầy một mét","18:15 Dạo hồ Hoàn Kiếm hoàng hôn, cầu Thê Húc và đền Ngọc Sơn lên đèn","19:00 Kết thúc tour tại hồ Hoàn Kiếm, HDV gợi ý quán ăn tối gần đó"]}]'::jsonb,
  '[{"day":1,"title":"A Hanoi afternoon: slow, fragrant and trackside","activities":["15:00 Meet your guide at Dong Kinh Nghia Thuc Square (Hoan Kiem Lake)","15:15 Board your cyclo — 45 minutes through Hang Bac, Hang Ma and Hang Dao","16:15 Heritage egg coffee stop with the story of its 1946 invention","17:00 Walk to Phung Hung train street and take your trackside seat","17:30 The moment the train sweeps past barely a meter away","18:15 Sunset stroll around Hoan Kiem Lake as The Huc Bridge lights up","19:00 Tour ends at the lake with dinner tips from your guide"]}]'::jsonb,
  '{"guide":true,"insurance":true,"activities":"Xích lô 45 phút + chỗ ngồi quán đường tàu","meals":"1 cà phê trứng + 1 đồ uống quán đường tàu"}'::jsonb,
  '{"guide":true,"insurance":true,"activities":"45-minute cyclo plus reserved trackside cafe seat","meals":"One egg coffee plus one drink at the train street cafe"}'::jsonb,
  'Ba trải nghiệm được khách quốc tế "săn" nhiều nhất ở Hà Nội gói trong một buổi chiều: ngồi xích lô trôi chậm qua 36 phố phường, nhâm nhi cà phê trứng tại quán gia truyền, và nín thở khi đoàn tàu lướt qua cách vai chưa đầy một mét ở phố đường tàu. Khép lại bằng hoàng hôn hồ Gươm.',
  'The three experiences foreign visitors hunt for most in Hanoi, packed into one afternoon: drifting through the 36 streets on a cyclo, sipping egg coffee at a heritage cafe, and holding your breath as the train sweeps past barely a meter from your shoulder on Train Street. It all closes with sunset over Hoan Kiem Lake.',
  'Afternoon combo of cyclo ride, heritage egg coffee and a trackside seat for the famous Train Street moment.',
  'Tour chiều Hà Nội: xích lô 36 phố phường, cà phê trứng quán gốc, phố đường tàu Phùng Hưng, hoàng hôn hồ Gươm. Nhóm nhỏ 12 khách.',
  '["Đồ uống thêm ngoài chương trình","Tip cho HDV và người đạp xích lô","Chi phí cá nhân khác"]'::jsonb,
  '["Extra drinks beyond the program","Tips for guide and cyclo drivers","Other personal expenses"]'::jsonb,
  'Quảng trường Đông Kinh Nghĩa Thục, hồ Hoàn Kiếm', '15:00',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["xích lô","cà phê trứng","train street","nửa ngày"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'xich-lo-ca-phe-trung-train-street-10040');

-- ─────────────────────────────────────────────────────────────
-- Tạo lịch khởi hành ngay (không cần chờ cron đêm)
-- ─────────────────────────────────────────────────────────────
select public.extend_day_tour_schedules();

-- Kiểm tra: 10 tour Hà Nội ACTIVE, mỗi tour 60 lịch
select t.slug, t.base_price, count(s.id) as so_lich, min(s.depart_date) as ngay_dau
from public.tours t
left join public.tour_schedules s on s.tour_id = t.id and s.depart_date > current_date
where t.destination = 'Hà Nội'
group by t.slug, t.base_price
order by t.slug;
