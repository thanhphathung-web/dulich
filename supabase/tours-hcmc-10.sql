-- ═══════════════════════════════════════════════════════════════
-- 10 TOUR TP. HỒ CHÍ MINH cho khách nước ngoài — slug 10021 → 10030
-- Chạy trong Supabase → SQL Editor. Idempotent: mỗi INSERT có
-- WHERE NOT EXISTS theo slug — chạy lặp không tạo trùng.
-- Giá base_price là ƯỚC TÍNH theo mặt bằng thị trường 2026,
-- chủ web đã xác nhận sẽ tự điều chỉnh trong CMS nếu cần.
-- Ảnh: Unsplash placeholder (đã kiểm tra 200 OK) — thay ảnh thật sau.
-- Kiểu cột: highlights_vi/en, images = text[];
--           itinerary/includes/notes/tags/excludes_en = jsonb.
-- ═══════════════════════════════════════════════════════════════

-- Kiểm tra trước: các slug sắp thêm đã tồn tại chưa (mong đợi 0 dòng)
select slug, status from public.tours where slug ~ '-102[1-9]$|-10030$' or slug ~ '-1002[1-9]$';

-- ─────────────────────────────────────────────────────────────
-- 1. Địa đạo Củ Chi — nửa ngày
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
  'Sài Gòn – Địa Đạo Củ Chi Nửa Ngày',
  'Cu Chi Tunnels Half-Day Tour from Ho Chi Minh City',
  'cu-chi-nua-ngay-10021',
  'TP. Hồ Chí Minh', 'south', 1, 0,
  750000, 75, 24, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1540611025311-01df3cef54b5?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1540611025311-01df3cef54b5?w=800&q=80'],
  ARRAY[
    'Chui thử đoạn địa đạo nguyên bản dài 30–120m dưới lòng đất',
    'Khám phá hệ thống hầm hố, bếp Hoàng Cầm và bẫy quân sự tinh vi',
    'Thưởng thức khoai mì chấm muối vừng + trà nóng như thời chiến',
    'Trường bắn súng thể thao (tự chọn, trả phí theo viên đạn)',
    'HDV song ngữ kể chuyện lịch sử sống động suốt hành trình'
  ],
  ARRAY[
    'Crawl through an original 30-120m section of underground tunnels',
    'Discover hidden trapdoors, Hoang Cam smokeless kitchens and booby traps',
    'Taste wartime cassava with sesame salt and hot tea',
    'Optional shooting range with historic rifles (pay per bullet)',
    'Bilingual guide brings the history to life throughout the trip'
  ],
  '[{"day":1,"title":"TP.HCM – Địa đạo Củ Chi – TP.HCM","activities":["07:30 Xe và HDV đón khách tại khách sạn khu Quận 1","09:00 Đến khu di tích địa đạo Củ Chi (Bến Đình)","Xem phim tư liệu giới thiệu lịch sử vùng đất thép","Tham quan hầm chỉ huy, bếp Hoàng Cầm, hố đinh và các loại bẫy","Chui thử đoạn địa đạo 30–120m (tùy sức, có lối thoát giữa chừng)","Nghỉ giải lao với khoai mì chấm muối vừng và trà nóng","Tự chọn: bắn súng thể thao tại trường bắn (chi phí tự túc)","12:00 Lên xe về lại trung tâm TP.HCM","13:30 Về đến Quận 1, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Ho Chi Minh City – Cu Chi Tunnels – Ho Chi Minh City","activities":["07:30 Pick up at your hotel in District 1","09:00 Arrive at Cu Chi Tunnels historical site (Ben Dinh)","Watch a short documentary about the Iron Land history","Visit command bunkers, Hoang Cam kitchen, spike pits and booby traps","Crawl through a 30-120m tunnel section (exits available midway)","Break with steamed cassava, sesame salt and hot tea","Optional: sport shooting range (own expense, pay per bullet)","12:00 Depart for Ho Chi Minh City","13:30 Drop off in District 1, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"meals":"Ăn nhẹ khoai mì, trà nóng"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"meals":"Cassava snack and hot tea"}'::jsonb,
  'Địa đạo Củ Chi là điểm đến được khách quốc tế đặt nhiều nhất khi tới TP.HCM. Trong nửa ngày, bạn sẽ khám phá "thành phố trong lòng đất" với hơn 250km đường hầm, tự tay chui thử một đoạn địa đạo nguyên bản và nghe HDV kể lại những câu chuyện lịch sử có thật của vùng đất thép Củ Chi.',
  'The Cu Chi Tunnels are the most-booked attraction for international visitors to Ho Chi Minh City. In half a day you will explore an underground city of over 250km of tunnels, crawl through an original section yourself, and hear true wartime stories of the legendary Iron Land told by your bilingual guide.',
  'Half-day trip to the legendary Cu Chi Tunnels with hotel pickup, entrance fees and a bilingual guide.',
  'Tour địa đạo Củ Chi nửa ngày từ TP.HCM: chui hầm nguyên bản, bếp Hoàng Cầm, bẫy quân sự, khoai mì thời chiến. Đón tận khách sạn Quận 1, HDV song ngữ.',
  '["Đạn bắn súng thể thao (tính theo viên)","Đồ uống cá nhân ngoài chương trình","Tip cho HDV và tài xế","Chi phí cá nhân khác"]'::jsonb,
  '["Shooting range bullets (pay per bullet)","Personal drinks outside the program","Tips for guide and driver","Other personal expenses"]'::jsonb,
  'Đón tại khách sạn khu Quận 1, TP.HCM', '07:30',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["củ chi","lịch sử","nửa ngày","khách nước ngoài"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'cu-chi-nua-ngay-10021');

-- ─────────────────────────────────────────────────────────────
-- 2. Mekong Mỹ Tho – Bến Tre — 1 ngày
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
  'Sài Gòn – Mekong Mỹ Tho & Bến Tre 1 Ngày',
  'Mekong Delta My Tho - Ben Tre Full-Day Tour',
  'mekong-my-tho-ben-tre-10022',
  'TP. Hồ Chí Minh', 'south', 1, 0,
  950000, 75, 24, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1512058564366-18510be2db19?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1512058564366-18510be2db19?w=800&q=80','https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=800&q=80'],
  ARRAY[
    'Xuồng ba lá chèo tay len lỏi rạch dừa nước — khoảnh khắc "must-have" của miền Tây',
    'Nghe đờn ca tài tử Nam Bộ bên vườn trái cây, nếm trái cây theo mùa',
    'Thăm lò kẹo dừa Bến Tre, xem làm kẹo thủ công và thử tại chỗ',
    'Trà mật ong hoa nhãn tại trại ong trên cồn Thới Sơn',
    'Đi xe ngựa lộc cộc qua đường làng rợp bóng dừa'
  ],
  ARRAY[
    'Hand-rowed sampan ride through nipa palm creeks — the iconic Mekong moment',
    'Southern folk music (don ca tai tu) with seasonal fruit tasting in an orchard',
    'Visit a Ben Tre coconut candy workshop and taste it fresh',
    'Honey tea at a bee farm on Thoi Son islet',
    'Horse-drawn cart ride along shady coconut village lanes'
  ],
  '[{"day":1,"title":"TP.HCM – Mỹ Tho – Bến Tre – TP.HCM","activities":["07:30 Xe đón khách tại khách sạn khu Quận 1, khởi hành đi Mỹ Tho","09:30 Đến bến tàu Mỹ Tho, xuống thuyền lớn ngắm 4 cồn Long - Lân - Quy - Phụng","Thăm trại ong trên cồn Thới Sơn, thưởng thức trà mật ong hoa nhãn","Nghe đờn ca tài tử và nếm trái cây theo mùa trong vườn","Đi xe ngựa qua đường làng rợp bóng dừa","Xuồng ba lá chèo tay len lỏi rạch dừa nước","12:30 Ăn trưa đặc sản: cá tai tượng chiên xù cuốn bánh tráng","Qua Bến Tre thăm lò kẹo dừa thủ công, thử kẹo mới ra lò","15:00 Lên xe về TP.HCM","17:00 Về đến Quận 1, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Ho Chi Minh City – My Tho – Ben Tre – Ho Chi Minh City","activities":["07:30 Hotel pickup in District 1, depart for My Tho","09:30 Board a motorboat to cruise past the four islets Dragon, Unicorn, Tortoise and Phoenix","Visit a bee farm on Thoi Son islet and enjoy longan honey tea","Listen to southern folk music while tasting seasonal fruits in the orchard","Ride a horse-drawn cart along coconut-shaded village lanes","Hand-rowed sampan ride through narrow nipa palm creeks","12:30 Local lunch: crispy elephant-ear fish with rice paper rolls","Cross to Ben Tre to visit a traditional coconut candy workshop","15:00 Drive back to Ho Chi Minh City","17:00 Drop off in District 1, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"boat":"Thuyền lớn + xuồng chèo tay","meals":"Ăn trưa cá tai tượng chiên xù"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"boat":"Motorboat and rowing sampan","meals":"Lunch with elephant-ear fish"}'::jsonb,
  'Một ngày trọn vẹn sông nước miền Tây ngay sát TP.HCM: đi thuyền trên sông Tiền, chèo xuồng ba lá trong rạch dừa nước, nghe đờn ca tài tử, thăm lò kẹo dừa Bến Tre và ăn trưa với cá tai tượng chiên xù trứ danh. Tour bán chạy nhất cho khách quốc tế muốn cảm nhận đồng bằng sông Cửu Long trong một ngày.',
  'A full day on the Mekong just outside Ho Chi Minh City: cruise the Tien River, glide through nipa palm creeks on a rowing sampan, enjoy southern folk music, visit a Ben Tre coconut candy workshop and lunch on the famous crispy elephant-ear fish. The best-selling day trip for travelers who want the Mekong Delta in one day.',
  'Full-day Mekong Delta trip to My Tho and Ben Tre with sampan ride, folk music, coconut candy workshop and local lunch.',
  'Tour Mekong 1 ngày từ TP.HCM: xuồng ba lá rạch dừa nước, đờn ca tài tử, lò kẹo dừa Bến Tre, ăn trưa cá tai tượng. Đón khách sạn Quận 1.',
  '["Đồ uống ngoài chương trình","Tip cho HDV, tài xế và người chèo xuồng","Chi phí cá nhân khác"]'::jsonb,
  '["Drinks outside the program","Tips for guide, driver and rowers","Other personal expenses"]'::jsonb,
  'Đón tại khách sạn khu Quận 1, TP.HCM', '07:30',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["mekong","miền tây","1 ngày","sông nước"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'mekong-my-tho-ben-tre-10022');

-- ─────────────────────────────────────────────────────────────
-- 3. Combo Củ Chi + Mekong — 1 ngày
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
  'Sài Gòn – Combo Củ Chi & Mekong Trong 1 Ngày',
  'Cu Chi Tunnels and Mekong Delta Combo Full-Day Tour',
  'cu-chi-mekong-combo-10023',
  'TP. Hồ Chí Minh', 'south', 1, 0,
  1350000, 75, 20, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1528127269322-539801943592?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1528127269322-539801943592?w=800&q=80'],
  ARRAY[
    'Gộp 2 điểm nổi tiếng nhất quanh TP.HCM trong đúng 1 ngày',
    'Sáng chui địa đạo Củ Chi, chiều chèo xuồng rạch dừa nước Mỹ Tho',
    'Lý tưởng cho khách lịch trình ngắn, chỉ có 1 ngày trống ở Sài Gòn',
    'Ăn trưa đặc sản miền Tây trên đường di chuyển',
    'Nhóm nhỏ tối đa 20 khách, HDV song ngữ suốt tuyến'
  ],
  ARRAY[
    'The two most famous sights around Ho Chi Minh City in one single day',
    'Cu Chi Tunnels in the morning, Mekong sampan ride in the afternoon',
    'Ideal for travelers with only one free day in Saigon',
    'Mekong specialty lunch on route',
    'Small group of max 20 with a bilingual guide throughout'
  ],
  '[{"day":1,"title":"TP.HCM – Củ Chi – Mỹ Tho – TP.HCM","activities":["07:00 Xe đón khách tại khách sạn khu Quận 1, đi Củ Chi","08:30 Tham quan địa đạo Củ Chi: hầm chỉ huy, bẫy quân sự, chui thử địa đạo","10:30 Khởi hành đi Mỹ Tho, nghỉ ngơi trên xe","12:00 Ăn trưa đặc sản miền Tây tại nhà hàng địa phương","13:00 Xuống thuyền tham quan sông Tiền và cồn Thới Sơn","Xuồng ba lá chèo tay trong rạch dừa nước, trà mật ong, trái cây theo mùa","Nghe đờn ca tài tử Nam Bộ trong vườn","16:00 Lên xe về TP.HCM","18:00 Về đến Quận 1, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Ho Chi Minh City – Cu Chi – My Tho – Ho Chi Minh City","activities":["07:00 Hotel pickup in District 1, depart for Cu Chi","08:30 Explore the Cu Chi Tunnels: command bunkers, booby traps, tunnel crawl","10:30 Drive to My Tho, rest on the coach","12:00 Mekong specialty lunch at a local restaurant","13:00 Board a boat on the Tien River to Thoi Son islet","Rowing sampan through nipa palm creeks, honey tea and seasonal fruits","Southern folk music performance in the orchard","16:00 Drive back to Ho Chi Minh City","18:00 Drop off in District 1, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"boat":"Thuyền lớn + xuồng chèo tay","meals":"Ăn trưa đặc sản miền Tây"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"boat":"Motorboat and rowing sampan","meals":"Mekong specialty lunch"}'::jsonb,
  'Chỉ có một ngày ở Sài Gòn? Tour combo này gói trọn hai trải nghiệm được khách quốc tế yêu thích nhất: buổi sáng khám phá địa đạo Củ Chi huyền thoại, buổi chiều xuôi sông Tiền chèo xuồng ba lá giữa rạch dừa nước Mỹ Tho. Một ngày — hai thế giới hoàn toàn khác biệt.',
  'Only one day in Saigon? This combo packs the two most-loved experiences into a single trip: explore the legendary Cu Chi Tunnels in the morning, then drift down the Tien River on a rowing sampan through My Tho nipa palm creeks in the afternoon. One day, two completely different worlds.',
  'Combo day tour covering Cu Chi Tunnels in the morning and a Mekong Delta boat trip in the afternoon.',
  'Combo 1 ngày từ TP.HCM: sáng địa đạo Củ Chi, chiều Mekong Mỹ Tho chèo xuồng ba lá. Trọn gói xe đón, vé, ăn trưa, HDV song ngữ.',
  '["Đạn bắn súng thể thao tại Củ Chi","Đồ uống ngoài chương trình","Tip cho HDV, tài xế và người chèo xuồng","Chi phí cá nhân khác"]'::jsonb,
  '["Shooting range bullets at Cu Chi","Drinks outside the program","Tips for guide, driver and rowers","Other personal expenses"]'::jsonb,
  'Đón tại khách sạn khu Quận 1, TP.HCM', '07:00',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["củ chi","mekong","combo","1 ngày"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'cu-chi-mekong-combo-10023');

-- ─────────────────────────────────────────────────────────────
-- 4. Food tour xe máy đêm — tối
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
  'Sài Gòn – Food Tour Xe Máy Về Đêm',
  'Saigon After Dark: Street Food Tour by Motorbike',
  'sai-gon-food-tour-xe-may-dem-10024',
  'TP. Hồ Chí Minh', 'south', 1, 0,
  1150000, 75, 12, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1526481280693-3bfa7568e0f3?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1526481280693-3bfa7568e0f3?w=800&q=80','https://images.unsplash.com/photo-1555921015-5532091f6026?w=800&q=80'],
  ARRAY[
    'Ngồi sau xe máy cùng rider bản địa — trải nghiệm Sài Gòn đúng chất nhất',
    'Hơn 5 món đường phố: bánh xèo, ốc Quận 4, bò lá lốt, bánh mì, chè',
    'Len lỏi những con hẻm và khu ăn đêm chỉ dân địa phương biết',
    'Ngắm skyline Sài Gòn về đêm từ bờ kênh Nhiêu Lộc',
    'Nhóm nhỏ tối đa 12 khách, mỗi khách một xe một rider'
  ],
  ARRAY[
    'Ride pillion with a local driver — the most authentic way to feel Saigon',
    'Over 5 street food dishes: banh xeo, District 4 snails, beef in betel leaf, banh mi, che dessert',
    'Weave through alleys and late-night food spots only locals know',
    'Night skyline views from the Nhieu Loc canal banks',
    'Small group of max 12, one bike and one driver per guest'
  ],
  '[{"day":1,"title":"Sài Gòn về đêm trên yên xe máy","activities":["18:00 Rider đón khách tại khách sạn khu Quận 1 bằng xe máy","Điểm 1: bánh xèo miền Tây chảo khổng lồ ở quán gia truyền","Điểm 2: phố ốc Vĩnh Khánh Quận 4 — ốc len xào dừa, sò điệp nướng mỡ hành","Chạy dọc kênh Nhiêu Lộc ngắm thành phố lên đèn","Điểm 3: bò lá lốt nướng than hoa Bàn Cờ","Điểm 4: bánh mì và cà phê sữa đá kiểu Sài Gòn","Điểm 5: chè ba màu khu Chợ Lớn tráng miệng","21:30 Rider đưa khách về lại khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Saigon after dark on the back of a motorbike","activities":["18:00 Your rider picks you up by motorbike at your District 1 hotel","Stop 1: giant crispy banh xeo pancake at a family-run eatery","Stop 2: Vinh Khanh snail street in District 4 — coconut snails and grilled scallops","Cruise along Nhieu Loc canal as the city lights come on","Stop 3: charcoal-grilled beef in betel leaf in Ban Co quarter","Stop 4: banh mi and classic Saigon iced milk coffee","Stop 5: three-color che dessert in Cho Lon (Chinatown)","21:30 Ride back to your hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":"Xe máy + nón bảo hiểm, mỗi khách một rider","insurance":true,"meals":"Toàn bộ món ăn và 1 đồ uống mỗi điểm"}'::jsonb,
  '{"guide":true,"transfer":"Motorbike with helmet, one driver per guest","insurance":true,"meals":"All food stops plus one drink per stop"}'::jsonb,
  'Sài Gòn sống về đêm — và cách ngon nhất để cảm nhận là trên yên xe máy. Rider bản địa chở bạn len lỏi qua các con hẻm, dừng ở hơn 5 quán đường phố trứ danh từ phố ốc Quận 4 đến chè Chợ Lớn. Tour ẩm thực được khách quốc tế chấm điểm cao nhất Sài Gòn.',
  'Saigon comes alive at night, and the best way to taste it is from the back of a motorbike. Local riders sweep you through hidden alleys and more than five legendary street food stops, from District 4 snail street to a Chinatown dessert parlor. Consistently the top-rated food experience in the city.',
  'Evening street food adventure by motorbike with local riders, five-plus tasting stops and hotel pickup.',
  'Food tour xe máy đêm Sài Gòn: bánh xèo, ốc Quận 4, bò lá lốt, bánh mì, chè Chợ Lớn. Mỗi khách một rider, đón tận khách sạn.',
  '["Đồ uống có cồn ngoài chương trình","Tip cho rider","Chi phí cá nhân khác"]'::jsonb,
  '["Alcoholic drinks beyond the program","Tips for riders","Other personal expenses"]'::jsonb,
  'Đón tại khách sạn khu Quận 1, TP.HCM', '18:00',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["food tour","xe máy","về đêm","ẩm thực đường phố"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'sai-gon-food-tour-xe-may-dem-10024');

-- ─────────────────────────────────────────────────────────────
-- 5. City tour trọn ngày
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
  'Sài Gòn – City Tour Trọn Ngày Di Sản & Chợ Lớn',
  'Ho Chi Minh City Full-Day Heritage and Chinatown Tour',
  'sai-gon-city-tour-10025',
  'TP. Hồ Chí Minh', 'south', 1, 0,
  950000, 75, 16, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1583468982228-19f19164aee2?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1583468982228-19f19164aee2?w=800&q=80'],
  ARRAY[
    'Dinh Độc Lập — nơi kết thúc chiến tranh Việt Nam ngày 30/4/1975',
    'Bảo tàng Chứng tích Chiến tranh — bảo tàng được khách quốc tế ghé nhiều nhất Việt Nam',
    'Nhà thờ Đức Bà và Bưu điện Thành phố hơn 130 năm tuổi',
    'Chùa Thiên Hậu và khu Chợ Lớn — phố người Hoa lớn nhất Việt Nam',
    'Ăn trưa món Việt kinh điển: phở hoặc cơm tấm sườn'
  ],
  ARRAY[
    'Independence Palace — where the Vietnam War ended on April 30, 1975',
    'War Remnants Museum — the most visited museum in Vietnam',
    'Notre-Dame Cathedral and the 130-year-old Central Post Office',
    'Thien Hau Temple and Cho Lon — the largest Chinatown in Vietnam',
    'Classic Vietnamese lunch: pho or broken rice with grilled pork'
  ],
  '[{"day":1,"title":"Di sản Sài Gòn và Chợ Lớn trong một ngày","activities":["08:00 Đón khách tại khách sạn khu Quận 1","Tham quan Dinh Độc Lập — phòng nội các, hầm chỉ huy, sân thượng trực thăng","Bảo tàng Chứng tích Chiến tranh — máy bay, xe tăng và các phòng trưng bày","Nhà thờ Đức Bà (chụp ảnh bên ngoài) và Bưu điện Thành phố kiến trúc Pháp","12:00 Ăn trưa phở hoặc cơm tấm tại quán địa phương nổi tiếng","13:30 Khu Chợ Lớn: chùa Thiên Hậu nghi ngút vòng nhang, phố thuốc bắc","Chợ Bình Tây — chợ đầu mối sầm uất của người Hoa","Ghé chợ Bến Thành mua sắm quà lưu niệm","17:00 Về lại khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Saigon heritage and Chinatown in one day","activities":["08:00 Hotel pickup in District 1","Independence Palace — cabinet rooms, command bunker and rooftop helipad","War Remnants Museum — aircraft, tanks and exhibition halls","Notre-Dame Cathedral (photo stop) and the French-built Central Post Office","12:00 Lunch of pho or com tam at a famous local eatery","13:30 Cho Lon (Chinatown): incense-filled Thien Hau Temple and herbal medicine street","Binh Tay Market — the bustling Chinese wholesale market","Stop at Ben Thanh Market for souvenirs","17:00 Return to your hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"meals":"Ăn trưa phở hoặc cơm tấm"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"meals":"Lunch of pho or com tam"}'::jsonb,
  'Một ngày đi hết những biểu tượng của Sài Gòn: từ Dinh Độc Lập và Bảo tàng Chứng tích Chiến tranh gắn với lịch sử hiện đại, qua Nhà thờ Đức Bà và Bưu điện kiến trúc Pháp, đến chùa Thiên Hậu trầm mặc giữa Chợ Lớn. HDV song ngữ kể chuyện từng địa danh, ăn trưa món Việt kinh điển.',
  'One day through all of Saigon icons: from Independence Palace and the War Remnants Museum that shaped modern history, past the French colonial Notre-Dame Cathedral and Central Post Office, to the incense-filled Thien Hau Temple in the heart of Chinatown. A bilingual guide brings each landmark to life, with a classic Vietnamese lunch included.',
  'Full-day city tour covering Independence Palace, War Remnants Museum, colonial landmarks and Chinatown with lunch.',
  'City tour Sài Gòn trọn ngày: Dinh Độc Lập, Bảo tàng Chứng tích Chiến tranh, Nhà thờ Đức Bà, Bưu điện, Chợ Lớn. Kèm ăn trưa, vé tham quan, HDV song ngữ.',
  '["Đồ uống ngoài chương trình","Tip cho HDV và tài xế","Chi phí mua sắm cá nhân"]'::jsonb,
  '["Drinks outside the program","Tips for guide and driver","Personal shopping expenses"]'::jsonb,
  'Đón tại khách sạn khu Quận 1, TP.HCM', '08:00',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["city tour","lịch sử","chợ lớn","1 ngày"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'sai-gon-city-tour-10025');

-- ─────────────────────────────────────────────────────────────
-- 6. Cooking class + chợ Bến Thành
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
  'Sài Gòn – Lớp Nấu Ăn Việt & Đi Chợ Bến Thành',
  'Vietnamese Cooking Class with Ben Thanh Market Tour',
  'cooking-class-cho-ben-thanh-10026',
  'TP. Hồ Chí Minh', 'south', 1, 0,
  1250000, 75, 10, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1556910103-1c02745aae4d?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1556910103-1c02745aae4d?w=800&q=80','https://images.unsplash.com/photo-1466637574441-749b8f19452f?w=800&q=80'],
  ARRAY[
    'Đi chợ Bến Thành chọn nguyên liệu tươi cùng đầu bếp',
    'Tự tay nấu 3 món Việt kinh điển: gỏi cuốn, bánh xèo, phở bò',
    'Học pha nước mắm chấm chuẩn vị — bí quyết của mọi món Việt',
    'Thưởng thức thành quả ngay tại lớp, kèm cà phê trứng tráng miệng',
    'Nhận bộ công thức tiếng Anh và giấy chứng nhận mang về'
  ],
  ARRAY[
    'Shop for fresh ingredients at Ben Thanh Market with your chef',
    'Cook 3 Vietnamese classics yourself: fresh spring rolls, banh xeo, beef pho',
    'Master the balanced fish sauce dip — the secret of all Vietnamese food',
    'Enjoy your dishes at the class, finished with egg coffee dessert',
    'Take home an English recipe booklet and a completion certificate'
  ],
  '[{"day":1,"title":"Từ sạp chợ Bến Thành đến bàn ăn","activities":["08:30 Gặp đầu bếp tại cổng chợ Bến Thành","Dạo chợ 45 phút: chọn rau thơm, tôm tươi, thịt bò, học cách phân biệt nguyên liệu","09:30 Về lớp học nấu ăn cách chợ 5 phút đi bộ","Bài 1: cuốn gỏi cuốn tôm thịt và pha nước mắm chấm","Bài 2: đổ bánh xèo giòn rụm trên chảo gang","Bài 3: nấu nước dùng và hoàn thiện tô phở bò","12:00 Cùng thưởng thức thành quả, tráng miệng cà phê trứng","13:00 Nhận công thức và chứng nhận, kết thúc chương trình"]}]'::jsonb,
  '[{"day":1,"title":"From Ben Thanh Market stalls to your table","activities":["08:30 Meet your chef at the Ben Thanh Market gate","45-minute market walk: pick herbs, fresh shrimp and beef, learn to tell ingredients apart","09:30 Walk 5 minutes to the cooking studio","Lesson 1: roll fresh spring rolls and mix the classic fish sauce dip","Lesson 2: fry a crispy banh xeo pancake on a cast-iron pan","Lesson 3: prepare the broth and assemble a bowl of beef pho","12:00 Enjoy your own dishes, with egg coffee for dessert","13:00 Receive your recipe booklet and certificate, program ends"]}]'::jsonb,
  '{"guide":true,"insurance":true,"activities":"Lớp nấu 3 món + đi chợ cùng đầu bếp","meals":"Thưởng thức toàn bộ món tự nấu + cà phê trứng"}'::jsonb,
  '{"guide":true,"insurance":true,"activities":"3-dish cooking class plus market tour with the chef","meals":"All dishes you cook plus egg coffee"}'::jsonb,
  'Học nấu món Việt bắt đầu từ nơi ngon nhất: sạp chợ Bến Thành. Đầu bếp song ngữ dẫn bạn chọn nguyên liệu tươi, rồi về lớp tự tay làm gỏi cuốn, bánh xèo và phở bò — ba món khách quốc tế mê nhất. Kết thúc bằng bữa trưa do chính bạn nấu và bộ công thức mang về nhà.',
  'Learn Vietnamese cooking where it starts: the stalls of Ben Thanh Market. A bilingual chef helps you pick fresh ingredients, then guides you through making fresh spring rolls, banh xeo and beef pho — the three dishes foreign guests love most. Finish with a lunch you cooked yourself and recipes to take home.',
  'Hands-on Vietnamese cooking class with a Ben Thanh Market shopping tour, three classic dishes and recipes to keep.',
  'Lớp nấu ăn Việt tại Sài Gòn: đi chợ Bến Thành cùng đầu bếp, tự nấu gỏi cuốn, bánh xèo, phở bò. Nhóm nhỏ 10 khách, công thức tiếng Anh mang về.',
  '["Đưa đón khách sạn (điểm hẹn tại chợ Bến Thành)","Đồ uống ngoài chương trình","Tip cho đầu bếp"]'::jsonb,
  '["Hotel transfer (meeting point at Ben Thanh Market)","Drinks outside the program","Tips for the chef"]'::jsonb,
  'Cổng chính chợ Bến Thành (cổng Nam, đường Lê Lợi)', '08:30',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["cooking class","ẩm thực","chợ bến thành","trải nghiệm"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'cooking-class-cho-ben-thanh-10026');

-- ─────────────────────────────────────────────────────────────
-- 7. Tòa thánh Cao Đài Tây Ninh + Củ Chi — 1 ngày
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
  'Sài Gòn – Tòa Thánh Cao Đài Tây Ninh & Củ Chi 1 Ngày',
  'Cao Dai Temple Tay Ninh and Cu Chi Tunnels Full-Day Tour',
  'cao-dai-tay-ninh-cu-chi-10027',
  'TP. Hồ Chí Minh', 'south', 1, 0,
  1250000, 75, 20, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1552465011-b4e21bf6e79a?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1552465011-b4e21bf6e79a?w=800&q=80'],
  ARRAY[
    'Dự lễ Ngọ 12h trưa tại Tòa thánh Cao Đài — nghi lễ tôn giáo độc nhất thế giới',
    'Kiến trúc tòa thánh rực rỡ pha trộn Đông - Tây với Thiên Nhãn biểu tượng',
    'Ngắm núi Bà Đen — nóc nhà Nam Bộ — trên đường đi',
    'Chiều khám phá địa đạo Củ Chi huyền thoại',
    'Trọn ngày với HDV song ngữ am hiểu tôn giáo và lịch sử'
  ],
  ARRAY[
    'Witness the noon ceremony at the Cao Dai Holy See — a religious ritual found nowhere else on earth',
    'Dazzling temple architecture blending East and West under the Divine Eye',
    'Views of Ba Den Mountain, the roof of southern Vietnam, on route',
    'Explore the legendary Cu Chi Tunnels in the afternoon',
    'Full day with a bilingual guide versed in religion and history'
  ],
  '[{"day":1,"title":"TP.HCM – Tây Ninh – Củ Chi – TP.HCM","activities":["07:00 Xe đón khách tại khách sạn khu Quận 1, khởi hành đi Tây Ninh","09:30 Ngắm núi Bà Đen từ xa, nghe kể về vùng đất thánh Tây Ninh","10:30 Đến Tòa thánh Cao Đài, tìm hiểu về đạo Cao Đài và kiến trúc tòa thánh","12:00 Dự lễ Ngọ — quan sát nghi lễ từ hành lang dành cho khách tham quan","12:45 Ăn trưa nhà hàng địa phương","14:30 Đến địa đạo Củ Chi: xem phim tư liệu, tham quan hầm hào, chui thử địa đạo","16:30 Lên xe về TP.HCM","18:00 Về đến Quận 1, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Ho Chi Minh City – Tay Ninh – Cu Chi – Ho Chi Minh City","activities":["07:00 Hotel pickup in District 1, depart for Tay Ninh","09:30 Views of Ba Den Mountain with stories of the holy land of Tay Ninh","10:30 Arrive at the Cao Dai Holy See, learn about Caodaism and the temple architecture","12:00 Attend the noon ceremony from the visitor gallery","12:45 Lunch at a local restaurant","14:30 Cu Chi Tunnels: documentary film, bunkers and a tunnel crawl","16:30 Drive back to Ho Chi Minh City","18:00 Drop off in District 1, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"meals":"Ăn trưa nhà hàng địa phương"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"meals":"Lunch at a local restaurant"}'::jsonb,
  'Hành trình trọn ngày kết hợp hai điểm khách quốc tế tò mò nhất: Tòa thánh Cao Đài Tây Ninh rực rỡ sắc màu với lễ Ngọ 12h trưa — nghi lễ của tôn giáo sinh ra tại Việt Nam, và địa đạo Củ Chi huyền thoại trên đường về. Một ngày đầy ắp văn hóa, tín ngưỡng và lịch sử.',
  'A full-day journey combining the two sights foreign travelers are most curious about: the technicolor Cao Dai Holy See in Tay Ninh with its noon ceremony — the ritual of a religion born in Vietnam — and the legendary Cu Chi Tunnels on the way back. A day packed with culture, faith and history.',
  'Full-day trip to the Cao Dai Holy See noon ceremony in Tay Ninh combined with the Cu Chi Tunnels.',
  'Tour 1 ngày từ TP.HCM: dự lễ Ngọ Tòa thánh Cao Đài Tây Ninh, ngắm núi Bà Đen, chiều khám phá địa đạo Củ Chi. Trọn gói xe, vé, ăn trưa, HDV song ngữ.',
  '["Đạn bắn súng thể thao tại Củ Chi","Đồ uống ngoài chương trình","Tip cho HDV và tài xế","Chi phí cá nhân khác"]'::jsonb,
  '["Shooting range bullets at Cu Chi","Drinks outside the program","Tips for guide and driver","Other personal expenses"]'::jsonb,
  'Đón tại khách sạn khu Quận 1, TP.HCM', '07:00',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["cao đài","tây ninh","củ chi","văn hóa"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'cao-dai-tay-ninh-cu-chi-10027');

-- ─────────────────────────────────────────────────────────────
-- 8. Du thuyền ăn tối sông Sài Gòn
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
  'Sài Gòn – Du Thuyền Ăn Tối Trên Sông Sài Gòn',
  'Saigon River Dinner Cruise with Live Music',
  'du-thuyen-an-toi-song-sai-gon-10028',
  'TP. Hồ Chí Minh', 'south', 1, 0,
  950000, 75, 50, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1514565131-fce0801e5785?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1514565131-fce0801e5785?w=800&q=80'],
  ARRAY[
    'Ngắm skyline Sài Gòn lên đèn: Landmark 81, Bitexco, cầu Ba Son',
    'Set menu tối 5 món Á - Âu phục vụ tại bàn',
    'Nhạc sống và biểu diễn nghệ thuật trên boong tàu',
    'Du thuyền 2 tầng với boong ngoài trời thoáng gió',
    'Xuất phát từ bến Bạch Đằng ngay trung tâm Quận 1'
  ],
  ARRAY[
    'Watch the Saigon skyline light up: Landmark 81, Bitexco Tower, Ba Son Bridge',
    'Five-course Asian-Western set dinner served at your table',
    'Live music and art performances on deck',
    'Two-deck cruise ship with a breezy open-air upper deck',
    'Departs from Bach Dang Pier in the heart of District 1'
  ],
  '[{"day":1,"title":"Hoàng hôn và ánh đèn thành phố trên sông Sài Gòn","activities":["18:30 Có mặt tại bến Bạch Đằng, làm thủ tục lên du thuyền","19:00 Tàu rời bến, đón hoàng hôn trên sông Sài Gòn","Ngắm Landmark 81 và Bitexco rực sáng từ mặt sông","19:30 Phục vụ set menu tối 5 món tại bàn","Thưởng thức nhạc sống và chương trình biểu diễn nghệ thuật","Lên boong thượng ngắm cầu Ba Son và bến Nhà Rồng về đêm","21:30 Tàu cập bến Bạch Đằng, kết thúc chương trình"]}]'::jsonb,
  '[{"day":1,"title":"Sunset and city lights on the Saigon River","activities":["18:30 Check in at Bach Dang Pier and board the cruise","19:00 The ship departs as the sun sets over the Saigon River","Watch Landmark 81 and Bitexco Tower glow from the water","19:30 Five-course set dinner served at your table","Enjoy live music and art performances","Head to the upper deck for night views of Ba Son Bridge and Nha Rong Wharf","21:30 The ship returns to Bach Dang Pier, program ends"]}]'::jsonb,
  '{"boat":"Du thuyền 2 tầng trên sông Sài Gòn","meals":"Set menu tối 5 món","insurance":true,"activities":"Nhạc sống và biểu diễn nghệ thuật"}'::jsonb,
  '{"boat":"Two-deck cruise on the Saigon River","meals":"Five-course set dinner","insurance":true,"activities":"Live music and performances"}'::jsonb,
  'Buổi tối lãng mạn nhất Sài Gòn nằm trên mặt sông: du thuyền rời bến Bạch Đằng lúc hoàng hôn, thành phố lên đèn hai bên mạn tàu, bữa tối 5 món phục vụ tại bàn trong tiếng nhạc sống. Lựa chọn yêu thích của các cặp đôi và gia đình cho đêm đầu tiên ở Sài Gòn.',
  'The most romantic evening in Saigon happens on the water: the cruise leaves Bach Dang Pier at sunset, the city lights up on both sides, and a five-course dinner is served to live music. A favorite pick for couples and families on their first night in the city.',
  'Evening dinner cruise on the Saigon River with a five-course meal, live music and skyline views.',
  'Du thuyền ăn tối sông Sài Gòn: set menu 5 món, nhạc sống, ngắm Landmark 81 và Bitexco từ mặt sông. Xuất phát bến Bạch Đằng, Quận 1, 19h hàng ngày.',
  '["Đưa đón khách sạn (có thể đặt thêm)","Đồ uống ngoài set menu","Tip cho nhân viên phục vụ"]'::jsonb,
  '["Hotel transfer (available as an add-on)","Drinks beyond the set menu","Tips for the crew"]'::jsonb,
  'Bến Bạch Đằng, đường Tôn Đức Thắng, Quận 1', '18:30',
  'cruise', 'easy', 'vi_en', 'flexible', 'standard',
  '["du thuyền","ăn tối","sông sài gòn","lãng mạn"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'du-thuyen-an-toi-song-sai-gon-10028');

-- ─────────────────────────────────────────────────────────────
-- 9. Cần Giờ — rừng ngập mặn & đảo khỉ
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
  'Sài Gòn – Cần Giờ Rừng Ngập Mặn & Đảo Khỉ 1 Ngày',
  'Can Gio Mangrove Forest and Monkey Island Day Trip',
  'can-gio-rung-ngap-man-10029',
  'TP. Hồ Chí Minh', 'south', 1, 0,
  1350000, 75, 20, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?w=800&q=80'],
  ARRAY[
    'Khu dự trữ sinh quyển thế giới UNESCO cách trung tâm chỉ 50km',
    'Ca nô cao tốc xuyên rừng ngập mặn — "lá phổi xanh" của Sài Gòn',
    'Đảo Khỉ với hàng trăm chú khỉ tinh nghịch sống hoang dã',
    'Căn cứ Rừng Sác — di tích đặc công nước trong rừng đước',
    'Ăn trưa hải sản Cần Giờ tươi rói'
  ],
  ARRAY[
    'UNESCO Biosphere Reserve just 50km from downtown Saigon',
    'Speedboat ride deep into the mangrove forest, the green lungs of the city',
    'Monkey Island, home to hundreds of playful wild monkeys',
    'Rung Sac guerrilla base, a wartime relic hidden in the mangroves',
    'Fresh Can Gio seafood lunch'
  ],
  '[{"day":1,"title":"TP.HCM – Cần Giờ – TP.HCM","activities":["07:30 Xe đón khách tại khách sạn khu Quận 1, qua phà Bình Khánh","09:30 Đến khu du lịch rừng ngập mặn Vàm Sát - Đảo Khỉ","Gặp gỡ hàng trăm chú khỉ hoang dã (giữ chặt tư trang!)","Ca nô cao tốc luồn sâu vào rừng đước xanh mướt","Thăm căn cứ Rừng Sác — tái hiện cuộc sống đặc công nước","12:30 Ăn trưa hải sản tươi tại nhà hàng địa phương","14:00 Ghé chợ Hàng Dương xem hải sản Cần Giờ, dạo biển 30/4","15:30 Lên xe về TP.HCM","17:30 Về đến Quận 1, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Ho Chi Minh City – Can Gio – Ho Chi Minh City","activities":["07:30 Hotel pickup in District 1, cross the Binh Khanh ferry","09:30 Arrive at the Vam Sat mangrove reserve and Monkey Island","Meet hundreds of wild monkeys (hold on to your belongings!)","Speedboat ride deep into the emerald mangrove forest","Visit the Rung Sac base, a recreated wartime commando camp","12:30 Fresh seafood lunch at a local restaurant","14:00 Browse Hang Duong seafood market and stroll 30/4 beach","15:30 Drive back to Ho Chi Minh City","17:30 Drop off in District 1, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"boat":"Ca nô cao tốc xuyên rừng ngập mặn","meals":"Ăn trưa hải sản Cần Giờ"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"boat":"Speedboat through the mangroves","meals":"Can Gio seafood lunch"}'::jsonb,
  'Ít ai ngờ chỉ cách trung tâm Sài Gòn 50km có một khu dự trữ sinh quyển thế giới: rừng ngập mặn Cần Giờ. Ngồi ca nô cao tốc luồn giữa rừng đước, thăm đảo Khỉ tinh nghịch, khám phá căn cứ Rừng Sác của đặc công nước và kết thúc bằng bữa trưa hải sản tươi — một ngày thiên nhiên trọn vẹn ngay sát đô thị.',
  'Few travelers realize a UNESCO Biosphere Reserve lies just 50km from downtown Saigon: the Can Gio mangrove forest. Speed by boat between the mangrove roots, meet the mischievous residents of Monkey Island, explore the hidden Rung Sac guerrilla base and finish with a fresh seafood lunch — a full day of nature right next to the metropolis.',
  'Day trip to the Can Gio UNESCO mangrove reserve with speedboat ride, Monkey Island and seafood lunch.',
  'Tour Cần Giờ 1 ngày từ TP.HCM: ca nô xuyên rừng ngập mặn UNESCO, đảo Khỉ, căn cứ Rừng Sác, ăn trưa hải sản. Đón tận khách sạn Quận 1.',
  '["Đồ uống ngoài chương trình","Thức ăn cho khỉ (không khuyến khích)","Tip cho HDV và tài xế","Chi phí cá nhân khác"]'::jsonb,
  '["Drinks outside the program","Monkey food (not encouraged)","Tips for guide and driver","Other personal expenses"]'::jsonb,
  'Đón tại khách sạn khu Quận 1, TP.HCM', '07:30',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["cần giờ","thiên nhiên","đảo khỉ","rừng ngập mặn"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'can-gio-rung-ngap-man-10029');

-- ─────────────────────────────────────────────────────────────
-- 10. Vespa tour Sài Gòn về đêm
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
  'Sài Gòn – Vespa Cổ Khám Phá Đêm Sài Gòn',
  'Saigon by Night on a Vintage Vespa',
  'vespa-sai-gon-dem-10030',
  'TP. Hồ Chí Minh', 'south', 1, 0,
  1650000, 75, 12, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1558981403-c5f9899a28bc?w=800&q=80','https://images.unsplash.com/photo-1565967511849-76a60a516170?w=800&q=80'],
  ARRAY[
    'Ngồi sau Vespa cổ phục chế — biểu tượng Sài Gòn thập niên 60',
    'Aperitif trên rooftop ngắm toàn cảnh thành phố lên đèn',
    'Ăn tối kiểu địa phương ở những quán chỉ dân sành mới biết',
    'Cà phê vợt Chợ Lớn — hàng cà phê giữ lửa hơn nửa thế kỷ',
    'Kết thúc tại quán nhạc sống acoustic ấm cúng'
  ],
  ARRAY[
    'Ride pillion on a restored vintage Vespa, the icon of 1960s Saigon',
    'Rooftop aperitif overlooking the city as the lights come on',
    'Local-style dinner at spots only insiders know',
    'Sock-brewed coffee in Cho Lon, kept over charcoal for half a century',
    'Wind down at a cozy acoustic live music venue'
  ],
  '[{"day":1,"title":"Sài Gòn về đêm trên yên Vespa cổ","activities":["18:30 Rider đón khách bằng Vespa cổ tại khách sạn khu Quận 1","Điểm 1: aperitif và món khai vị trên rooftop bar ngắm hoàng hôn","Điểm 2: bữa tối địa phương — lẩu cá kèo hoặc bò nướng lá lốt","Chạy qua phố Tây Bùi Viện và chợ Bến Thành về đêm","Điểm 3: cà phê vợt truyền thống trong hẻm Chợ Lớn","Điểm 4: quán nhạc sống acoustic — đồ uống kết thúc đêm","22:00 Rider đưa khách về khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Saigon after dark on a vintage Vespa","activities":["18:30 Your rider picks you up on a vintage Vespa at your District 1 hotel","Stop 1: rooftop aperitif and starters at sunset","Stop 2: local dinner of fish hotpot or grilled beef in betel leaf","Cruise past Bui Vien walking street and Ben Thanh Market at night","Stop 3: traditional sock-brewed coffee in a Cho Lon alley","Stop 4: cozy acoustic live music bar with a closing drink","22:00 Ride back to your hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":"Vespa cổ + rider riêng cho mỗi khách","insurance":true,"meals":"Bữa tối + đồ uống tại mỗi điểm dừng"}'::jsonb,
  '{"guide":true,"transfer":"Vintage Vespa with a private rider per guest","insurance":true,"meals":"Dinner plus a drink at every stop"}'::jsonb,
  'Trải nghiệm sang - chất - và rất Sài Gòn: vi vu trên yên Vespa cổ phục chế qua thành phố về đêm, mở màn bằng aperitif trên rooftop, ăn tối ở quán địa phương sành điệu, nhâm nhi cà phê vợt Chợ Lớn và khép lại bên ly cocktail trong tiếng nhạc acoustic. Tour cao cấp được yêu thích nhất cho buổi tối ở Sài Gòn.',
  'Stylish, spirited and unmistakably Saigon: cruise the city at night on a restored vintage Vespa, opening with a rooftop aperitif, dining where locals in the know eat, sipping sock-brewed coffee in a Cho Lon alley and closing the night with cocktails and acoustic music. The most-loved premium evening experience in the city.',
  'Premium evening Vespa tour with rooftop aperitif, local dinner, hidden coffee and live music.',
  'Vespa tour đêm Sài Gòn: Vespa cổ, aperitif rooftop, ăn tối địa phương, cà phê vợt Chợ Lớn, nhạc sống. Mỗi khách một rider, đón tận khách sạn.',
  '["Đồ uống có cồn ngoài chương trình","Tip cho rider","Chi phí cá nhân khác"]'::jsonb,
  '["Alcoholic drinks beyond the program","Tips for riders","Other personal expenses"]'::jsonb,
  'Đón tại khách sạn khu Quận 1, TP.HCM', '18:30',
  'day_tour', 'easy', 'vi_en', 'flexible', 'premium',
  '["vespa","về đêm","cao cấp","ẩm thực"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'vespa-sai-gon-dem-10030');

-- ─────────────────────────────────────────────────────────────
-- Kiểm tra sau khi chạy: phải trả về đúng 10 dòng ACTIVE
-- ─────────────────────────────────────────────────────────────
select slug, name_vi, base_price, status
from public.tours
where destination = 'TP. Hồ Chí Minh'
order by slug;
