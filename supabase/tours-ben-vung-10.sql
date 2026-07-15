-- ═══════════════════════════════════════════════════════════════
-- 10 TOUR DU LỊCH BỀN VỮNG (eco / cộng đồng) — slug 10091 → 10100
-- Chạy trong Supabase → SQL Editor. Idempotent: mỗi INSERT có
-- WHERE NOT EXISTS theo slug — chạy lặp không tạo trùng.
-- Giá base_price là ƯỚC TÍNH theo mặt bằng thị trường 2026 (cách làm
-- chủ web đã duyệt ở 7 batch trước). Ảnh Unsplash placeholder.
-- CHỦ ĐỀ, KHÔNG PHẢI 1 THÀNH PHỐ: mỗi tour 1 điểm eco khác nhau,
-- destination trải khắp VN. Sau khi chạy, nhớ thêm điểm mới vào
-- PROVINCE_DESTS trong index.html để lọc theo tỉnh (đã làm cùng batch).
-- LOẠI: 4 tour NHIỀU NGÀY (Pù Luông, Mai Châu, Hà Giang, Cần Thơ) →
-- duration_days>1, KHÔNG được extend_day_tour_schedules() phủ lịch,
-- nên cuối file có INSERT lịch TAY (generate_series) cho 4 tour đó.
-- 6 tour trong ngày (duration_days=1) vẫn dùng auto-schedule.
-- Không dùng dấu ' trong chuỗi để tránh phá SQL literal; không lồng " trong jsonb.
-- ═══════════════════════════════════════════════════════════════

-- Kiểm tra trước: các slug sắp thêm đã tồn tại chưa (mong đợi 0 dòng)
select slug, status from public.tours where slug ~ '-1009[1-9]$' or slug ~ '-10100$';

-- ─────────────────────────────────────────────────────────────
-- 1. Pù Luông (Thanh Hóa) — trek ruộng bậc thang + homestay bản Thái, 2N1Đ
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
  'Pù Luông Bền Vững – Trek Ruộng Bậc Thang & Homestay Bản Thái 2N1Đ',
  'Sustainable Pu Luong: Rice Terrace Trek and Thai Homestay 2D1N',
  'tour-ben-vung-pu-luong-trek-homestay-10091',
  'Pù Luông', 'central', 2, 1,
  2400000, 75, 14, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1528127269322-539801943592?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1528127269322-539801943592?w=800&q=80'],
  ARRAY[
    'Khu bảo tồn thiên nhiên Pù Luông rừng nguyên sinh',
    'Trek qua ruộng bậc thang và bản làng người Thái',
    'Ngủ nhà sàn homestay do dân bản làm chủ',
    'Guồng nước cổ và suối Chàm mát lành',
    'Bữa ăn cây nhà lá vườn, tiền ở lại với cộng đồng'
  ],
  ARRAY[
    'Pu Luong Nature Reserve with primary forest',
    'Trek through rice terraces and Thai ethnic villages',
    'Sleep in a stilt-house homestay run by local families',
    'Ancient waterwheels and the cool Cham stream',
    'Home-grown meals, money that stays with the community'
  ],
  '[{"day":1,"title":"Hà Nội – Pù Luông: bản Hiêu, thác và homestay","activities":["07:00 Xe đón khách khu phố cổ Hà Nội đi Pù Luông","11:30 Tới Pù Luông, nhận phòng homestay nhà sàn bản Thái","12:00 Ăn trưa món địa phương do gia chủ nấu","14:00 Trek nhẹ tới bản Hiêu, tắm thác bậc thang","16:30 Ngắm guồng nước cổ và ruộng bậc thang lúc chiều","18:30 Ăn tối quây quần bên bếp lửa nhà sàn","20:00 Giao lưu văn nghệ với người Thái, nghỉ đêm tại homestay"]},{"day":2,"title":"Trek đỉnh và về Hà Nội","activities":["07:00 Ăn sáng, ngắm bình minh trên thung lũng","08:00 Trek xuyên rừng và ruộng bậc thang lên điểm ngắm cao","10:30 Thăm bản người Thái, tìm hiểu dệt thổ cẩm","12:00 Ăn trưa chia tay tại homestay","13:30 Xe về Hà Nội","18:00 Về đến phố cổ Hà Nội, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Hanoi – Pu Luong: Hieu village, waterfall and homestay","activities":["07:00 Pickup in Hanoi Old Quarter, drive to Pu Luong","11:30 Arrive at Pu Luong, check in to a Thai stilt-house homestay","12:00 Local lunch cooked by the host family","14:00 Easy trek to Hieu village, swim at the tiered waterfall","16:30 See ancient waterwheels and rice terraces in the afternoon light","18:30 Dinner together by the stilt-house fire","20:00 Cultural exchange with the Thai family, overnight at the homestay"]},{"day":2,"title":"Ridge trek and back to Hanoi","activities":["07:00 Breakfast, watch sunrise over the valley","08:00 Trek through forest and terraces up to a high viewpoint","10:30 Visit a Thai village, learn about brocade weaving","12:00 Farewell lunch at the homestay","13:30 Drive back to Hanoi","18:00 Arrive in Hanoi Old Quarter, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"hotel":"1 đêm homestay nhà sàn bản Thái","meals":"Toàn bộ bữa ăn theo chương trình (cây nhà lá vườn)","entrance_fees":"Vé khu bảo tồn Pù Luông"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"hotel":"1 night in a Thai stilt-house homestay","meals":"All meals per the program (home-grown)","entrance_fees":"Pu Luong reserve ticket"}'::jsonb,
  'Pù Luông là khu bảo tồn thiên nhiên ở Thanh Hóa với rừng nguyên sinh, ruộng bậc thang và những bản người Thái sống hài hòa với núi rừng. Tour hai ngày đưa bạn trek nhẹ qua bản Hiêu, tắm thác, ngắm guồng nước cổ và ngủ nhà sàn do chính dân bản làm chủ. Ăn cơm cây nhà lá vườn, nghe hát Thái bên bếp lửa. Phần lớn chi phí ở lại với cộng đồng địa phương, đúng tinh thần du lịch bền vững.',
  'Pu Luong is a nature reserve in Thanh Hoa with primary forest, rice terraces and Thai ethnic villages living in harmony with the mountains. This two-day tour takes you on an easy trek to Hieu village, a swim at the waterfall, ancient waterwheels and a night in a stilt house run by local families. You eat home-grown meals and hear Thai songs by the fire. Most of the cost stays with the local community, in the true spirit of sustainable travel.',
  'Two-day sustainable Pu Luong trek with rice terraces, a waterfall and a community-run Thai homestay.',
  'Tour bền vững Pù Luông 2N1Đ: trek ruộng bậc thang, tắm thác bản Hiêu, homestay nhà sàn người Thái, ăn cơm cộng đồng. Từ Hà Nội, tiền ở lại với dân bản.',
  '["Đồ uống ngoài chương trình","Chi tiêu cá nhân","Tip cho HDV và tài xế"]'::jsonb,
  '["Drinks outside the program","Personal expenses","Tips for guide and driver"]'::jsonb,
  'Đón tại khách sạn khu vực phố cổ Hà Nội', '07:00',
  'multi_day', 'moderate', 'vi_en', 'flexible', 'standard',
  '["pù luông","homestay","trek","du lịch cộng đồng","bền vững"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'tour-ben-vung-pu-luong-trek-homestay-10091');

-- ─────────────────────────────────────────────────────────────
-- 2. Mai Châu (Phú Thọ) — homestay bản Lác người Thái, đạp xe đồng lúa, 2N1Đ
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
  'Mai Châu Bền Vững – Homestay Bản Lác & Đạp Xe Đồng Lúa 2N1Đ',
  'Sustainable Mai Chau: Ban Lac Homestay and Rice-Field Cycling 2D1N',
  'tour-ben-vung-mai-chau-homestay-dap-xe-10092',
  'Mai Châu', 'north', 2, 1,
  1900000, 75, 16, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1509233725247-49e657c54213?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1509233725247-49e657c54213?w=800&q=80'],
  ARRAY[
    'Thung lũng Mai Châu xanh mướt giữa vòng núi',
    'Ngủ nhà sàn bản Lác của người Thái trắng',
    'Đạp xe len lỏi giữa cánh đồng lúa và bản làng',
    'Xem múa xòe và thưởng rượu cần địa phương',
    'Mua thổ cẩm dệt tay, ủng hộ nghề truyền thống'
  ],
  ARRAY[
    'The lush Mai Chau valley ringed by mountains',
    'Sleep in a White Thai stilt house in Ban Lac',
    'Cycle through rice fields and small villages',
    'Watch the xoe dance and taste local rice wine',
    'Buy hand-woven brocade to support the traditional craft'
  ],
  '[{"day":1,"title":"Hà Nội – Mai Châu: bản Lác và đạp xe","activities":["08:00 Xe đón khách khu phố cổ Hà Nội đi Mai Châu","11:00 Dừng đèo Thung Khe ngắm toàn cảnh thung lũng","11:45 Tới bản Lác, nhận nhà sàn homestay","12:30 Ăn trưa món Thái do gia chủ nấu","14:30 Đạp xe qua bản Poom Coọng, đồng lúa và cọn nước","16:30 Ghé nhà dệt thổ cẩm, tìm hiểu nghề","18:30 Ăn tối bên bếp lửa nhà sàn","20:00 Xem múa xòe, uống rượu cần, nghỉ đêm bản Lác"]},{"day":2,"title":"Chợ phiên và về Hà Nội","activities":["07:00 Ăn sáng, dạo bản buổi sớm","08:30 Đi bộ tới bản người Thái xa hơn, chào hỏi dân bản","10:30 Tự do mua thổ cẩm, đặc sản làm quà","12:00 Ăn trưa chia tay tại homestay","13:30 Xe về Hà Nội","17:00 Về đến phố cổ Hà Nội, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Hanoi – Mai Chau: Ban Lac and cycling","activities":["08:00 Pickup in Hanoi Old Quarter, drive to Mai Chau","11:00 Stop at Thung Khe pass for a valley panorama","11:45 Arrive at Ban Lac, check in to a stilt-house homestay","12:30 Thai lunch cooked by the host family","14:30 Cycle through Poom Coong village, rice fields and waterwheels","16:30 Visit a brocade weaving house and learn the craft","18:30 Dinner by the stilt-house fire","20:00 Watch the xoe dance, taste rice wine, overnight in Ban Lac"]},{"day":2,"title":"Village walk and back to Hanoi","activities":["07:00 Breakfast, an early stroll through the village","08:30 Walk to a further Thai village and meet the residents","10:30 Free time to buy brocade and specialties as gifts","12:00 Farewell lunch at the homestay","13:30 Drive back to Hanoi","17:00 Arrive in Hanoi Old Quarter, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"hotel":"1 đêm homestay nhà sàn bản Lác","meals":"Toàn bộ bữa ăn theo chương trình","activities":"Thuê xe đạp và xem múa xòe"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"hotel":"1 night in a Ban Lac stilt-house homestay","meals":"All meals per the program","activities":"Bicycle rental and the xoe dance show"}'::jsonb,
  'Chỉ cách Hà Nội vài giờ xe, thung lũng Mai Châu mở ra một vùng lúa xanh mướt ôm bởi núi đá, nơi người Thái trắng vẫn sống trong những nếp nhà sàn. Tour hai ngày cho bạn ngủ homestay bản Lác, đạp xe len lỏi giữa đồng lúa và bản làng, xem múa xòe và mua thổ cẩm dệt tay. Ở cùng, ăn cùng và tiêu tiền trực tiếp với dân bản — cách du lịch nhẹ nhàng, có trách nhiệm.',
  'Just a few hours from Hanoi, the Mai Chau valley opens onto lush green rice fields ringed by limestone peaks, where the White Thai still live in stilt houses. This two-day tour lets you stay in a Ban Lac homestay, cycle among the fields and villages, watch the xoe dance and buy hand-woven brocade. You stay, eat and spend directly with local families — a gentle, responsible way to travel.',
  'Two-day sustainable Mai Chau tour with a Ban Lac homestay, rice-field cycling and the Thai xoe dance.',
  'Tour bền vững Mai Châu 2N1Đ: homestay nhà sàn bản Lác, đạp xe đồng lúa, múa xòe, thổ cẩm dệt tay. Từ Hà Nội, tiêu tiền trực tiếp với cộng đồng người Thái.',
  '["Đồ uống ngoài chương trình","Chi tiêu cá nhân","Tip cho HDV và tài xế"]'::jsonb,
  '["Drinks outside the program","Personal expenses","Tips for guide and driver"]'::jsonb,
  'Đón tại khách sạn khu vực phố cổ Hà Nội', '08:00',
  'multi_day', 'easy', 'vi_en', 'flexible', 'standard',
  '["mai châu","bản lác","homestay","đạp xe","bền vững"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'tour-ben-vung-mai-chau-homestay-dap-xe-10092');

-- ─────────────────────────────────────────────────────────────
-- 3. Hà Giang (Tuyên Quang) — cao nguyên đá Đồng Văn, homestay người Mông, 3N2Đ
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
  'Hà Giang Bền Vững – Cao Nguyên Đá Đồng Văn & Homestay Người Mông 3N2Đ',
  'Sustainable Ha Giang: Dong Van Karst Plateau and Hmong Homestay 3D2N',
  'tour-ben-vung-ha-giang-cao-nguyen-da-10093',
  'Hà Giang', 'north', 3, 2,
  3900000, 75, 12, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1573790387438-4da905039392?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1573790387438-4da905039392?w=800&q=80'],
  ARRAY[
    'Công viên địa chất toàn cầu cao nguyên đá Đồng Văn',
    'Đèo Mã Pí Lèng hùng vĩ bên sông Nho Quế',
    'Homestay người Mông, ăn ngủ cùng gia đình bản địa',
    'Dinh thự họ Vương và phố cổ Đồng Văn',
    'Đi thuyền hẻm Tu Sản, ngắm hẻm vực sâu nhất Đông Nam Á'
  ],
  ARRAY[
    'The Dong Van Karst Plateau UNESCO Global Geopark',
    'The mighty Ma Pi Leng pass above the Nho Que river',
    'A Hmong homestay, eating and sleeping with a local family',
    'The Vuong family mansion and Dong Van old town',
    'A boat ride through Tu San canyon, the deepest in Southeast Asia'
  ],
  '[{"day":1,"title":"Hà Giang – Quản Bạ – Yên Minh","activities":["07:00 Xe đón khách phố cổ Hà Nội đi Hà Giang","13:00 Tới TP Hà Giang, ăn trưa, bắt đầu cung cao nguyên đá","14:30 Cổng trời và núi đôi Quản Bạ","16:30 Rừng thông Yên Minh, dừng chụp ảnh","18:00 Nhận homestay người Mông, ăn tối cùng gia đình","20:00 Nghỉ đêm tại homestay bản Mông"]},{"day":2,"title":"Đồng Văn – Mã Pí Lèng – Nho Quế","activities":["07:00 Ăn sáng, đi Đồng Văn","08:30 Dinh thự họ Vương và cột cờ Lũng Cú","11:30 Phố cổ Đồng Văn, ăn trưa đặc sản","14:00 Chinh phục đèo Mã Pí Lèng","15:00 Đi thuyền trên sông Nho Quế qua hẻm Tu Sản","17:30 Về homestay khu Đồng Văn, ăn tối","20:00 Giao lưu văn nghệ, nghỉ đêm"]},{"day":3,"title":"Chợ phiên và về Hà Nội","activities":["07:00 Ăn sáng, ghé chợ phiên vùng cao (nếu đúng ngày)","09:00 Dừng ngắm ruộng bậc thang Hoàng Su Phì trên đường về","12:00 Ăn trưa tại TP Hà Giang","13:00 Xe về Hà Nội","19:30 Về đến phố cổ Hà Nội, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Ha Giang – Quan Ba – Yen Minh","activities":["07:00 Pickup in Hanoi Old Quarter, drive to Ha Giang","13:00 Reach Ha Giang city, lunch, begin the karst plateau loop","14:30 Heaven Gate and the Quan Ba twin mountains","16:30 Yen Minh pine forest, photo stop","18:00 Check in to a Hmong homestay, dinner with the family","20:00 Overnight at the Hmong homestay"]},{"day":2,"title":"Dong Van – Ma Pi Leng – Nho Que","activities":["07:00 Breakfast, drive to Dong Van","08:30 The Vuong family mansion and Lung Cu flag tower","11:30 Dong Van old town, specialty lunch","14:00 Conquer the Ma Pi Leng pass","15:00 Boat ride on the Nho Que river through Tu San canyon","17:30 Back to a homestay near Dong Van, dinner","20:00 Cultural exchange, overnight"]},{"day":3,"title":"Market and back to Hanoi","activities":["07:00 Breakfast, visit a highland market if it is market day","09:00 Stop for the Hoang Su Phi rice terraces on the way back","12:00 Lunch in Ha Giang city","13:00 Drive back to Hanoi","19:30 Arrive in Hanoi Old Quarter, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"hotel":"2 đêm homestay người Mông","meals":"Toàn bộ bữa ăn theo chương trình","boat":"Vé thuyền sông Nho Quế","entrance_fees":"Vé các điểm tham quan trong lịch trình"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"hotel":"2 nights in Hmong homestays","meals":"All meals per the program","boat":"Nho Que river boat ticket","entrance_fees":"Entrance fees for sights in the program"}'::jsonb,
  'Cao nguyên đá Đồng Văn ở Hà Giang là công viên địa chất toàn cầu được UNESCO công nhận, nơi núi đá tai mèo trải dài tới chân trời và các bản người Mông bám vào sườn núi. Tour ba ngày đưa bạn qua đèo Mã Pí Lèng hùng vĩ, đi thuyền hẻm Tu Sản trên sông Nho Quế, thăm dinh thự họ Vương và phố cổ Đồng Văn. Bạn ăn ngủ trong homestay người Mông, tiền chi tiêu ở lại với đồng bào vùng cao — trải nghiệm nguyên bản và có trách nhiệm.',
  'The Dong Van Karst Plateau in Ha Giang is a UNESCO Global Geopark where jagged limestone stretches to the horizon and Hmong villages cling to the slopes. This three-day tour takes you over the mighty Ma Pi Leng pass, on a boat through Tu San canyon on the Nho Que river, and to the Vuong mansion and Dong Van old town. You eat and sleep in Hmong homestays, and your spending stays with the highland communities — an authentic and responsible experience.',
  'Three-day sustainable Ha Giang loop over the Dong Van karst plateau with Hmong homestays and the Nho Que river.',
  'Tour bền vững Hà Giang 3N2Đ: cao nguyên đá Đồng Văn, đèo Mã Pí Lèng, thuyền sông Nho Quế, homestay người Mông. Từ Hà Nội, tiền ở lại với đồng bào vùng cao.',
  '["Đồ uống ngoài chương trình","Chi tiêu cá nhân","Tip cho HDV và tài xế"]'::jsonb,
  '["Drinks outside the program","Personal expenses","Tips for guide and driver"]'::jsonb,
  'Đón tại khách sạn khu vực phố cổ Hà Nội', '07:00',
  'multi_day', 'moderate', 'vi_en', 'moderate', 'standard',
  '["hà giang","cao nguyên đá","homestay","người mông","bền vững"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'tour-ben-vung-ha-giang-cao-nguyen-da-10093');

-- ─────────────────────────────────────────────────────────────
-- 4. Cúc Phương (Ninh Bình) — vườn quốc gia, cứu hộ linh trưởng, 1 ngày
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
  'Cúc Phương Bền Vững – Vườn Quốc Gia & Trung Tâm Cứu Hộ Linh Trưởng',
  'Sustainable Cuc Phuong: National Park and Primate Rescue Center',
  'tour-ben-vung-cuc-phuong-vuon-quoc-gia-10094',
  'Cúc Phương', 'north', 1, 0,
  850000, 75, 16, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=800&q=80'],
  ARRAY[
    'Vườn quốc gia đầu tiên của Việt Nam, rừng nguyên sinh',
    'Trung tâm cứu hộ linh trưởng nguy cấp EPRC',
    'Trung tâm bảo tồn rùa và thú ăn thịt nhỏ',
    'Cây chò ngàn năm và động Người Xưa',
    'Đi bộ trong rừng cùng kiểm lâm, học về bảo tồn'
  ],
  ARRAY[
    'Vietnams first national park, with primary rainforest',
    'The Endangered Primate Rescue Center',
    'The Turtle Conservation Center and small carnivore program',
    'The thousand-year-old tree and the Prehistoric Cave',
    'A guided forest walk with rangers, learning about conservation'
  ],
  '[{"day":1,"title":"Cúc Phương – rừng nguyên sinh và cứu hộ động vật","activities":["07:30 Xe đón khách khu vực Hà Nội hoặc Ninh Bình","09:30 Tới vườn quốc gia Cúc Phương, nghe giới thiệu bảo tồn","10:00 Thăm Trung tâm cứu hộ linh trưởng nguy cấp EPRC","11:00 Trung tâm bảo tồn rùa, tìm hiểu chương trình thả về rừng","12:00 Ăn trưa trong rừng","13:30 Đi bộ tới cây chò ngàn năm và động Người Xưa","15:30 Đạp xe hoặc đi bộ ngắm rừng, quan sát chim bướm","16:30 Xe về, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Cuc Phuong – primary forest and animal rescue","activities":["07:30 Pickup in Hanoi or Ninh Binh","09:30 Arrive at Cuc Phuong National Park, a conservation briefing","10:00 Visit the Endangered Primate Rescue Center","11:00 The Turtle Conservation Center and its release program","12:00 Lunch in the forest","13:30 Walk to the thousand-year-old tree and the Prehistoric Cave","15:30 Cycle or walk in the forest, watch birds and butterflies","16:30 Drive back, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Vé vườn quốc gia + các trung tâm cứu hộ","meals":"Ăn trưa trong rừng"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Park entry and rescue-center tickets","meals":"Lunch in the forest"}'::jsonb,
  'Cúc Phương là vườn quốc gia đầu tiên của Việt Nam, một dải rừng nguyên sinh với cây chò ngàn năm và những chương trình bảo tồn động vật hàng đầu cả nước. Tour trong ngày đưa bạn thăm Trung tâm cứu hộ linh trưởng nguy cấp và trung tâm bảo tồn rùa, đi bộ trong rừng cùng kiểm lâm và ngắm chim bướm. Vé tham quan góp trực tiếp cho công tác cứu hộ — một ngày gần gũi thiên nhiên và hiểu về bảo tồn.',
  'Cuc Phuong is Vietnams first national park, a stretch of primary rainforest with a thousand-year-old tree and some of the countrys leading wildlife conservation programs. This day tour takes you to the Endangered Primate Rescue Center and the Turtle Conservation Center, on a forest walk with rangers and to watch birds and butterflies. Your ticket goes directly to the rescue work — a day close to nature and to real conservation.',
  'Day tour of Cuc Phuong National Park with the primate and turtle rescue centers and a guided forest walk.',
  'Tour bền vững Cúc Phương 1 ngày: vườn quốc gia đầu tiên VN, cứu hộ linh trưởng và rùa, cây chò ngàn năm, đi bộ rừng cùng kiểm lâm. Vé góp cho bảo tồn.',
  '["Đồ uống ngoài chương trình","Thuê xe đạp trong rừng (nếu chọn)","Tip cho HDV và tài xế"]'::jsonb,
  '["Drinks outside the program","Bicycle rental in the park (if chosen)","Tips for guide and driver"]'::jsonb,
  'Đón tại khách sạn khu vực Hà Nội hoặc Ninh Bình', '07:30',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["cúc phương","vườn quốc gia","cứu hộ linh trưởng","bền vững"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'tour-ben-vung-cuc-phuong-vuon-quoc-gia-10094');

-- ─────────────────────────────────────────────────────────────
-- 5. Cát Bà (Hải Phòng) — vườn quốc gia + kayak vịnh Lan Hạ, 1 ngày
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
  'Cát Bà Bền Vững – Trek Vườn Quốc Gia & Kayak Vịnh Lan Hạ',
  'Sustainable Cat Ba: National Park Trek and Lan Ha Bay Kayaking',
  'tour-ben-vung-cat-ba-vuon-quoc-gia-kayak-10095',
  'Cát Bà', 'north', 1, 0,
  950000, 75, 16, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1573843981267-be1999ff37cd?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1573843981267-be1999ff37cd?w=800&q=80'],
  ARRAY[
    'Khu dự trữ sinh quyển thế giới quần đảo Cát Bà',
    'Trek rừng nguyên sinh vườn quốc gia Cát Bà',
    'Nơi sinh sống của voọc Cát Bà cực kỳ nguy cấp',
    'Chèo kayak vịnh Lan Hạ trong xanh, ít tàu bè',
    'Tắm biển vụng vắng và ngắm đảo đá hoang sơ'
  ],
  ARRAY[
    'The Cat Ba Archipelago World Biosphere Reserve',
    'A rainforest trek in Cat Ba National Park',
    'Home of the critically endangered Cat Ba langur',
    'Kayaking on the clear, quiet Lan Ha Bay',
    'Swimming in hidden coves among wild karsts'
  ],
  '[{"day":1,"title":"Cát Bà – rừng quốc gia và vịnh Lan Hạ","activities":["08:00 Đón khách tại bến hoặc khách sạn Cát Bà","08:45 Vào vườn quốc gia Cát Bà, nghe giới thiệu về voọc Cát Bà","09:15 Trek rừng nguyên sinh lên đỉnh Ngự Lâm ngắm toàn cảnh","11:00 Xuống núi, di chuyển ra bến tàu","11:45 Ăn trưa trước khi lên thuyền","13:00 Du thuyền vào vịnh Lan Hạ, ngắm đảo đá","14:00 Chèo kayak luồn hang, tắm biển vụng vắng","16:00 Thuyền về bến","16:45 Đưa về khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Cat Ba – national park and Lan Ha Bay","activities":["08:00 Pickup at the pier or a Cat Ba hotel","08:45 Enter Cat Ba National Park, a briefing on the Cat Ba langur","09:15 Rainforest trek up to Ngu Lam peak for a panorama","11:00 Descend and transfer to the pier","11:45 Lunch before boarding","13:00 Cruise into Lan Ha Bay among the karsts","14:00 Kayak through caves, swim in a quiet cove","16:00 Boat back to the pier","16:45 Transfer to hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"boat":"Du thuyền + kayak","entrance_fees":"Vé vườn quốc gia + vịnh Lan Hạ","meals":"Ăn trưa"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"boat":"Cruise boat and kayak","entrance_fees":"National park and Lan Ha Bay tickets","meals":"Lunch"}'::jsonb,
  'Quần đảo Cát Bà là khu dự trữ sinh quyển thế giới, nơi rừng nguyên sinh trên núi đá vôi gặp làn nước xanh của vịnh Lan Hạ, và là nhà của loài voọc Cát Bà cực kỳ nguy cấp chỉ còn vài chục cá thể. Tour trong ngày kết hợp trek rừng quốc gia lên đỉnh ngắm toàn cảnh và chèo kayak vịnh Lan Hạ vắng lặng. Một hành trình gọn nhẹ, ít tác động, cho bạn thấy vì sao nơi đây cần được giữ gìn.',
  'The Cat Ba Archipelago is a World Biosphere Reserve where limestone rainforest meets the blue water of Lan Ha Bay, and home to the critically endangered Cat Ba langur, of which only a few dozen remain. This day tour combines a national-park trek to a summit panorama with kayaking on quiet Lan Ha Bay. A compact, low-impact journey that shows you why this place needs protecting.',
  'Day tour of Cat Ba with a national-park rainforest trek and kayaking on quiet Lan Ha Bay.',
  'Tour bền vững Cát Bà 1 ngày: trek vườn quốc gia khu dự trữ sinh quyển, quê hương voọc Cát Bà, chèo kayak vịnh Lan Hạ, tắm biển vụng vắng. Ít tác động.',
  '["Đồ uống ngoài chương trình","Vé phà ra đảo (nếu đi từ đất liền)","Tip cho HDV và thuyền viên"]'::jsonb,
  '["Drinks outside the program","Ferry ticket to the island if coming from the mainland","Tips for guide and crew"]'::jsonb,
  'Đón tại bến tàu hoặc khách sạn khu vực Cát Bà', '08:00',
  'day_tour', 'moderate', 'vi_en', 'flexible', 'standard',
  '["cát bà","vườn quốc gia","kayak","lan hạ","bền vững"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'tour-ben-vung-cat-ba-vuon-quoc-gia-kayak-10095');

-- ─────────────────────────────────────────────────────────────
-- 6. Cù Lao Chàm (Đà Nẵng) — khu dự trữ sinh quyển, đảo không rác nhựa, 1 ngày
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
  'Cù Lao Chàm Bền Vững – Đảo Không Rác Nhựa & Lặn Ngắm San Hô',
  'Sustainable Cu Lao Cham: Plastic-Free Island and Coral Snorkeling',
  'tour-ben-vung-cu-lao-cham-san-ho-10096',
  'Cù Lao Chàm', 'central', 1, 0,
  700000, 75, 20, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=800&q=80'],
  ARRAY[
    'Khu dự trữ sinh quyển thế giới Cù Lao Chàm',
    'Hòn đảo tiên phong nói không với túi nilon',
    'Lặn ống thở ngắm rạn san hô đầy màu sắc',
    'Làng chài Bãi Làng và chùa Hải Tạng cổ',
    'Tắm biển Bãi Chồng nước trong như pha lê'
  ],
  ARRAY[
    'The Cu Lao Cham World Biosphere Reserve',
    'A pioneering island that says no to plastic bags',
    'Snorkel over colorful coral reefs',
    'Bai Lang fishing village and the old Hai Tang pagoda',
    'Swim at Bai Chong beach with crystal-clear water'
  ],
  '[{"day":1,"title":"Cù Lao Chàm – biển đảo và san hô","activities":["08:00 Đón khách tại khách sạn khu vực Hội An ra bến Cửa Đại","08:30 Cano ra đảo Cù Lao Chàm, nghe quy định bảo vệ môi trường","09:15 Thăm làng chài Bãi Làng, chùa Hải Tạng, chợ hải sản","10:30 Lặn ống thở ngắm san hô tại khu bảo tồn biển","12:00 Ăn trưa hải sản trên đảo","13:30 Tắm biển Bãi Chồng, thư giãn dưới rặng dừa","15:00 Cano về đất liền","15:45 Đưa về khách sạn Hội An, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Cu Lao Cham – island and coral","activities":["08:00 Pickup at a Hoi An hotel, transfer to Cua Dai pier","08:30 Speedboat to Cu Lao Cham, an environmental briefing","09:15 Visit Bai Lang village, Hai Tang pagoda and the seafood market","10:30 Snorkel over coral in the marine protected area","12:00 Seafood lunch on the island","13:30 Swim at Bai Chong beach, relax under the palms","15:00 Speedboat back to the mainland","15:45 Transfer to Hoi An hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"boat":"Cano khứ hồi + đồ lặn ống thở","entrance_fees":"Phí tham quan khu bảo tồn biển","meals":"Ăn trưa hải sản trên đảo"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"boat":"Round-trip speedboat and snorkeling gear","entrance_fees":"Marine reserve fee","meals":"Seafood lunch on the island"}'::jsonb,
  'Cù Lao Chàm ngoài khơi Hội An là khu dự trữ sinh quyển thế giới, hòn đảo nổi tiếng vì đã tiên phong nói không với túi nilon từ nhiều năm nay. Tour trong ngày đưa bạn lặn ống thở ngắm rạn san hô trong khu bảo tồn biển, thăm làng chài và ngôi chùa cổ, tắm biển Bãi Chồng nước trong vắt. Đến đây bạn được nhắc mang theo ý thức giữ đảo sạch — một điểm đến mẫu mực về du lịch có trách nhiệm.',
  'Cu Lao Cham off Hoi An is a World Biosphere Reserve, an island famous for pioneering a ban on plastic bags years ago. This day tour takes you snorkeling over coral in the marine protected area, to a fishing village and an old pagoda, and swimming at the clear Bai Chong beach. Visitors are asked to help keep the island clean — a model destination for responsible travel.',
  'Day tour of the plastic-free Cu Lao Cham biosphere reserve with coral snorkeling and a village visit.',
  'Tour bền vững Cù Lao Chàm 1 ngày: đảo không túi nilon, lặn ngắm san hô khu bảo tồn biển, làng chài, chùa Hải Tạng, tắm Bãi Chồng. Từ Hội An.',
  '["Đồ uống ngoài chương trình","Thuê thiết bị lặn nâng cấp","Tip cho HDV và thuyền viên"]'::jsonb,
  '["Drinks outside the program","Upgraded diving gear rental","Tips for guide and crew"]'::jsonb,
  'Đón tại khách sạn khu vực Hội An', '08:00',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["cù lao chàm","san hô","dự trữ sinh quyển","không rác nhựa","bền vững"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'tour-ben-vung-cu-lao-cham-san-ho-10096');

-- ─────────────────────────────────────────────────────────────
-- 7. Bản Đôn (Đắk Lắk) — voi thân thiện không cưỡi, buôn Ê Đê, 1 ngày
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
  'Bản Đôn Bền Vững – Voi Thân Thiện Không Cưỡi & Buôn Làng Ê Đê',
  'Sustainable Ban Don: Ethical No-Riding Elephants and Ede Village',
  'tour-ben-vung-ban-don-voi-than-thien-10097',
  'Bản Đôn', 'central', 1, 0,
  900000, 75, 16, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1513026705753-bc3fffca8bf4?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1513026705753-bc3fffca8bf4?w=800&q=80'],
  ARRAY[
    'Mô hình voi thân thiện: ngắm và cho voi ăn, không cưỡi',
    'Đi bộ cùng voi trong rừng, xem voi tắm sông',
    'Buôn làng Ê Đê và văn hóa cồng chiêng Tây Nguyên',
    'Cầu treo Bản Đôn bắc qua sông Sê Rê Pốk',
    'Thưởng thức cà phê Buôn Ma Thuột chính gốc'
  ],
  ARRAY[
    'An ethical elephant model: watch and feed, no riding',
    'Walk alongside the elephants in the forest and watch them bathe',
    'An Ede village and Central Highlands gong culture',
    'The Ban Don suspension bridge over the Serepok river',
    'Taste authentic Buon Ma Thuot coffee'
  ],
  '[{"day":1,"title":"Bản Đôn – voi thân thiện và văn hóa Ê Đê","activities":["08:00 Xe đón khách khách sạn Buôn Ma Thuột đi Bản Đôn","09:15 Tới khu du lịch voi thân thiện, nghe về mô hình bảo vệ voi","09:45 Ngắm và cho voi ăn, đi bộ cùng voi trong rừng","11:00 Xem voi tắm và đằm mình bên sông Sê Rê Pốk","11:45 Qua cầu treo Bản Đôn nổi tiếng","12:30 Ăn trưa đặc sản Tây Nguyên tại buôn","14:00 Thăm buôn Ê Đê, nghe kể về nghề thuần voi xưa","15:00 Giao lưu cồng chiêng, thưởng cà phê Ban Mê","16:00 Xe về Buôn Ma Thuột, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Ban Don – ethical elephants and Ede culture","activities":["08:00 Pickup at a Buon Ma Thuot hotel, drive to Ban Don","09:15 Reach the ethical elephant site, learn about the model","09:45 Watch and feed the elephants, walk with them in the forest","11:00 Watch the elephants bathe by the Serepok river","11:45 Cross the famous Ban Don suspension bridge","12:30 Central Highlands lunch in the village","14:00 Visit an Ede village, hear about the old elephant-taming trade","15:00 A gong performance and a taste of Ban Me coffee","16:00 Drive back to Buon Ma Thuot, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Vé khu du lịch voi thân thiện và buôn làng","activities":"Cho voi ăn và giao lưu cồng chiêng","meals":"Ăn trưa đặc sản Tây Nguyên"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Ethical elephant site and village tickets","activities":"Elephant feeding and a gong performance","meals":"Central Highlands lunch"}'::jsonb,
  'Bản Đôn ở Đắk Lắk từng nổi tiếng với nghề thuần voi và cưỡi voi, nhưng nay đã chuyển sang mô hình voi thân thiện: du khách chỉ ngắm, cho voi ăn và đi bộ bên voi, để những con voi già được sống thảnh thơi. Tour trong ngày đưa bạn tới khu voi thân thiện bên sông Sê Rê Pốk, qua cầu treo Bản Đôn, thăm buôn Ê Đê và nghe cồng chiêng Tây Nguyên. Một cách du lịch tử tế với động vật và tôn trọng văn hóa bản địa.',
  'Ban Don in Dak Lak was once known for elephant taming and rides, but has shifted to an ethical elephant model: visitors only watch, feed and walk beside the elephants, letting the old animals live at ease. This day tour takes you to the ethical elephant site by the Serepok river, across the Ban Don suspension bridge, and to an Ede village with Central Highlands gongs. A kinder way to travel, gentle on animals and respectful of local culture.',
  'Day tour of Ban Don with ethical no-riding elephants, the Serepok river and an Ede village.',
  'Tour bền vững Bản Đôn 1 ngày: voi thân thiện không cưỡi, đi bộ cùng voi, cầu treo Sê Rê Pốk, buôn Ê Đê, cồng chiêng Tây Nguyên. Từ Buôn Ma Thuột.',
  '["Đồ uống ngoài chương trình","Chi tiêu cá nhân","Tip cho HDV và tài xế"]'::jsonb,
  '["Drinks outside the program","Personal expenses","Tips for guide and driver"]'::jsonb,
  'Đón tại khách sạn trung tâm Buôn Ma Thuột', '08:00',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["bản đôn","voi thân thiện","ê đê","tây nguyên","bền vững"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'tour-ben-vung-ban-don-voi-than-thien-10097');

-- ─────────────────────────────────────────────────────────────
-- 8. Đà Lạt (Lâm Đồng) — nông trại hữu cơ + rừng thông, farm-to-table, 1 ngày
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
  'Đà Lạt Bền Vững – Nông Trại Hữu Cơ, Farm-to-Table & Rừng Thông',
  'Sustainable Da Lat: Organic Farm, Farm-to-Table and Pine Forest',
  'tour-ben-vung-da-lat-nong-trai-huu-co-10098',
  'Đà Lạt', 'central', 1, 0,
  750000, 75, 16, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1505228395891-9a51e7e86bf6?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1505228395891-9a51e7e86bf6?w=800&q=80'],
  ARRAY[
    'Thăm nông trại rau và dâu hữu cơ trên cao nguyên',
    'Tự tay hái rau, tìm hiểu canh tác không hóa chất',
    'Bữa trưa farm-to-table từ nông sản tại vườn',
    'Đi bộ nhẹ trong rừng thông và bên hồ',
    'Trang trại cà phê Arabica và cách rang xay sạch'
  ],
  ARRAY[
    'Visit organic vegetable and strawberry farms on the plateau',
    'Pick your own produce, learn chemical-free farming',
    'A farm-to-table lunch from garden produce',
    'An easy walk in the pine forest and by a lake',
    'An Arabica coffee farm and clean roasting methods'
  ],
  '[{"day":1,"title":"Đà Lạt – nông trại hữu cơ và rừng thông","activities":["08:00 Đón khách tại khách sạn trung tâm Đà Lạt","08:45 Thăm nông trại rau hữu cơ, nghe về canh tác bền vững","09:30 Tự tay hái rau, dâu tây, cà chua trong nhà kính sinh thái","11:00 Thăm vườn cà phê Arabica, xem rang xay thủ công","12:00 Ăn trưa farm-to-table từ chính nông sản tại vườn","13:30 Đi bộ nhẹ trong rừng thông, ghé hồ Tuyền Lâm","15:00 Ghé cơ sở làm mứt và trà atisô thủ công","16:00 Đưa về khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Da Lat – organic farm and pine forest","activities":["08:00 Pickup at a central Da Lat hotel","08:45 Visit an organic vegetable farm, learn about sustainable growing","09:30 Pick vegetables, strawberries and tomatoes in an eco greenhouse","11:00 Visit an Arabica coffee garden, see hand roasting","12:00 A farm-to-table lunch from the garden produce","13:30 An easy walk in the pine forest, stop at Tuyen Lam lake","15:00 Visit a workshop for handmade jam and artichoke tea","16:00 Transfer to hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Vé tham quan nông trại","activities":"Trải nghiệm hái rau và pha cà phê","meals":"Ăn trưa farm-to-table"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Farm visit tickets","activities":"Vegetable picking and a coffee tasting","meals":"Farm-to-table lunch"}'::jsonb,
  'Đà Lạt là vựa rau và hoa của cả nước, và ngày càng nhiều nông trại nơi đây chuyển sang canh tác hữu cơ, không hóa chất. Tour trong ngày đưa bạn vào những nông trại sinh thái để tự tay hái rau, dâu và cà chua, tìm hiểu cách trồng bền vững, rồi thưởng bữa trưa farm-to-table nấu từ chính nông sản trong vườn. Chiều đi bộ nhẹ trong rừng thông bên hồ. Một ngày chậm rãi, hiểu về thực phẩm sạch và nông nghiệp có trách nhiệm.',
  'Da Lat is the vegetable and flower basket of Vietnam, and more of its farms are turning to organic, chemical-free growing. This day tour takes you into eco farms to pick your own vegetables, strawberries and tomatoes, learn sustainable methods, then enjoy a farm-to-table lunch cooked from the garden produce. In the afternoon there is an easy walk in the pine forest by a lake. A slow day about clean food and responsible farming.',
  'Day tour of Da Lat organic farms with produce picking, a farm-to-table lunch and a pine-forest walk.',
  'Tour bền vững Đà Lạt 1 ngày: nông trại rau dâu hữu cơ, tự hái nông sản, bữa trưa farm-to-table, vườn cà phê Arabica, rừng thông hồ Tuyền Lâm.',
  '["Đồ uống ngoài chương trình","Mua nông sản, đặc sản mang về","Tip cho HDV và tài xế"]'::jsonb,
  '["Drinks outside the program","Buying produce and specialties to take home","Tips for guide and driver"]'::jsonb,
  'Đón tại khách sạn trung tâm Đà Lạt', '08:00',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["đà lạt","nông trại hữu cơ","farm to table","rừng thông","bền vững"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'tour-ben-vung-da-lat-nong-trai-huu-co-10098');

-- ─────────────────────────────────────────────────────────────
-- 9. Mekong Cần Thơ — chợ nổi Cái Răng + homestay cồn, làm bánh dân gian, 2N1Đ
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
  'Mekong Cần Thơ Bền Vững – Chợ Nổi Cái Răng & Homestay Miệt Vườn 2N1Đ',
  'Sustainable Mekong Can Tho: Cai Rang Floating Market and Orchard Homestay 2D1N',
  'tour-ben-vung-mekong-can-tho-cho-noi-10099',
  'Cần Thơ', 'south', 2, 1,
  2100000, 75, 16, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1558005530-a7958896ec60?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1558005530-a7958896ec60?w=800&q=80'],
  ARRAY[
    'Chợ nổi Cái Răng buổi sớm nhộn nhịp trên sông',
    'Ngủ homestay miệt vườn do gia đình nông dân làm chủ',
    'Đạp xe và chèo xuồng ba lá trong kênh rạch',
    'Học làm bánh dân gian và nghe đờn ca tài tử',
    'Ăn trái cây hái tại vườn, sống nhịp sông nước'
  ],
  ARRAY[
    'The lively early-morning Cai Rang floating market',
    'Stay in an orchard homestay run by a farming family',
    'Cycle and paddle a sampan through the canals',
    'Learn to make folk cakes and hear tai tu music',
    'Eat fruit picked in the garden, live the river rhythm'
  ],
  '[{"day":1,"title":"Cần Thơ – cồn miệt vườn và homestay","activities":["09:00 Đón khách khu vực TP Hồ Chí Minh hoặc Cần Thơ","12:00 Tới Cần Thơ, ăn trưa, xuống thuyền qua cồn","13:30 Nhận homestay miệt vườn của gia đình nông dân","14:30 Đạp xe và đi bộ thăm vườn cây trái, hái trái cây","16:00 Chèo xuồng ba lá trong kênh rạch nhỏ","17:30 Học làm bánh dân gian cùng gia chủ","19:00 Ăn tối món quê, nghe đờn ca tài tử Nam Bộ","21:00 Nghỉ đêm tại homestay"]},{"day":2,"title":"Chợ nổi Cái Răng và về","activities":["05:00 Dậy sớm, xuống thuyền đi chợ nổi Cái Răng","05:45 Chợ nổi buổi bình minh, ăn sáng trên ghe","07:30 Ghé lò hủ tiếu và vườn ca cao ven sông","09:00 Về homestay, nghỉ ngơi, thu xếp hành lý","10:30 Ăn trưa chia tay tại vườn","12:00 Thuyền vào bờ, xe đưa về","15:30 Về đến điểm đón ban đầu, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Can Tho – orchard islet and homestay","activities":["09:00 Pickup in Ho Chi Minh City or Can Tho","12:00 Reach Can Tho, lunch, board a boat to the islet","13:30 Check in to an orchard homestay run by a farming family","14:30 Cycle and walk through the fruit gardens, pick fruit","16:00 Paddle a sampan through the small canals","17:30 Learn to make folk cakes with the host","19:00 Country dinner and southern tai tu music","21:00 Overnight at the homestay"]},{"day":2,"title":"Cai Rang floating market and return","activities":["05:00 Early rise, board a boat to Cai Rang floating market","05:45 The market at dawn, breakfast on the boat","07:30 Visit a noodle workshop and a riverside cacao garden","09:00 Back to the homestay, rest and pack","10:30 Farewell lunch in the garden","12:00 Boat to shore, transfer back","15:30 Arrive at the original pickup point, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"hotel":"1 đêm homestay miệt vườn","boat":"Thuyền đi chợ nổi và chèo xuồng ba lá","meals":"Toàn bộ bữa ăn theo chương trình","activities":"Học làm bánh và đờn ca tài tử"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"hotel":"1 night in an orchard homestay","boat":"Floating-market boat and sampan paddling","meals":"All meals per the program","activities":"Cake making and tai tu music"}'::jsonb,
  'Miền Tây sông nước đẹp nhất khi bạn sống chậm cùng người dân. Tour hai ngày đưa bạn về Cần Thơ ngủ homestay miệt vườn do chính gia đình nông dân làm chủ: đạp xe qua vườn cây trái, chèo xuồng ba lá trong kênh rạch, học làm bánh dân gian và nghe đờn ca tài tử. Sáng sớm hôm sau xuống thuyền ra chợ nổi Cái Răng lúc bình minh, ăn sáng trên ghe. Tiền ở lại với nhà vườn, trải nghiệm nguyên bản nhịp sống sông nước.',
  'The Mekong Delta is at its best when you slow down and live alongside its people. This two-day tour takes you to Can Tho to stay in an orchard homestay run by a farming family: cycle through fruit gardens, paddle a sampan in the canals, learn to make folk cakes and hear tai tu music. The next morning you board a boat to Cai Rang floating market at dawn and have breakfast on the water. The money stays with the family, and the experience is an authentic taste of river life.',
  'Two-day sustainable Mekong tour with a Can Tho orchard homestay and the Cai Rang floating market at dawn.',
  'Tour bền vững Mekong Cần Thơ 2N1Đ: homestay miệt vườn nông dân, chợ nổi Cái Răng bình minh, chèo xuồng ba lá, làm bánh dân gian, đờn ca tài tử.',
  '["Đồ uống ngoài chương trình","Chi tiêu cá nhân","Tip cho HDV và tài xế"]'::jsonb,
  '["Drinks outside the program","Personal expenses","Tips for guide and driver"]'::jsonb,
  'Đón tại khách sạn khu vực TP. Hồ Chí Minh hoặc Cần Thơ', '09:00',
  'multi_day', 'easy', 'vi_en', 'flexible', 'standard',
  '["mekong","cần thơ","chợ nổi cái răng","homestay","bền vững"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'tour-ben-vung-mekong-can-tho-cho-noi-10099');

-- ─────────────────────────────────────────────────────────────
-- 10. Rừng tràm Trà Sư (An Giang) — chèo xuồng rừng ngập nước, sân chim, 1 ngày
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
  'Trà Sư Bền Vững – Chèo Xuồng Rừng Tràm Ngập Nước & Sân Chim',
  'Sustainable Tra Su: Sampan Through the Flooded Melaleuca Forest',
  'tour-ben-vung-tra-su-rung-tram-10100',
  'Trà Sư', 'south', 1, 0,
  650000, 75, 18, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1560275619-4662e36fa65c?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1560275619-4662e36fa65c?w=800&q=80'],
  ARRAY[
    'Rừng tràm Trà Sư mặt nước phủ bèo xanh mướt',
    'Chèo xuồng ba lá len giữa rừng tràm ngập nước',
    'Sân chim với cò, vạc và nhiều loài chim nước',
    'Tháp quan sát ngắm toàn cảnh rừng tràm',
    'Đặc sản mùa nước nổi và mật ong rừng tràm'
  ],
  ARRAY[
    'Tra Su melaleuca forest with a carpet of green duckweed',
    'Paddle a sampan through the flooded melaleuca forest',
    'A bird sanctuary with storks, herons and water birds',
    'An observation tower with a view over the whole forest',
    'Floodwater-season specialties and melaleuca honey'
  ],
  '[{"day":1,"title":"Trà Sư – rừng tràm và sân chim","activities":["07:30 Đón khách khu vực Châu Đốc hoặc Long Xuyên","08:45 Tới rừng tràm Trà Sư, nghe giới thiệu hệ sinh thái ngập nước","09:15 Lên tắc ráng chạy vào lõi rừng tràm","09:45 Chuyển sang xuồng ba lá, cô lái chèo len giữa rừng","10:30 Ngắm sân chim, cò vạc bay rợp trời","11:15 Lên tháp quan sát ngắm toàn cảnh rừng tràm","12:00 Ăn trưa đặc sản mùa nước nổi, thử mật ong rừng tràm","13:30 Ghé làng Chăm Châu Giang, xem dệt thổ cẩm","15:00 Xe đưa về, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Tra Su – melaleuca forest and bird sanctuary","activities":["07:30 Pickup in Chau Doc or Long Xuyen","08:45 Reach Tra Su forest, a briefing on the wetland ecosystem","09:15 Board a motorboat into the heart of the melaleuca forest","09:45 Switch to a sampan, a local paddles you through the trees","10:30 View the bird sanctuary with storks and herons overhead","11:15 Climb the observation tower for a view over the forest","12:00 Floodwater-season lunch and a taste of melaleuca honey","13:30 Visit the Cham village of Chau Giang and its weaving","15:00 Transfer back, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"boat":"Tắc ráng + xuồng ba lá trong rừng tràm","entrance_fees":"Vé rừng tràm Trà Sư","meals":"Ăn trưa đặc sản mùa nước nổi"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"boat":"Motorboat and sampan in the forest","entrance_fees":"Tra Su forest ticket","meals":"Floodwater-season lunch"}'::jsonb,
  'Rừng tràm Trà Sư ở An Giang là khu rừng ngập nước tiêu biểu của miền Tây, nơi mặt nước phủ kín bèo xanh mướt và hàng nghìn con cò, vạc làm tổ. Tour trong ngày đưa bạn lên tắc ráng vào lõi rừng, rồi chuyển sang xuồng ba lá do người địa phương chèo len lỏi giữa những hàng tràm, ngắm sân chim và leo tháp quan sát. Trưa thưởng đặc sản mùa nước nổi và mật ong rừng tràm. Một điểm sinh thái ngập nước đẹp và cần được gìn giữ.',
  'Tra Su melaleuca forest in An Giang is a signature wetland of the Mekong Delta, where the water is carpeted with green duckweed and thousands of storks and herons nest. This day tour takes you by motorboat into the heart of the forest, then onto a sampan paddled by a local through the melaleuca trees, past the bird sanctuary and up an observation tower. Lunch brings floodwater-season specialties and melaleuca honey. A beautiful wetland worth protecting.',
  'Day tour of the Tra Su flooded melaleuca forest with a sampan ride, a bird sanctuary and an observation tower.',
  'Tour bền vững rừng tràm Trà Sư 1 ngày: chèo xuồng ba lá rừng tràm ngập nước, sân chim cò vạc, tháp quan sát, đặc sản mùa nước nổi. An Giang.',
  '["Đồ uống ngoài chương trình","Chi tiêu cá nhân","Tip cho HDV và người chèo xuồng"]'::jsonb,
  '["Drinks outside the program","Personal expenses","Tips for guide and the sampan paddler"]'::jsonb,
  'Đón tại khách sạn khu vực Châu Đốc hoặc Long Xuyên (An Giang)', '07:30',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["trà sư","rừng tràm","sân chim","mùa nước nổi","bền vững"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'tour-ben-vung-tra-su-rung-tram-10100');

-- ─────────────────────────────────────────────────────────────
-- Lịch khởi hành cho 6 tour TRONG NGÀY (duration_days=1): auto-schedule
-- ─────────────────────────────────────────────────────────────
select public.extend_day_tour_schedules();

-- ─────────────────────────────────────────────────────────────
-- Lịch khởi hành TAY cho 4 tour NHIỀU NGÀY (extend_day_tour_schedules
-- chỉ phủ tour 1 ngày). Khởi hành mỗi 3 ngày trong 60 ngày tới, đủ chỗ.
-- return_date = depart_date + (duration_days - 1). Idempotent theo (tour_id, depart_date).
-- ─────────────────────────────────────────────────────────────
insert into public.tour_schedules (tour_id, depart_date, return_date, total_slots, available_slots, status)
select t.id,
       d::date,
       (d::date + (t.duration_days - 1)),
       t.max_pax,
       t.max_pax,
       'OPEN'
from public.tours t
cross join generate_series(current_date + 2, current_date + 60, interval '3 days') as d
where t.slug in (
  'tour-ben-vung-pu-luong-trek-homestay-10091',
  'tour-ben-vung-mai-chau-homestay-dap-xe-10092',
  'tour-ben-vung-ha-giang-cao-nguyen-da-10093',
  'tour-ben-vung-mekong-can-tho-cho-noi-10099'
)
and not exists (
  select 1 from public.tour_schedules s
  where s.tour_id = t.id and s.depart_date = d::date
);

-- ─────────────────────────────────────────────────────────────
-- Kiểm tra: 10 tour bền vững ACTIVE, số lịch mỗi tour
-- ─────────────────────────────────────────────────────────────
select t.slug, t.destination, t.duration_days, t.base_price, count(s.id) as so_lich, min(s.depart_date) as ngay_dau
from public.tours t
left join public.tour_schedules s on s.tour_id = t.id and s.depart_date > current_date
where t.slug ~ '-1009[1-9]$' or t.slug ~ '-10100$'
group by t.slug, t.destination, t.duration_days, t.base_price
order by t.slug;
