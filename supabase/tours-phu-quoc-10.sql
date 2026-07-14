-- ═══════════════════════════════════════════════════════════════
-- 10 TOUR PHÚ QUỐC cho khách nước ngoài — slug 10061 → 10070
-- Chạy trong Supabase → SQL Editor. Idempotent: mỗi INSERT có
-- WHERE NOT EXISTS theo slug — chạy lặp không tạo trùng.
-- Giá base_price là ƯỚC TÍNH theo mặt bằng thị trường 2026 (cách làm
-- chủ web đã duyệt ở batch HCMC/Hà Nội/Đà Nẵng/Nha Trang). Ảnh Unsplash placeholder.
-- destination='Phú Quốc' (TP thuộc Kiên Giang) — filter tỉnh đã map sẵn
-- trong index.html (PROVINCE_CITIES['Kiên Giang']=['Phú Quốc']).
-- Cuối file: gọi extend_day_tour_schedules() để có lịch hàng ngày ngay.
-- ═══════════════════════════════════════════════════════════════

-- Kiểm tra trước: các slug sắp thêm đã tồn tại chưa (mong đợi 0 dòng)
select slug, status from public.tours where slug ~ '-1006[0-9]$' or slug ~ '-10070$';

-- ─────────────────────────────────────────────────────────────
-- 1. Cáp treo Hòn Thơm & tour 3 đảo Nam Phú Quốc
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
  'Phú Quốc – Cáp Treo Hòn Thơm & Tour 3 Đảo Nam Phú Quốc',
  'Hon Thom Cable Car and Three-Island Snorkeling Tour',
  'cap-treo-hon-thom-3-dao-10061',
  'Phú Quốc', 'south', 1, 0,
  750000, 75, 30, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=800&q=80','https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&q=80'],
  ARRAY[
    'Cáp treo vượt biển Hòn Thơm 7.899m — dài nhất thế giới',
    'Lặn ống thở ngắm san hô ở Hòn Móng Tay, Hòn Gầm Ghì',
    'Tắm biển làn nước xanh ngọc vùng Nam đảo',
    'Câu cá và thư giãn trên du thuyền',
    'Ngắm toàn cảnh quần đảo An Thới từ cabin cáp treo'
  ],
  ARRAY[
    'The 7,899m Hon Thom cable car — the longest over-sea cable car in the world',
    'Snorkel the coral at Hon Mong Tay and Hon Gam Ghi',
    'Swim in the jade-green water of the southern islands',
    'Fishing and relaxing on the cruise boat',
    'Panoramic views of the An Thoi archipelago from the cabin'
  ],
  '[{"day":1,"title":"Phú Quốc – Hòn Thơm & 3 đảo – Phú Quốc","activities":["08:00 Xe đón khách tại khách sạn ra ga cáp treo An Thới","08:30 Cáp treo vượt biển 7.899m sang đảo Hòn Thơm — ngắm quần đảo An Thới","09:30 Xuống tàu ra Hòn Móng Tay: lặn ống thở ngắm san hô","11:00 Hòn Gầm Ghì: tắm biển, câu cá trên tàu","12:30 Ăn trưa hải sản trên tàu","14:00 Hòn Mây Rút: bãi cát trắng, nước trong, thư giãn","15:30 Cáp treo về đất liền","16:30 Xe đưa về khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Phu Quoc – Hon Thom and three islands – Phu Quoc","activities":["08:00 Hotel pickup, transfer to An Thoi cable car station","08:30 Ride the 7,899m sea cable car to Hon Thom, over the An Thoi archipelago","09:30 Boat to Hon Mong Tay: snorkel the coral reefs","11:00 Hon Gam Ghi: swim and fish from the boat","12:30 Seafood lunch on board","14:00 Hon May Rut: white sand, clear water, free relaxation","15:30 Cable car back to the mainland","16:30 Transfer back to hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Vé cáp treo Hòn Thơm khứ hồi","boat":"Tàu 3 đảo + đồ lặn ống thở","meals":"Ăn trưa hải sản trên tàu"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Round-trip Hon Thom cable car","boat":"Three-island boat and snorkel gear","meals":"Seafood lunch on board"}'::jsonb,
  'Cáp treo Hòn Thơm dài gần 8km là tuyến cáp treo vượt biển dài nhất thế giới — chỉ riêng cabin đã là một trải nghiệm với toàn cảnh quần đảo An Thới xanh ngắt bên dưới. Sang tới đảo, bạn lên tàu khám phá ba hòn đảo hoang sơ nhất Nam Phú Quốc: lặn ống thở ngắm san hô, tắm biển nước trong và ăn hải sản trên tàu.',
  'The nearly 8km Hon Thom cable car is the longest over-sea cable car in the world — the cabin ride alone is an experience, with the emerald An Thoi archipelago spread out below. On the island you board a boat to explore the three most pristine islets of southern Phu Quoc: snorkel the coral, swim in clear water and eat seafood on board.',
  'Full-day tour with the record Hon Thom cable car and snorkeling across three southern Phu Quoc islands.',
  'Tour cáp treo Hòn Thơm Phú Quốc: cáp treo vượt biển dài nhất thế giới, lặn san hô 3 đảo Nam đảo, ăn trưa hải sản. Trọn gói vé, đón khách sạn.',
  '["Đồ uống ngoài chương trình","Trò chơi công viên nước Aquatopia (tự chọn)","Tip cho HDV và thuyền viên"]'::jsonb,
  '["Drinks outside the program","Aquatopia water park rides (optional)","Tips for guide and crew"]'::jsonb,
  'Đón tại khách sạn trung tâm Phú Quốc', '08:00',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["hòn thơm","cáp treo","3 đảo","lặn san hô"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'cap-treo-hon-thom-3-dao-10061');

-- ─────────────────────────────────────────────────────────────
-- 2. VinWonders & Vinpearl Safari 1 ngày
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
  'Phú Quốc – VinWonders & Vinpearl Safari 1 Ngày',
  'VinWonders and Vinpearl Safari Full-Day Tour in Phu Quoc',
  'vinwonders-vinpearl-safari-10062',
  'Phú Quốc', 'south', 1, 0,
  1350000, 75, 30, 1, 'ACTIVE',
  'https://images.unsplash.com/photo-1534567110243-8875d64ca8ff?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1534567110243-8875d64ca8ff?w=800&q=80'],
  ARRAY[
    'Vinpearl Safari — vườn thú bán hoang dã lớn nhất Việt Nam',
    'Xe bus xuyên khu thú ăn cỏ và thú hoang dã',
    'VinWonders: công viên nước, thủy cung, khu cổ tích',
    'Show biểu diễn và trò chơi cảm giác mạnh',
    'Vé vào cổng trọn gói cả 2 công viên'
  ],
  ARRAY[
    'Vinpearl Safari — the largest open-zoo in Vietnam',
    'Ride the bus through the herbivore and wildlife zones',
    'VinWonders: water park, aquarium and fairytale land',
    'Live shows and thrill rides',
    'All-inclusive entry ticket to both parks'
  ],
  '[{"day":1,"title":"Phú Quốc – Safari & VinWonders – Phú Quốc","activities":["08:00 Xe đón khách tại khách sạn ra Bắc đảo","08:45 Vinpearl Safari: đi xe bus xuyên khu thú hoang dã (hổ, sư tử, hươu cao cổ)","10:00 Đi bộ khu vườn thú mở, xem show động vật","12:00 Ăn trưa (tự túc trong khu vui chơi)","13:00 Sang VinWonders: thủy cung, khu cổ tích châu Âu","14:30 Công viên nước: đường trượt, sông lười","16:00 Trò chơi cảm giác mạnh và show nhạc nước","17:30 Xe đưa về khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Phu Quoc – Safari and VinWonders – Phu Quoc","activities":["08:00 Hotel pickup, drive to the north of the island","08:45 Vinpearl Safari: bus ride through the wildlife zone (tigers, lions, giraffes)","10:00 Walk the open zoo and watch the animal show","12:00 Lunch (own expense inside the park)","13:00 Continue to VinWonders: aquarium and European fairytale land","14:30 Water park: slides and lazy river","16:00 Thrill rides and the water-music show","17:30 Transfer back to hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Vé trọn gói Vinpearl Safari + VinWonders"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"All-inclusive Vinpearl Safari and VinWonders ticket"}'::jsonb,
  'Hai công viên đình đám nhất Phú Quốc trong một ngày: sáng lên xe bus xuyên Vinpearl Safari — vườn thú bán hoang dã lớn nhất Việt Nam, nơi hổ, sư tử, hươu cao cổ đi lại tự do quanh xe; chiều sang VinWonders với thủy cung, khu cổ tích châu Âu, công viên nước và show nhạc nước. Vé trọn gói cả hai, xe đón tận khách sạn — lựa chọn số một cho gia đình.',
  'The two most famous parks in Phu Quoc in one day: a morning bus ride through Vinpearl Safari — Vietnam''s largest open zoo, where tigers, lions and giraffes roam freely around your bus; then VinWonders in the afternoon with its aquarium, European fairytale land, water park and water-music show. An all-inclusive ticket for both, with hotel pickup — the number-one pick for families.',
  'Full-day combo of Vinpearl Safari open zoo and VinWonders theme park with an all-inclusive ticket.',
  'Tour VinWonders & Vinpearl Safari Phú Quốc: vườn thú bán hoang dã lớn nhất VN, thủy cung, công viên nước, show nhạc nước. Trọn gói vé 2 công viên.',
  '["Ăn trưa trong công viên","Đồ uống và dịch vụ tự chọn","Tip cho HDV và tài xế"]'::jsonb,
  '["Lunch inside the park","Drinks and optional services","Tips for guide and driver"]'::jsonb,
  'Đón tại khách sạn trung tâm Phú Quốc', '08:00',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["vinwonders","vinpearl safari","vườn thú","công viên nước"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'vinwonders-vinpearl-safari-10062');

-- ─────────────────────────────────────────────────────────────
-- 3. Grand World & show Tinh Hoa Việt Nam
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
  'Phú Quốc – Grand World Về Đêm & Show "Tinh Hoa Việt Nam"',
  'Grand World Phu Quoc by Night with the Vietnam Quintessence Show',
  'grand-world-tinh-hoa-viet-nam-10063',
  'Phú Quốc', 'south', 1, 0,
  650000, 75, 30, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1602216056096-3b40cc0c9944?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1602216056096-3b40cc0c9944?w=800&q=80'],
  ARRAY[
    'Đi thuyền gondola trên "dòng sông Venice" giữa Phú Quốc',
    'Show "Tinh Hoa Việt Nam" trên mặt nước hoành tráng',
    'Bảo tàng gấu Teddy và phố đêm châu Âu lung linh',
    'Chợ đêm Vui-Fest sôi động ẩm thực và mua sắm',
    'Đi buổi tối — mát mẻ, đèn hoa rực rỡ'
  ],
  ARRAY[
    'Ride a gondola on the "Venice river" in the heart of Phu Quoc',
    'The grand water-stage show Vietnam Quintessence',
    'Teddy Bear Museum and a glowing European night street',
    'The lively Vui-Fest night market for food and shopping',
    'An evening tour — cool air and dazzling lights'
  ],
  '[{"day":1,"title":"Grand World Phú Quốc lên đèn","activities":["16:00 Xe đón khách tại khách sạn ra Grand World Bắc đảo","16:30 Dạo phố châu Âu, đi thuyền gondola trên dòng sông Venice","17:30 Tham quan bảo tàng gấu Teddy Bear Museum","18:30 Xem show đa phương tiện Tinh Hoa Việt Nam trên mặt nước","19:30 Chợ đêm Vui-Fest: ẩm thực đường phố, mua sắm","20:30 Tự do chụp ảnh phố đêm rực rỡ ánh đèn","21:00 Xe đưa về khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Grand World Phu Quoc lights up","activities":["16:00 Hotel pickup, drive to Grand World in the north","16:30 Stroll the European street and ride a gondola on the Venice river","17:30 Visit the Teddy Bear Museum","18:30 Watch the multimedia Vietnam Quintessence water show","19:30 Vui-Fest night market: street food and shopping","20:30 Free time for photos on the glowing night street","21:00 Transfer back to hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Vé thuyền gondola + show Tinh Hoa Việt Nam"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Gondola ride and Vietnam Quintessence show"}'::jsonb,
  'Khi mặt trời lặn, Grand World mới thực sự bừng sáng: những dãy phố kiểu châu Âu lên đèn, thuyền gondola lướt trên "dòng sông Venice", và cao trào là show đa phương tiện "Tinh Hoa Việt Nam" kể chuyện văn hóa Việt trên sân khấu nước. Kết thúc bằng vòng dạo chợ đêm Vui-Fest ăn uống, mua sắm. Tour buổi tối mát mẻ, hợp cả gia đình lẫn cặp đôi.',
  'When the sun sets, Grand World truly comes alive: European-style streets light up, gondolas glide along the "Venice river", and the highlight is the multimedia Vietnam Quintessence show telling the story of Vietnamese culture on a water stage. It ends with a stroll through the Vui-Fest night market. A cool evening tour for families and couples alike.',
  'Evening tour of Grand World with a gondola ride, the Vietnam Quintessence water show and the night market.',
  'Tour Grand World Phú Quốc về đêm: thuyền gondola sông Venice, show Tinh Hoa Việt Nam, bảo tàng gấu Teddy, chợ đêm Vui-Fest. Đón khách sạn.',
  '["Đồ uống và mua sắm tại chợ đêm","Trò chơi/dịch vụ có thu phí riêng","Tip cho HDV và tài xế"]'::jsonb,
  '["Drinks and shopping at the night market","Separately charged games or services","Tips for guide and driver"]'::jsonb,
  'Đón tại khách sạn trung tâm Phú Quốc', '16:00',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["grand world","tinh hoa việt nam","gondola","về đêm"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'grand-world-tinh-hoa-viet-nam-10063');

-- ─────────────────────────────────────────────────────────────
-- 4. Câu cá, lặn ngắm san hô & ngắm hoàng hôn
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
  'Phú Quốc – Câu Cá, Lặn Ngắm San Hô & Ngắm Hoàng Hôn Trên Biển',
  'Phu Quoc Fishing, Snorkeling and Sunset Boat Tour',
  'cau-ca-lan-san-ho-hoang-hon-10064',
  'Phú Quốc', 'south', 1, 0,
  850000, 75, 20, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1473116763249-2faaef81ccda?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1473116763249-2faaef81ccda?w=800&q=80'],
  ARRAY[
    'Câu cá trên biển cùng ngư dân, tự tay câu bữa tối',
    'Lặn ống thở ngắm san hô vùng biển Nam đảo',
    'Chế biến hải sản vừa câu ngay trên tàu',
    'Ngắm hoàng hôn tuyệt đẹp trên vịnh',
    'Thả mình trong làn nước ấm và yên tĩnh'
  ],
  ARRAY[
    'Fish at sea with local fishermen — catch your own dinner',
    'Snorkel the coral reefs of the southern waters',
    'Cook the seafood you just caught right on the boat',
    'Watch a stunning sunset over the bay',
    'Relax in the warm, calm water'
  ],
  '[{"day":1,"title":"Phú Quốc – biển chiều & hoàng hôn","activities":["13:30 Xe đón khách tại khách sạn ra bến tàu","14:00 Tàu ra khu biển Nam đảo, hướng dẫn câu cá","14:45 Câu cá cùng ngư dân — mực, cá bớp, cá nhồng","16:00 Lặn ống thở ngắm san hô tại điểm biển trong","17:00 Chế biến hải sản vừa câu, ăn nhẹ trên tàu","17:45 Ngắm hoàng hôn buông trên vịnh","18:30 Tàu về bến, xe đưa về khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Phu Quoc – afternoon sea and sunset","activities":["13:30 Hotel pickup, transfer to the pier","14:00 Boat to the southern waters, fishing briefing","14:45 Fish with the fishermen — squid, cobia, barracuda","16:00 Snorkel the coral at a clear-water spot","17:00 Cook the seafood you caught, a snack on board","17:45 Watch the sunset over the bay","18:30 Boat returns, transfer back to hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"boat":"Tàu + dụng cụ câu + đồ lặn ống thở","meals":"Ăn nhẹ hải sản tự câu trên tàu"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"boat":"Boat, fishing tackle and snorkel gear","meals":"Snack of the seafood you caught"}'::jsonb,
  'Buổi chiều đẹp nhất ở Phú Quốc là trên biển: ngư dân chỉ bạn cách câu mực, câu cá bớp, rồi lặn ống thở ngắm san hô ở vùng nước trong. Hải sản vừa kéo lên được chế biến ngay trên tàu, và khi mặt trời bắt đầu chìm xuống vịnh, cả khoang tàu nhuộm vàng cam — khoảnh khắc hoàng hôn Phú Quốc trứ danh. Một tour thư giãn nhẹ nhàng, hợp cặp đôi và gia đình.',
  'The finest afternoon in Phu Quoc is out at sea: fishermen show you how to catch squid and cobia, then you snorkel the coral in clear water. The seafood you pull up is cooked right on the boat, and as the sun sinks into the bay the whole deck glows amber — the famous Phu Quoc sunset. A gentle, relaxing tour for couples and families.',
  'Afternoon boat tour with fishing, coral snorkeling, fresh seafood and a Phu Quoc sunset.',
  'Tour câu cá lặn san hô Phú Quốc: câu cá cùng ngư dân, lặn ngắm san hô, hải sản tự câu, ngắm hoàng hôn trên vịnh. Đón khách sạn, buổi chiều.',
  '["Đồ uống ngoài chương trình","Bữa tối đầy đủ (chỉ ăn nhẹ trên tàu)","Tip cho HDV và thuyền viên"]'::jsonb,
  '["Drinks outside the program","A full dinner (only a snack on board)","Tips for guide and crew"]'::jsonb,
  'Đón tại khách sạn trung tâm Phú Quốc', '13:30',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["câu cá","lặn san hô","hoàng hôn","du thuyền"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'cau-ca-lan-san-ho-hoang-hon-10064');

-- ─────────────────────────────────────────────────────────────
-- 5. City tour Nam đảo: nhà thùng nước mắm, vườn tiêu, nhà tù
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
  'Phú Quốc – City Tour Nam Đảo: Nhà Thùng Nước Mắm, Vườn Tiêu & Nhà Tù',
  'Phu Quoc South Island Tour: Fish Sauce, Pepper Farm and Prison',
  'city-tour-nam-dao-nuoc-mam-10065',
  'Phú Quốc', 'south', 1, 0,
  650000, 75, 24, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1528181304800-259b08848526?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1528181304800-259b08848526?w=800&q=80'],
  ARRAY[
    'Nhà thùng nước mắm truyền thống — đặc sản trứ danh Phú Quốc',
    'Vườn tiêu Phú Quốc và cơ sở nuôi cấy ngọc trai',
    'Di tích Nhà tù Phú Quốc (nhà lao Cây Dừa) lịch sử',
    'Xưởng sim rượu — nếm thử rượu sim đặc sản',
    'Chùa Sùng Hưng cổ tự và làng chài Hàm Ninh'
  ],
  ARRAY[
    'Traditional fish-sauce houses — the famous Phu Quoc specialty',
    'A Phu Quoc pepper farm and a pearl-culture facility',
    'The historic Phu Quoc Prison (Coconut Prison) memorial',
    'A sim-wine workshop — taste the local rosy myrtle wine',
    'Sung Hung ancient pagoda and Ham Ninh fishing village'
  ],
  '[{"day":1,"title":"Vòng quanh Nam đảo Phú Quốc","activities":["08:30 Xe đón khách tại khách sạn","09:00 Nhà thùng nước mắm: xem ủ chượp cá cơm trong thùng gỗ trăm năm","09:45 Cơ sở ngọc trai: quy trình nuôi cấy, trưng bày","10:30 Vườn tiêu Phú Quốc và xưởng rượu sim","11:30 Di tích Nhà tù Phú Quốc — chứng tích lịch sử","12:30 Ăn trưa hải sản làng chài Hàm Ninh","14:00 Chùa Sùng Hưng cổ tự","15:00 Xe đưa về khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Around southern Phu Quoc","activities":["08:30 Hotel pickup","09:00 Fish-sauce house: see anchovies fermenting in century-old wooden vats","09:45 Pearl facility: the culturing process and showroom","10:30 Phu Quoc pepper farm and sim-wine workshop","11:30 Phu Quoc Prison memorial — a historic site","12:30 Seafood lunch at Ham Ninh fishing village","14:00 Sung Hung ancient pagoda","15:00 Transfer back to hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"meals":"Ăn trưa hải sản Hàm Ninh"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"meals":"Seafood lunch at Ham Ninh"}'::jsonb,
  'Phú Quốc không chỉ có biển: một ngày khám phá những gì làm nên hòn đảo — nhà thùng ủ nước mắm cá cơm trong thùng gỗ trăm năm, vườn tiêu xanh mướt, xưởng rượu sim, cơ sở ngọc trai và di tích Nhà tù Phú Quốc đầy xúc động. Trưa ăn hải sản ở làng chài Hàm Ninh mộc mạc. Tour văn hóa cho ai muốn hiểu đảo ngọc sâu hơn bãi biển.',
  'Phu Quoc is more than beaches: spend a day discovering what makes the island — fish-sauce houses fermenting anchovies in century-old wooden vats, lush pepper farms, a sim-wine workshop, a pearl facility and the moving Phu Quoc Prison memorial. Lunch is seafood at the rustic Ham Ninh fishing village. A cultural tour for those who want to know the pearl island beyond its beaches.',
  'Cultural south-island tour with fish-sauce houses, a pepper farm, the historic prison and a fishing village.',
  'City tour Nam đảo Phú Quốc: nhà thùng nước mắm, vườn tiêu, ngọc trai, rượu sim, Nhà tù Phú Quốc, làng chài Hàm Ninh. Trọn gói, đón khách sạn.',
  '["Đồ uống ngoài chương trình","Mua sắm nước mắm/ngọc trai/tiêu","Tip cho HDV và tài xế"]'::jsonb,
  '["Drinks outside the program","Fish sauce, pearl or pepper purchases","Tips for guide and driver"]'::jsonb,
  'Đón tại khách sạn trung tâm Phú Quốc', '08:30',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["city tour","nước mắm","vườn tiêu","nhà tù phú quốc"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'city-tour-nam-dao-nuoc-mam-10065');

-- ─────────────────────────────────────────────────────────────
-- 6. Bắc đảo: Vườn quốc gia, Rạch Vẹm & Gành Dầu
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
  'Phú Quốc – Bắc Đảo: Vườn Quốc Gia, Rạch Vẹm Ngắm Sao Biển & Gành Dầu',
  'Phu Quoc North Island: National Park, Starfish Beach and Ganh Dau',
  'bac-dao-rach-vem-ganh-dau-10066',
  'Phú Quốc', 'south', 1, 0,
  750000, 75, 24, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1518509562904-e7ef99cdcc86?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1518509562904-e7ef99cdcc86?w=800&q=80'],
  ARRAY[
    'Rạch Vẹm — bãi biển hàng nghìn sao biển đỏ',
    'Vườn quốc gia Phú Quốc rừng nguyên sinh xanh mát',
    'Mũi Gành Dầu nhìn sang Campuchia',
    'Bãi Dài hoang sơ lọt top bãi biển đẹp thế giới',
    'Ăn hải sản nhà bè trên biển'
  ],
  ARRAY[
    'Rach Vem — the beach of thousands of red starfish',
    'Phu Quoc National Park with cool primeval forest',
    'Ganh Dau cape looking across to Cambodia',
    'Pristine Bai Dai, ranked among the world''s best beaches',
    'Seafood at a floating raft restaurant'
  ],
  '[{"day":1,"title":"Phú Quốc – Bắc đảo hoang sơ","activities":["08:00 Xe đón khách tại khách sạn đi Bắc đảo","08:45 Vườn quốc gia Phú Quốc: rừng nguyên sinh, suối","10:00 Mũi Gành Dầu: ngắm biển giáp Campuchia","11:00 Rạch Vẹm: lội nước ngắm hàng nghìn sao biển đỏ","12:30 Ăn trưa hải sản nhà bè","14:00 Bãi Dài: tắm biển, thư giãn bãi cát trắng hoang sơ","16:00 Xe đưa về khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Phu Quoc – the wild north","activities":["08:00 Hotel pickup, drive to the north of the island","08:45 Phu Quoc National Park: primeval forest and streams","10:00 Ganh Dau cape: sea views toward Cambodia","11:00 Rach Vem: wade the shallows among thousands of red starfish","12:30 Seafood lunch at a floating raft","14:00 Bai Dai: swim and relax on the pristine white sand","16:00 Transfer back to hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"meals":"Ăn trưa hải sản nhà bè"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"meals":"Seafood lunch at a floating raft"}'::jsonb,
  'Bắc đảo Phú Quốc còn giữ nguyên nét hoang sơ: rừng nguyên sinh của vườn quốc gia, mũi Gành Dầu nhìn sang tận Campuchia, và đặc biệt là Rạch Vẹm — bãi biển cạn nơi hàng nghìn con sao biển đỏ nằm phơi mình dưới làn nước trong. Trưa ăn hải sản nhà bè, chiều tắm ở Bãi Dài lọt top bãi biển đẹp nhất thế giới. Một ngày về với thiên nhiên đảo ngọc.',
  'The north of Phu Quoc keeps its wild charm: the primeval forest of the national park, Ganh Dau cape with views across to Cambodia, and above all Rach Vem — a shallow beach where thousands of red starfish rest in the clear water. Lunch is seafood on a floating raft, and the afternoon is spent on Bai Dai, ranked among the world''s finest beaches. A day back with the island''s nature.',
  'North-island tour with the national park, Ganh Dau cape, the red-starfish beach of Rach Vem and Bai Dai.',
  'Tour Bắc đảo Phú Quốc: vườn quốc gia, mũi Gành Dầu, Rạch Vẹm ngắm sao biển đỏ, Bãi Dài, ăn hải sản nhà bè. Trọn gói, đón khách sạn.',
  '["Đồ uống ngoài chương trình","Hải sản gọi thêm tại nhà bè","Tip cho HDV và tài xế"]'::jsonb,
  '["Drinks outside the program","Extra seafood orders at the raft","Tips for guide and driver"]'::jsonb,
  'Đón tại khách sạn trung tâm Phú Quốc', '08:00',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["bắc đảo","rạch vẹm","sao biển","gành dầu"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'bac-dao-rach-vem-ganh-dau-10066');

-- ─────────────────────────────────────────────────────────────
-- 7. Lặn biển ngắm san hô cùng HLV (scuba)
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
  'Phú Quốc – Lặn Biển Ngắm San Hô Quần Đảo An Thới Cùng HLV',
  'Phu Quoc Scuba Diving in the An Thoi Archipelago with an Instructor',
  'lan-bien-san-ho-phu-quoc-10067',
  'Phú Quốc', 'south', 1, 0,
  1250000, 80, 12, 1, 'ACTIVE',
  'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=800&q=80'],
  ARRAY[
    'Lặn bình dưỡng khí ở rạn san hô quần đảo An Thới',
    'Dành cho cả người chưa biết bơi — HLV kèm 1-1',
    '2 lượt lặn ngắm san hô mềm và cá nhiệt đới',
    'Thiết bị lặn đạt chuẩn quốc tế',
    'Nhóm nhỏ, an toàn, ảnh/video dưới nước (tự chọn)'
  ],
  ARRAY[
    'Scuba diving on the coral reefs of the An Thoi archipelago',
    'Open to non-swimmers — one-on-one instructor guidance',
    'Two dives over soft coral and tropical fish',
    'International-standard diving equipment',
    'Small group, safe, optional underwater photos/video'
  ],
  '[{"day":1,"title":"Phú Quốc – lặn biển An Thới – Phú Quốc","activities":["07:30 Xe đón khách tại khách sạn ra bến An Thới","08:15 Tàu ra quần đảo An Thới","08:45 Hướng dẫn kỹ thuật lặn và an toàn cùng HLV","09:30 Lượt lặn 1: làm quen, ngắm san hô nông","11:00 Nghỉ ngơi, ăn nhẹ trên tàu","11:45 Lượt lặn 2: khám phá rạn san hô đẹp hơn","13:00 Ăn trưa trên tàu, tàu về bến","14:30 Xe đưa về khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Phu Quoc – An Thoi diving – Phu Quoc","activities":["07:30 Hotel pickup, transfer to An Thoi port","08:15 Boat to the An Thoi archipelago","08:45 Diving briefing and safety training with the instructor","09:30 Dive 1: get comfortable, explore shallow coral","11:00 Rest and a snack on board","11:45 Dive 2: explore the finer reef","13:00 Lunch on board, boat returns","14:30 Transfer back to hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"activities":"2 lượt lặn có HLV kèm + toàn bộ thiết bị","meals":"Ăn nhẹ và ăn trưa trên tàu"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"activities":"Two guided dives plus all equipment","meals":"Snack and lunch on board"}'::jsonb,
  'Quần đảo An Thới phía Nam Phú Quốc là một trong những điểm lặn đẹp nhất vịnh Thái Lan, với rạn san hô mềm rực rỡ và đàn cá nhiệt đới dày đặc. Bạn không cần biết bơi hay có bằng lặn: huấn luyện viên kèm 1-1, hướng dẫn kỹ thuật trên tàu rồi cùng bạn xuống hai lượt lặn. Nhóm nhỏ tối đa 12 khách để đảm bảo an toàn tuyệt đối.',
  'The An Thoi archipelago off southern Phu Quoc is one of the finest dive sites in the Gulf of Thailand, with vivid soft coral and dense schools of tropical fish. You need not be a swimmer or hold a license: a one-on-one instructor briefs you on the boat, then guides you through two dives. Small groups of max 12 keep it absolutely safe.',
  'Guided An Thoi scuba diving for beginners with two dives, full gear and one-on-one instruction.',
  'Tour lặn biển Phú Quốc: lặn bình khí quần đảo An Thới, HLV kèm 1-1 cho cả người chưa biết bơi, 2 lượt lặn, đủ thiết bị. Đón khách sạn.',
  '["Ảnh/video dưới nước (thuê riêng)","Đồ uống ngoài chương trình","Tip cho HLV và thuyền viên","Không phù hợp người có bệnh tim mạch/hô hấp nặng"]'::jsonb,
  '["Underwater photos/video (rented separately)","Drinks outside the program","Tips for instructor and crew","Not suitable for serious heart or respiratory conditions"]'::jsonb,
  'Đón tại khách sạn trung tâm Phú Quốc', '07:30',
  'day_tour', 'moderate', 'vi_en', 'flexible', 'premium',
  '["lặn biển","an thới","san hô","scuba"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'lan-bien-san-ho-phu-quoc-10067');

-- ─────────────────────────────────────────────────────────────
-- 8. Câu mực đêm & ngắm sao
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
  'Phú Quốc – Câu Mực Đêm & Ngắm Sao Trên Biển',
  'Phu Quoc Night Squid Fishing and Stargazing Boat Tour',
  'cau-muc-dem-phu-quoc-10068',
  'Phú Quốc', 'south', 1, 0,
  700000, 75, 20, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1502691876148-a84978e59af8?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1502691876148-a84978e59af8?w=800&q=80'],
  ARRAY[
    'Câu mực đêm cùng ngư dân dưới ánh đèn măng-xông',
    'Tự tay nướng mực vừa câu ngay trên tàu',
    'Ngắm bầu trời sao và biển đêm Phú Quốc',
    'Trải nghiệm đời sống ngư dân đảo về đêm',
    'Nhóm nhỏ, ấm cúng, hợp cặp đôi và gia đình'
  ],
  ARRAY[
    'Night squid fishing with fishermen under gas lamps',
    'Grill the squid you just caught right on the boat',
    'Gaze at the stars and the night sea of Phu Quoc',
    'Experience island fishermen life after dark',
    'Small, cozy group — great for couples and families'
  ],
  '[{"day":1,"title":"Phú Quốc – câu mực dưới trời sao","activities":["17:30 Xe đón khách tại khách sạn ra bến tàu","18:00 Tàu ra khơi, ngắm hoàng hôn trên biển","18:45 Hướng dẫn câu mực bằng đèn và mồi giả","19:30 Câu mực đêm cùng ngư dân dưới ánh đèn","20:30 Nướng mực vừa câu, thưởng thức trên tàu","21:15 Ngắm sao, nghe ngư dân kể chuyện biển","21:45 Tàu về bến, xe đưa về khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Phu Quoc – squid fishing under the stars","activities":["17:30 Hotel pickup, transfer to the pier","18:00 Boat sets out, watch the sunset at sea","18:45 Squid-fishing briefing with lamps and lures","19:30 Night squid fishing with the fishermen under the lamps","20:30 Grill the fresh squid and enjoy it on board","21:15 Stargazing and sea stories from the fishermen","21:45 Boat returns, transfer back to hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"boat":"Tàu + dụng cụ câu mực","meals":"Mực nướng tự câu trên tàu"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"boat":"Boat and squid-fishing tackle","meals":"Grilled squid you caught, on board"}'::jsonb,
  'Khi màn đêm buông, ngư dân Phú Quốc thắp đèn măng-xông ra khơi câu mực — và bạn được cùng họ trải nghiệm nghề biển hàng trăm năm này. Thả câu dưới ánh đèn, mực cắn câu kéo lên nướng ngay trên tàu, nhâm nhi giữa biển đêm lấp lánh sao. Một tối yên bình và khác lạ, đậm chất đảo ngọc, hợp cặp đôi lẫn gia đình.',
  'When night falls, Phu Quoc fishermen light their gas lamps and head out to catch squid — and you join them in this centuries-old trade. Drop your line under the lamps, pull up squid and grill it right on the boat, snacking beneath a star-filled night sea. A peaceful, unusual evening full of island character, perfect for couples and families.',
  'Evening boat tour for night squid fishing under lamps, grilling your catch and stargazing at sea.',
  'Tour câu mực đêm Phú Quốc: câu mực cùng ngư dân dưới ánh đèn, nướng mực tự câu, ngắm sao trên biển. Buổi tối, đón khách sạn.',
  '["Đồ uống có cồn ngoài chương trình","Bữa tối đầy đủ (chỉ ăn mực nướng)","Tip cho HDV và thuyền viên"]'::jsonb,
  '["Alcoholic drinks beyond the program","A full dinner (only grilled squid)","Tips for guide and crew"]'::jsonb,
  'Đón tại khách sạn trung tâm Phú Quốc', '17:30',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["câu mực","về đêm","ngắm sao","du thuyền"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'cau-muc-dem-phu-quoc-10068');

-- ─────────────────────────────────────────────────────────────
-- 9. Bãi Sao & Bãi Khem — thiên đường cát trắng
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
  'Phú Quốc – Bãi Sao & Bãi Khem: Thiên Đường Cát Trắng Nam Đảo',
  'Phu Quoc Bai Sao and Bai Khem: White-Sand Beach Paradise',
  'bai-sao-bai-khem-cat-trang-10069',
  'Phú Quốc', 'south', 1, 0,
  600000, 75, 24, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&q=80'],
  ARRAY[
    'Bãi Sao — cát trắng mịn như bột, nước xanh ngọc',
    'Bãi Khem hoang sơ lọt top bãi biển đẹp châu Á',
    'Thư giãn, tắm biển và chơi thể thao bãi biển',
    'Ăn hải sản tươi ven biển Nam đảo',
    'Buổi tối tự do ngắm hoàng hôn (tùy chọn)'
  ],
  ARRAY[
    'Bai Sao — powder-white sand and jade-green water',
    'Pristine Bai Khem, ranked among Asia''s best beaches',
    'Relax, swim and enjoy beach sports',
    'Fresh seafood by the southern shore',
    'Optional evening sunset viewing'
  ],
  '[{"day":1,"title":"Phú Quốc – hai bãi biển đẹp nhất Nam đảo","activities":["08:30 Xe đón khách tại khách sạn đi Nam đảo","09:15 Bãi Khem: tắm biển, thư giãn bãi cát trắng hoang sơ","11:30 Ăn trưa hải sản ven biển","13:00 Bãi Sao: cát trắng mịn, nước trong, chơi thể thao biển","15:00 Tự do nằm võng dừa, chụp ảnh","16:00 Xe đưa về khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Phu Quoc – the two finest beaches of the south","activities":["08:30 Hotel pickup, drive to the south of the island","09:15 Bai Khem: swim and relax on the pristine white sand","11:30 Seafood lunch by the shore","13:00 Bai Sao: powder-white sand, clear water, beach sports","15:00 Free time in coconut hammocks and photos","16:00 Transfer back to hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"meals":"Ăn trưa hải sản ven biển"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"meals":"Seafood lunch by the shore"}'::jsonb,
  'Bãi Sao và Bãi Khem là hai bãi biển đẹp nhất Phú Quốc — cát trắng mịn như bột, nước xanh trong đến mức nhìn thấy đáy, hàng dừa nghiêng soi bóng. Một ngày thảnh thơi: tắm biển, nằm võng dừa, chơi thể thao bãi biển và ăn hải sản tươi ngay ven bờ. Không lịch trình dày đặc — chỉ có biển đẹp và thời gian cho riêng bạn.',
  'Bai Sao and Bai Khem are the two finest beaches of Phu Quoc — powder-white sand, water so clear you can see the bottom, and leaning coconut palms. A leisurely day: swim, laze in a coconut hammock, enjoy beach sports and eat fresh seafood right by the shore. No packed schedule — just beautiful beaches and time for yourself.',
  'Relaxed beach day at Phu Quoc''s two finest shores, Bai Sao and Bai Khem, with seafood by the sea.',
  'Tour Bãi Sao & Bãi Khem Phú Quốc: hai bãi biển cát trắng đẹp nhất Nam đảo, tắm biển, thể thao biển, ăn hải sản ven bờ. Đón khách sạn.',
  '["Đồ uống ngoài chương trình","Thuê ghế/dù/thể thao biển","Tip cho HDV và tài xế"]'::jsonb,
  '["Drinks outside the program","Beach chair, umbrella or sports rental","Tips for guide and driver"]'::jsonb,
  'Đón tại khách sạn trung tâm Phú Quốc', '08:30',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["bãi sao","bãi khem","bãi biển","cát trắng"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'bai-sao-bai-khem-cat-trang-10069');

-- ─────────────────────────────────────────────────────────────
-- 10. Food tour đêm & chợ đêm Phú Quốc
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
  'Phú Quốc – Food Tour Đêm & Chợ Đêm Dinh Cậu',
  'Phu Quoc Night Food Tour and Dinh Cau Night Market',
  'phu-quoc-food-tour-dem-10070',
  'Phú Quốc', 'south', 1, 0,
  800000, 75, 12, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800&q=80'],
  ARRAY[
    'Hải sản tươi sống chợ đêm Dinh Cậu chọn tận bể',
    'Nhum biển nướng mỡ hành, gỏi cá trích đặc sản',
    'Bún quậy Phú Quốc — món chỉ có ở đảo ngọc',
    'Nước mắm, tiêu, rượu sim — đặc sản đưa cay',
    'HDV bản địa dẫn qua các quán chính gốc'
  ],
  ARRAY[
    'Fresh seafood picked from the tank at Dinh Cau night market',
    'Grilled sea urchin with scallion oil and herring salad',
    'Bun quay Phu Quoc — a noodle dish found only on the island',
    'Fish sauce, pepper and sim wine — local specialties',
    'A local guide leading you to authentic eateries'
  ],
  '[{"day":1,"title":"Phú Quốc lên đèn — hành trình ẩm thực","activities":["18:00 HDV đón khách tại khách sạn","Điểm 1: bún quậy Phú Quốc — món đặc sản chỉ có ở đảo","Điểm 2: gỏi cá trích cuốn bánh tráng rau rừng","Điểm 3: chợ đêm Dinh Cậu — hải sản chọn tận bể, nướng tại chỗ","Điểm 4: nhum biển (cầu gai) nướng mỡ hành","Điểm 5: nếm nước mắm, tiêu, rượu sim đặc sản","20:30 Dạo chợ đêm mua đặc sản làm quà","21:00 HDV đưa về khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Phu Quoc lights up — a food journey","activities":["18:00 Your guide picks you up at the hotel","Stop 1: bun quay Phu Quoc — a noodle dish unique to the island","Stop 2: herring salad rolled in rice paper with wild herbs","Stop 3: Dinh Cau night market — seafood picked from the tank, grilled on the spot","Stop 4: grilled sea urchin with scallion oil","Stop 5: taste local fish sauce, pepper and sim wine","20:30 Stroll the night market for local specialties as gifts","21:00 Your guide drops you back at the hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":"Đi bộ + xe điện giữa các điểm","insurance":true,"meals":"Toàn bộ món ăn và 1 đồ uống mỗi điểm"}'::jsonb,
  '{"guide":true,"transfer":"Walking plus electric cart between stops","insurance":true,"meals":"All food stops plus one drink per stop"}'::jsonb,
  'Đảo ngọc có những món không nơi nào có: bún quậy nấu tại bàn, gỏi cá trích tươi rói, nhum biển nướng mỡ hành béo ngậy, và hải sản chọn tận bể ở chợ đêm Dinh Cậu nướng ngay trước mặt. Cùng HDV bản địa đi qua những quán chính gốc mà khách Tây khó tự tìm, nếm thử nước mắm - tiêu - rượu sim trứ danh, khép lại bằng vòng dạo chợ đêm mua quà.',
  'The pearl island has dishes found nowhere else: bun quay cooked at your table, ultra-fresh herring salad, rich grilled sea urchin with scallion oil, and seafood picked from the tank at Dinh Cau night market and grilled before your eyes. With a local guide you reach authentic spots hard to find alone, taste the famous fish sauce, pepper and sim wine, and finish with a stroll through the night market for gifts.',
  'Night food tour with island-only bun quay, herring salad, grilled sea urchin and Dinh Cau night market.',
  'Food tour đêm Phú Quốc: bún quậy, gỏi cá trích, nhum biển nướng, hải sản chợ đêm Dinh Cậu, nước mắm-tiêu-rượu sim. HDV bản địa, đón khách sạn.',
  '["Đồ uống có cồn ngoài chương trình","Mua sắm đặc sản tại chợ đêm","Tip cho HDV"]'::jsonb,
  '["Alcoholic drinks beyond the program","Buying specialties at the night market","Tips for the guide"]'::jsonb,
  'Đón tại khách sạn trung tâm Phú Quốc', '18:00',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["food tour","bún quậy","chợ đêm dinh cậu","nhum biển"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'phu-quoc-food-tour-dem-10070');

-- ─────────────────────────────────────────────────────────────
-- Tạo lịch khởi hành ngay (không cần chờ cron đêm)
-- ─────────────────────────────────────────────────────────────
select public.extend_day_tour_schedules();

-- Kiểm tra: 10 tour Phú Quốc ACTIVE, mỗi tour 60 lịch
select t.slug, t.base_price, count(s.id) as so_lich, min(s.depart_date) as ngay_dau
from public.tours t
left join public.tour_schedules s on s.tour_id = t.id and s.depart_date > current_date
where t.destination = 'Phú Quốc'
group by t.slug, t.base_price
order by t.slug;
