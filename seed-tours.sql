-- Baggio Travel — Seed 10 tours
-- Chạy trong Supabase SQL Editor (Dashboard → SQL Editor → New query)
-- Chỉ dùng các cột thực tế tồn tại trong bảng tours

-- ── MIỀN BẮC ────────────────────────────────────────────────────────

-- Tour 1: Hạ Long Cruise
INSERT INTO tours (name_vi, slug, destination, region, duration_days, duration_nights, base_price, child_price_pct, min_pax, max_pax, status, cover_image, images, includes_vi, itinerary_vi, highlights_vi, translation_status)
VALUES (
  'Hạ Long – Nghỉ Đêm Tàu Cruise 3N2Đ',
  'ha-long-cruise-3n2d-10001',
  'Hạ Long', 'north', 3, 2, 6800000, 65, 2, 20, 'ACTIVE',
  'https://images.unsplash.com/photo-1528181304800-259b08848526?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1528181304800-259b08848526?w=800&q=80','https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800&q=80'],
  $j${"hotel":{"star":4,"room_count":1,"desc":"Cabin giường đôi trên du thuyền 4 sao"},"guide":true,"transfer":true,"meals":true,"insurance":true}$j$::jsonb,
  $j$[{"day":1,"title":"Hà Nội – Hạ Long – Xuống Tàu","activities":["07:00 Xe đón tại khách sạn Hà Nội","12:00 Lên tàu, check-in cabin, ăn trưa","Chiều tham quan Hang Sửng Sốt và bơi bãi cát trắng","19:00 BBQ hải sản trên tàu – ngắm hoàng hôn vịnh"]},{"day":2,"title":"Chèo Kayak – Làng Chài – Nấu Ăn","activities":["06:00 Tập Thái Cực trên boong tàu","Sáng chèo kayak khám phá Làng Chài Vung Viêng","11:30 Lớp học nấu ăn món Việt cùng đầu bếp tàu","Chiều leo núi Đảo Ti Tốp ngắm toàn cảnh vịnh"]},{"day":3,"title":"Bình Minh – Trở Về Hà Nội","activities":["06:00 Ngắm bình minh trên vịnh","07:30 Điểm tâm, trả cabin","11:00 Cập bến, xe đưa về Hà Nội","16:00 Về đến Hà Nội"]}]$j$::jsonb,
  ARRAY['Du thuyền 4 sao cabin riêng view vịnh','Chèo kayak qua hang động và làng chài cổ','Lớp học nấu ăn Việt trên tàu','Hoàng hôn và bình minh Vịnh Hạ Long','Hải sản tươi sống tại chỗ'],
  'pending'
);

-- Tour 2: Sa Pa Trekking
INSERT INTO tours (name_vi, slug, destination, region, duration_days, duration_nights, base_price, child_price_pct, min_pax, max_pax, status, cover_image, images, includes_vi, itinerary_vi, highlights_vi, translation_status)
VALUES (
  'Sa Pa – Trekking Bản Làng & Ruộng Bậc Thang 3N2Đ',
  'sa-pa-trekking-3n2d-10002',
  'Sa Pa', 'north', 3, 2, 4200000, 70, 4, 16, 'ACTIVE',
  'https://images.unsplash.com/photo-1503891450247-ee5f8ec46dc3?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1503891450247-ee5f8ec46dc3?w=800&q=80','https://images.unsplash.com/photo-1504454043279-1cf90cc85a50?w=800&q=80'],
  $j${"hotel":{"star":3,"room_count":1,"desc":"1 đêm khách sạn Sa Pa + 1 đêm homestay bản làng"},"guide":true,"transfer":true,"meals":true,"insurance":true}$j$::jsonb,
  $j$[{"day":1,"title":"Hà Nội – Sa Pa – Bản Cát Cát","activities":["06:30 Xe limousine từ Hà Nội","11:30 Đến Sa Pa, nhận phòng","14:30 Trekking xuống Bản Cát Cát (6km) – làng người H Mông","18:00 Trở về thị trấn, ăn tối và dạo chợ đêm"]},{"day":2,"title":"Trekking Lao Chải – Tả Van – Homestay","activities":["08:00 Xuất phát trekking Lao Chải – Tả Van (14km)","12:30 Ăn trưa tại nhà dân – thử rượu ngô Sa Pa","Chiều tham quan nhà máy giấy dó truyền thống","19:00 Ăn tối cùng gia đình, giao lưu văn hoá – Homestay"]},{"day":3,"title":"Thác Bạc – Về Hà Nội","activities":["08:30 Tham quan Thác Bạc và Cổng Trời","10:30 Mua sắm thổ cẩm chợ Sa Pa","12:00 Xe về Hà Nội","17:30 Về đến Hà Nội"]}]$j$::jsonb,
  ARRAY['HDV người H Mông địa phương dẫn đường','Ăn tối và ngủ homestay tại bản làng thực sự','Ruộng bậc thang Mường Hoa mùa lúa chín','Trekking 14km qua 3 bản làng dân tộc','Chợ đêm Sa Pa – ẩm thực và thổ cẩm'],
  'pending'
);

-- Tour 3: Ninh Bình
INSERT INTO tours (name_vi, slug, destination, region, duration_days, duration_nights, base_price, child_price_pct, min_pax, max_pax, status, cover_image, images, includes_vi, itinerary_vi, highlights_vi, translation_status)
VALUES (
  'Ninh Bình – Tràng An & Tam Cốc 2N1Đ',
  'ninh-binh-trang-an-2n1d-10003',
  'Ninh Bình', 'north', 2, 1, 2100000, 75, 2, 24, 'ACTIVE',
  'https://images.unsplash.com/photo-1536332672584-e39aeb9fff37?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1536332672584-e39aeb9fff37?w=800&q=80'],
  $j${"hotel":{"star":3,"room_count":1,"desc":"Khách sạn 3 sao gần Tràng An"},"guide":true,"transfer":true,"meals":true,"insurance":true}$j$::jsonb,
  $j$[{"day":1,"title":"Hà Nội – Ninh Bình – Tràng An – Bái Đính","activities":["07:30 Xe đón tại Hà Nội","09:30 Thăm Chùa Bái Đính – chùa lớn nhất Đông Nam Á","12:00 Ăn trưa cơm niêu Ninh Bình đặc sản","13:30 Chèo thuyền Tràng An qua 9 hang động (di sản UNESCO)","19:00 Tối thịt dê núi và cơm cháy đặc sản Ninh Bình"]},{"day":2,"title":"Tam Cốc – Hang Múa – Về Hà Nội","activities":["08:00 Thuyền Tam Cốc qua 3 hang và đồng lúa","10:30 Leo 500 bậc Hang Múa ngắm toàn cảnh núi non","12:30 Ăn trưa, mua sắm đặc sản rượu Kim Sơn và cơm cháy","14:00 Xe về Hà Nội – đến nơi khoảng 16:30"]}]$j$::jsonb,
  ARRAY['Chèo thuyền Tràng An di sản UNESCO kép','Toàn cảnh Ninh Bình từ đỉnh Hang Múa 500 bậc','Cơm niêu và thịt dê núi đặc trưng Ninh Bình','Chùa Bái Đính – lớn nhất Đông Nam Á'],
  'pending'
);

-- ── MIỀN TRUNG ────────────────────────────────────────────────────────

-- Tour 4: Hội An
INSERT INTO tours (name_vi, slug, destination, region, duration_days, duration_nights, base_price, child_price_pct, min_pax, max_pax, status, cover_image, images, includes_vi, itinerary_vi, highlights_vi, translation_status)
VALUES (
  'Hội An – Phố Cổ Đèn Lồng & Ẩm Thực 3N2Đ',
  'hoi-an-pho-co-3n2d-10004',
  'Hội An', 'central', 3, 2, 3400000, 70, 2, 20, 'ACTIVE',
  'https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80','https://images.unsplash.com/photo-1598935888738-cd41fb994da7?w=800&q=80'],
  $j${"hotel":{"star":3,"room_count":1,"desc":"Khách sạn 3 sao khu phố cổ"},"guide":true,"transfer":true,"meals":true,"insurance":true}$j$::jsonb,
  $j$[{"day":1,"title":"Đà Nẵng – Hội An – Khám Phá Phố Cổ","activities":["10:00 Xe đón về Hội An, nhận phòng","13:00 Ăn trưa Cơm Gà Bà Buội nổi tiếng","14:30 HDV dẫn tham quan phố cổ: Chùa Cầu, Nhà Cổ Phùng Hưng, Hội Quán Phúc Kiến","18:00 Phóng đèn hoa đăng xuống sông Hoài","20:00 Tối dạo chợ đêm: Cao Lầu và Bánh Mì Phượng"]},{"day":2,"title":"Làng Rau – Nấu Ăn – Mỹ Sơn","activities":["07:00 Đạp xe ra Làng Rau Trà Quế","09:30 Lớp học nấu ăn: Mì Quảng và Bánh Xèo","14:00 Xe đến Thánh Địa Mỹ Sơn – di sản Chăm Pa","19:30 Biểu diễn múa Chăm và ăn tối trên thuyền sông"]},{"day":3,"title":"Cù Lao Chàm – Biển Xanh","activities":["07:30 Tàu cao tốc ra Cù Lao Chàm (45 phút)","09:30 Bơi lặn ngắm san hô tại Bãi Chồng","12:00 Ăn trưa hải sản tươi tại đảo","16:00 Tàu về Hội An, tự do mua sắm"]}]$j$::jsonb,
  ARRAY['Đêm thắp đèn hoa đăng trên sông Hoài','Lớp học nấu Mì Quảng và Bánh Xèo trong nhà cổ','Đạp xe xuyên làng rau Trà Quế','Thánh địa Mỹ Sơn – di sản Chăm Pa','Lặn ngắm san hô Cù Lao Chàm'],
  'pending'
);

-- Tour 5: Đà Nẵng
INSERT INTO tours (name_vi, slug, destination, region, duration_days, duration_nights, base_price, child_price_pct, min_pax, max_pax, status, cover_image, images, includes_vi, itinerary_vi, highlights_vi, translation_status)
VALUES (
  'Đà Nẵng – Bà Nà Hills & Cầu Vàng 4N3Đ',
  'da-nang-ba-na-hills-4n3d-10005',
  'Đà Nẵng', 'central', 4, 3, 5200000, 70, 2, 18, 'ACTIVE',
  'https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=800&q=80'],
  $j${"hotel":{"star":4,"room_count":1,"desc":"Khách sạn 4 sao ven biển Mỹ Khê"},"guide":true,"transfer":true,"meals":true,"insurance":true}$j$::jsonb,
  $j$[{"day":1,"title":"Đến Đà Nẵng – Phố Đêm","activities":["Nhận phòng khách sạn ven biển Mỹ Khê","Chiều tắm biển Mỹ Khê – top 6 bãi biển đẹp nhất thế giới","Tối: Cầu Rồng phun lửa (thứ 7 và CN 21:00), ăn Mỳ Quảng"]},{"day":2,"title":"Bà Nà Hills – Cầu Vàng","activities":["07:30 Xe lên Bà Nà Hills","08:30 Cáp treo lên đỉnh – kỷ lục thế giới Guinness","09:00 Chụp ảnh Cầu Vàng biểu tượng du lịch Việt Nam","10:00 Tham quan Làng Pháp và vườn hoa Alpine","12:00 Ăn trưa buffet trên đỉnh","Chiều Fantasy Park – công viên giải trí trong nhà"]},{"day":3,"title":"Ngũ Hành Sơn – Làng Đá – Biển","activities":["08:00 Tham quan Ngũ Hành Sơn","Khám phá hang động Huyền Không","10:30 Làng nghề điêu khắc đá mỹ nghệ Non Nước","Chiều tắm biển Non Nước","Tối BBQ hải sản chợ đêm Đà Nẵng"]},{"day":4,"title":"Núi Thần Tài – Về Sân Bay","activities":["08:00 Suối Khoáng Nóng Núi Thần Tài","10:00 Thư giãn trong bể khoáng thiên nhiên","12:00 Ăn trưa, mua đặc sản Đà Nẵng","14:00 Xe ra sân bay"]}]$j$::jsonb,
  ARRAY['Cầu Vàng Bà Nà Hills – biểu tượng du lịch Việt Nam','Cáp treo kỷ lục Guinness tại Bà Nà Hills','Biển Mỹ Khê top 6 đẹp nhất thế giới (Forbes)','Ngũ Hành Sơn – hang động huyền bí và làng đá mỹ nghệ','Cầu Rồng phun lửa phun nước cuối tuần'],
  'pending'
);

-- Tour 6: Huế
INSERT INTO tours (name_vi, slug, destination, region, duration_days, duration_nights, base_price, child_price_pct, min_pax, max_pax, status, cover_image, images, includes_vi, itinerary_vi, highlights_vi, translation_status)
VALUES (
  'Huế – Cố Đô Vương Triều Nguyễn 2N1Đ',
  'hue-co-do-nguyen-2n1d-10006',
  'Huế', 'central', 2, 1, 2400000, 75, 2, 22, 'ACTIVE',
  'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800&q=80'],
  $j${"hotel":{"star":3,"room_count":1,"desc":"Khách sạn 3 sao trung tâm Huế"},"guide":true,"transfer":true,"meals":true,"insurance":true,"boat":true}$j$::jsonb,
  $j$[{"day":1,"title":"Đà Nẵng – Huế – Đại Nội – Lăng Tẩm","activities":["08:00 Xe từ Đà Nẵng qua đèo Hải Vân vào Huế","10:00 Thăm Đại Nội – Hoàng Cung Triều Nguyễn","12:30 Ăn trưa Cơm Hến và Bún Bò Huế tại địa phương","14:00 Lăng Khải Định – kiến trúc Đông Tây kết hợp","16:00 Lăng Minh Mạng – lăng đẹp nhất triều Nguyễn","18:30 Thuyền rồng trên sông Hương nghe ca Huế","20:00 Buffet ẩm thực cung đình Huế 20 món"]},{"day":2,"title":"Chùa Thiên Mụ – Làng Hương – Về","activities":["08:00 Chùa Thiên Mụ – ngôi chùa cổ nhất Huế","09:30 Làng nghề hương Thủy Xuân – tự tay cắm hương","11:00 Chợ Đông Ba mua Mè Xửng và Tôm Chua đặc sản","12:00 Ăn trưa Bánh Bèo Bánh Nậm Bánh Lọc","14:00 Xe về Đà Nẵng hoặc sân bay Phú Bài"]}]$j$::jsonb,
  ARRAY['Đại Nội – Hoàng Cung 143 công trình kiến trúc cổ','Ca Huế trên thuyền rồng sông Hương','Buffet ẩm thực cung đình Huế 20+ món','Làng hương Thủy Xuân – tự tay cắm hương','Đèo Hải Vân – một trong những đèo đẹp nhất Việt Nam'],
  'pending'
);

-- ── MIỀN NAM ──────────────────────────────────────────────────────────

-- Tour 7: Phú Quốc
INSERT INTO tours (name_vi, slug, destination, region, duration_days, duration_nights, base_price, child_price_pct, min_pax, max_pax, status, cover_image, images, includes_vi, itinerary_vi, highlights_vi, translation_status)
VALUES (
  'Phú Quốc – Đảo Ngọc Resort 5 Sao 4N3Đ',
  'phu-quoc-resort-5-sao-4n3d-10007',
  'Phú Quốc', 'south', 4, 3, 8500000, 65, 2, 14, 'ACTIVE',
  'https://images.unsplash.com/photo-1540202403-b7abd6747a18?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1540202403-b7abd6747a18?w=800&q=80','https://images.unsplash.com/photo-1559308688-0a6cf2e5de4e?w=800&q=80'],
  $j${"hotel":{"star":5,"room_count":1,"desc":"Resort 5 sao hồ bơi vô cực view biển"},"guide":true,"transfer":true,"meals":true,"insurance":true}$j$::jsonb,
  $j$[{"day":1,"title":"Bay Đến Phú Quốc – Biển Chiều","activities":["Bay đến sân bay Phú Quốc, xe đón về resort 5 sao","Chiều thư giãn hồ bơi vô cực nhìn ra biển","18:00 Hoàng hôn tại Dinh Cậu – điểm ngắm đẹp nhất đảo","20:00 Chợ Đêm Phú Quốc – ghẹ, tôm, cá thu nướng"]},{"day":2,"title":"Vinpearl Safari – Bãi Sao","activities":["08:00 Vinpearl Safari – safari thú hoang dã","12:00 Ăn trưa tại Safari Restaurant","14:00 Bãi Sao – bãi biển đẹp nhất Phú Quốc","Tắm biển và cocktail dừa tươi trên cát trắng","19:00 Nhum Biển và Ghẹ Cà Mau hấp sả"]},{"day":3,"title":"Cáp Treo Hòn Thơm – Lặn San Hô","activities":["08:30 Cáp treo vượt biển Hòn Thơm 7.899m – dài nhất thế giới","10:00 Bơi và lặn ngắm san hô tại đảo Hòn Thơm","12:30 Ăn trưa hải sản tươi tại đảo","17:00 Spa thư giãn tại resort","20:00 Grand World – phố đi bộ Châu Âu thu nhỏ"]},{"day":4,"title":"Nước Mắm – Hồ Tiêu – Về Nhà","activities":["08:00 Làng Chài Hàm Ninh – cua ghẹ tươi","09:30 Cơ sở sản xuất Nước Mắm Phú Quốc","11:00 Vườn Tiêu – thử tiêu tươi đặc sản","12:30 Ăn trưa, mua sắm quà tặng","14:30 Xe ra sân bay"]}]$j$::jsonb,
  ARRAY['Resort 5 sao hồ bơi vô cực nhìn ra biển Phú Quốc','Cáp treo Hòn Thơm dài nhất thế giới 7.899m','Vinpearl Safari – safari thú hoang dã','Lặn ngắm san hô Hòn Thơm với HDV chuyên nghiệp','Hoàng hôn Dinh Cậu và chợ đêm hải sản tươi sống'],
  'pending'
);

-- Tour 8: Đà Lạt
INSERT INTO tours (name_vi, slug, destination, region, duration_days, duration_nights, base_price, child_price_pct, min_pax, max_pax, status, cover_image, images, includes_vi, itinerary_vi, highlights_vi, translation_status)
VALUES (
  'Đà Lạt – Thành Phố Ngàn Hoa & Cà Phê 3N2Đ',
  'da-lat-ngan-hoa-cafe-3n2d-10008',
  'Đà Lạt', 'south', 3, 2, 3600000, 70, 2, 20, 'ACTIVE',
  'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800&q=80'],
  $j${"hotel":{"star":3,"room_count":1,"desc":"Boutique hotel phong cách Pháp tại Đà Lạt"},"guide":true,"transfer":true,"meals":true,"insurance":true}$j$::jsonb,
  $j$[{"day":1,"title":"TP.HCM – Đà Lạt – Chiều Phố","activities":["07:00 Xe từ TP.HCM hoặc bay 45 phút","11:30 Đến Đà Lạt, nhận phòng boutique hotel","14:30 Vườn Hoa Thành Phố – hoa mimosa nở rộ mùa 11–3","16:30 Hồ Xuân Hương – đạp vịt ven hồ lãng mạn","19:00 Chợ Đêm Đà Lạt: Bánh Tráng Nướng, Nem Nướng, Phở Khô"]},{"day":2,"title":"Thác Datanla – Làng Cù Lần – Đồi Chè","activities":["09:00 Thác Datanla – xe trượt coaster xuống thác","11:00 Làng Cù Lần – bản văn hoá K Ho giữa rừng thông","12:30 Ăn trưa thịt nướng dã ngoại giữa rừng","14:30 Đồi Chè Cầu Đất – địa điểm check-in nổi tiếng","19:00 Lẩu bò rau rừng trong căn nhà gỗ ấm cúng"]},{"day":3,"title":"Dâu Tây – Cà Phê – Về TP.HCM","activities":["08:00 Vườn Dâu Tây Langbiang – tự hái dâu tươi","11:00 Cafe Túi Mơ To – cà phê độc đáo giữa rừng thông","12:30 Mua đặc sản mứt, atiso, rượu vang Đà Lạt","14:30 Xe về TP.HCM – về đến nơi khoảng 20:00"]}]$j$::jsonb,
  ARRAY['Đồi chè Cầu Đất bát ngát – địa điểm check-in nổi tiếng','Hái dâu tây tươi tại vườn Langbiang','Làng Cù Lần K Ho giữa rừng thông nguyên sinh','Thác Datanla – xe trượt coaster hồi hộp','Cà phê sáng tạo giữa rừng thông – đặc trưng Đà Lạt'],
  'pending'
);

-- Tour 9: Mê Kông
INSERT INTO tours (name_vi, slug, destination, region, duration_days, duration_nights, base_price, child_price_pct, min_pax, max_pax, status, cover_image, images, includes_vi, itinerary_vi, highlights_vi, translation_status)
VALUES (
  'Mê Kông – Sông Nước Miền Tây & Chợ Nổi 2N1Đ',
  'me-kong-cho-noi-2n1d-10009',
  'Cần Thơ', 'south', 2, 1, 2600000, 75, 2, 24, 'ACTIVE',
  'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=800&q=80'],
  $j${"hotel":{"star":3,"room_count":1,"desc":"Khách sạn 3 sao Cần Thơ trung tâm"},"guide":true,"transfer":true,"meals":true,"insurance":true,"boat":true}$j$::jsonb,
  $j$[{"day":1,"title":"TP.HCM – Cần Thơ – Cồn Ấu","activities":["06:30 Xe từ TP.HCM về Cần Thơ","10:30 Đến Cần Thơ – ăn trưa Bún Cá Lóc đặc sản","12:00 Thuyền ra Cồn Ấu giữa sông Hậu","Đạp xe xuyên vườn dừa, thăm trại ong mật","Thử trái cây tươi: sầu riêng, chôm chôm, măng cụt","19:00 Lẩu Cá Kèo miền Tây tại nhà hàng nổi trên sông"]},{"day":2,"title":"Chợ Nổi Cái Răng – Làng Nghề – Về","activities":["05:30 Thuyền ra Chợ Nổi Cái Răng khi bình minh vừa lên","Mua trái cây tươi từ các ghe hàng – trải nghiệm độc đáo","07:30 Điểm tâm Hủ Tiếu Nam Vang đích thực","09:00 Làng nghề đan lát Mỹ Lồng – xem thợ đan giỏ dừa","11:00 Vườn Trái Cây – hái quả ăn thỏa thích","12:30 Cá Tai Tượng chiên giòn giữa vườn xanh","14:00 Xe về TP.HCM"]}]$j$::jsonb,
  ARRAY['Chợ Nổi Cái Răng lúc 5:30 sáng – trải nghiệm độc đáo','Đạp xe xuyên vườn dừa và thử trái cây tươi tại chỗ','Nhà hàng nổi trên sông Hậu – ăn tối lãng mạn','Làng nghề đan lát truyền thống Mỹ Lồng','Lẩu Cá Kèo và Cá Tai Tượng chiên – đặc sản miền Tây'],
  'pending'
);

-- Tour 10: Nha Trang
INSERT INTO tours (name_vi, slug, destination, region, duration_days, duration_nights, base_price, child_price_pct, min_pax, max_pax, status, cover_image, images, includes_vi, itinerary_vi, highlights_vi, translation_status)
VALUES (
  'Nha Trang – Lặn Biển Hòn Mun & Vinpearl 3N2Đ',
  'nha-trang-lan-bien-3n2d-10010',
  'Nha Trang', 'central', 3, 2, 4100000, 70, 2, 20, 'ACTIVE',
  'https://images.unsplash.com/photo-1559308688-0a6cf2e5de4e?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1559308688-0a6cf2e5de4e?w=800&q=80'],
  $j${"hotel":{"star":4,"room_count":1,"desc":"Khách sạn 4 sao ven biển Trần Phú"},"guide":true,"transfer":true,"meals":true,"insurance":true}$j$::jsonb,
  $j$[{"day":1,"title":"Đến Nha Trang – Phố Biển","activities":["Nhận phòng khách sạn ven biển Trần Phú","Chiều: Biển Nha Trang và Chùa Long Sơn – tượng Phật trắng","Tháp Chăm Po Nagar – di tích 2.000 năm tuổi","Tối: Bún Cá Ngừ và Nem Nướng Ninh Hòa đặc sản"]},{"day":2,"title":"Vinpearl Land – Tắm Bùn","activities":["08:00 Cáp treo vượt biển vào Vinpearl Land","Aquarium – vương quốc đại dương 30.000 sinh vật","Công viên nước và các trò chơi mạo hiểm","13:00 Buffet tại Vinpearl","16:30 Mud Bath I-Resort – tắm bùn khoáng thiên nhiên độc đáo","19:30 BBQ hải sản chợ Đầm Nha Trang"]},{"day":3,"title":"Lặn Biển Hòn Mun – Về","activities":["07:30 Tàu ra đảo Hòn Mun (tàu đáy kính)","Lặn snorkeling và scuba với HDV chuyên nghiệp","12:30 Ăn trưa hải sản nướng trên tàu","14:00 Về đất liền","15:00 Mua đặc sản Tôm khô, Mực khô, Yến sào Nha Trang","16:30 Tự do hoặc ra sân bay"]}]$j$::jsonb,
  ARRAY['Cáp treo Vinpearl vượt biển – kỳ quan giải trí','Lặn ngắm san hô Hòn Mun – khu bảo tồn biển quốc gia','Tắm bùn khoáng nóng I-Resort thư giãn','Tháp Chăm Po Nagar 2.000 năm tuổi','Hải sản tươi sống giá tốt nhất Việt Nam'],
  'pending'
);
