-- Baggio Travel — Seed 10 tour Buôn Ma Thuột 3N2Đ
-- Chạy trong Supabase SQL Editor (Dashboard → SQL Editor → New query)
-- Chỉ dùng các cột thực tế tồn tại trong bảng tours

-- Tour 1: Thủ Phủ Cà Phê
INSERT INTO tours (name_vi, slug, destination, region, duration_days, duration_nights, base_price, child_price_pct, min_pax, max_pax, status, cover_image, images, includes_vi, itinerary_vi, highlights_vi, translation_status)
VALUES (
  'Buôn Ma Thuột – Thủ Phủ Cà Phê Việt Nam 3N2Đ',
  'buon-ma-thuot-thu-phu-ca-phe-3n2d-10011',
  'Buôn Ma Thuột', 'central', 3, 2, 3800000, 70, 2, 20, 'ACTIVE',
  'https://images.unsplash.com/photo-1447933601403-0c6688de566e?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1447933601403-0c6688de566e?w=800&q=80','https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=800&q=80'],
  $j${"hotel":{"star":4,"room_count":1,"desc":"Khách sạn 4 sao trung tâm Buôn Ma Thuột"},"guide":true,"transfer":true,"meals":true,"insurance":true}$j$::jsonb,
  $j$[{"day":1,"title":"Đến Buôn Ma Thuột – Bảo Tàng Thế Giới Cà Phê","activities":["Bay đến sân bay Buôn Ma Thuột, xe đón về khách sạn","12:00 Ăn trưa Bún Đỏ – đặc sản chỉ có ở BMT","14:00 Bảo Tàng Thế Giới Cà Phê – kiến trúc nhà dài Ê Đê cách điệu","16:30 Ngã 6 Ban Mê và Tượng đài Chiến thắng","19:00 Tối Gà Nướng Bản Đôn và Cơm Lam"]},{"day":2,"title":"Farm Cà Phê – Rang Xay – Thử Nếm","activities":["07:30 Xe ra farm cà phê tại xã Ea Tu","08:30 Đi bộ xuyên vườn cà phê Robusta, tìm hiểu quy trình canh tác","10:00 Trải nghiệm hái và sơ chế cà phê cùng nông dân","12:00 Ăn trưa tại farm giữa vườn cà phê","14:00 Lớp rang xay và cupping – thử nếm phân biệt Arabica/Robusta","16:30 Về thành phố, cà phê chồn tại Làng Cà Phê Trung Nguyên","19:30 Dạo chợ đêm Buôn Ma Thuột"]},{"day":3,"title":"Chùa Sắc Tứ Khải Đoan – Mua Sắm – Về","activities":["08:00 Chùa Sắc Tứ Khải Đoan – ngôi chùa gỗ lớn nhất Tây Nguyên","09:30 Nhà đày Buôn Ma Thuột – di tích lịch sử quốc gia","11:00 Mua cà phê đặc sản, bơ sáp, mắc ca làm quà","12:00 Ăn trưa Bánh Ướt Thịt Nướng Ban Mê","14:00 Xe ra sân bay"]}]$j$::jsonb,
  ARRAY['Bảo Tàng Thế Giới Cà Phê – biểu tượng mới của Ban Mê','Tự tay hái, rang xay và thử nếm cà phê tại farm','Cà phê chồn trứ danh tại Làng Cà Phê Trung Nguyên','Bún Đỏ và Gà Nướng Bản Đôn – đặc sản khó quên','Chùa gỗ Sắc Tứ Khải Đoan lớn nhất Tây Nguyên'],
  'pending'
);

-- Tour 2: Thác Dray Nur – Dray Sáp – Gia Long
INSERT INTO tours (name_vi, slug, destination, region, duration_days, duration_nights, base_price, child_price_pct, min_pax, max_pax, status, cover_image, images, includes_vi, itinerary_vi, highlights_vi, translation_status)
VALUES (
  'Buôn Ma Thuột – Bộ Ba Thác Hùng Vĩ Dray Nur 3N2Đ',
  'buon-ma-thuot-thac-dray-nur-3n2d-10012',
  'Buôn Ma Thuột', 'central', 3, 2, 3600000, 70, 2, 18, 'ACTIVE',
  'https://images.unsplash.com/photo-1432405972618-c60b0225b8f9?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1432405972618-c60b0225b8f9?w=800&q=80','https://images.unsplash.com/photo-1467890947394-8171244e5410?w=800&q=80'],
  $j${"hotel":{"star":3,"room_count":1,"desc":"Khách sạn 3 sao trung tâm + 1 đêm bungalow ven thác"},"guide":true,"transfer":true,"meals":true,"insurance":true}$j$::jsonb,
  $j$[{"day":1,"title":"Đến Ban Mê – Thác Dray Nur","activities":["Sân bay Buôn Ma Thuột – xe đón khởi hành đi thác (25km)","11:30 Ăn trưa cá lăng sông Sêrêpốk nướng muối ớt","13:30 Thác Dray Nur – bức tường nước cao 30m rộng 250m","15:00 Đi bộ sau màn nước vào hang động phía trong thác","17:00 Nhận bungalow ven thác, tối lửa trại BBQ"]},{"day":2,"title":"Thác Dray Sáp – Thác Gia Long – Cầu Treo","activities":["07:30 Điểm tâm, đi bộ qua cầu treo sang thác Dray Sáp","08:30 Thác Dray Sáp – thác khói huyền thoại của sông Sêrêpốk","11:00 Trekking đường rừng 4km sang thác Gia Long hoang sơ","12:30 Picnic trưa bên hồ tắm tự nhiên dưới chân thác","14:00 Bơi tại hồ nước trong xanh chân thác Gia Long","16:30 Về thành phố Buôn Ma Thuột, nhận phòng khách sạn","19:00 Tối Lẩu Cá Lăng măng chua"]},{"day":3,"title":"Buôn Ako Dhông – Cà Phê – Về","activities":["08:00 Buôn Ako Dhông – buôn Ê Đê đẹp nhất trong lòng thành phố","09:30 Cà phê trong ngôi nhà dài truyền thống","11:00 Mua đặc sản: cà phê, hạt mắc ca, mật ong rừng","12:00 Ăn trưa Bún Chìa – món trứ danh Ban Mê","14:00 Xe ra sân bay"]}]$j$::jsonb,
  ARRAY['Bộ ba thác Dray Nur – Dray Sáp – Gia Long trên sông Sêrêpốk','Ngủ bungalow ven thác – tiếng nước ru đêm Tây Nguyên','Đi bộ sau màn nước thác Dray Nur cao 30m','Bơi hồ tự nhiên hoang sơ chân thác Gia Long','Cá lăng sông Sêrêpốk nướng muối ớt trứ danh'],
  'pending'
);

-- Tour 3: Hồ Lắk – Buôn Jun
INSERT INTO tours (name_vi, slug, destination, region, duration_days, duration_nights, base_price, child_price_pct, min_pax, max_pax, status, cover_image, images, includes_vi, itinerary_vi, highlights_vi, translation_status)
VALUES (
  'Buôn Ma Thuột – Hồ Lắk & Buôn Jun Huyền Thoại 3N2Đ',
  'buon-ma-thuot-ho-lak-buon-jun-3n2d-10013',
  'Buôn Ma Thuột', 'central', 3, 2, 3900000, 70, 2, 16, 'ACTIVE',
  'https://images.unsplash.com/photo-1439066615861-d1af74d74000?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1439066615861-d1af74d74000?w=800&q=80','https://images.unsplash.com/photo-1470770841072-f978cf4d019e?w=800&q=80'],
  $j${"hotel":{"star":3,"room_count":1,"desc":"1 đêm khách sạn BMT + 1 đêm nhà dài M Nông ven hồ Lắk"},"guide":true,"transfer":true,"meals":true,"insurance":true,"boat":true}$j$::jsonb,
  $j$[{"day":1,"title":"Ban Mê – Hồ Lắk – Thuyền Độc Mộc","activities":["Sân bay Buôn Ma Thuột, xe đi hồ Lắk (52km)","11:30 Ăn trưa cơm lam gà nướng ven hồ","13:30 Chèo thuyền độc mộc trên hồ nước ngọt lớn nhất Tây Nguyên","15:30 Biệt điện Bảo Đại trên đồi ngắm toàn cảnh hồ","17:00 Nhận nhà dài M Nông tại Buôn Jun","19:00 Ăn tối cùng gia đình, rượu cần và cồng chiêng bên lửa trại"]},{"day":2,"title":"Buôn Jun – Ruộng Lúa – Đạp Xe Quanh Hồ","activities":["06:00 Bình minh trên hồ Lắk – săn sương sớm","07:30 Điểm tâm bún riêu cua đồng","08:30 Đạp xe quanh hồ qua ruộng lúa và các buôn làng M Nông","11:00 Thăm nhà sàn cổ, nghe kể sử thi Đam San","12:30 Ăn trưa cá thát lát hồ Lắk chiên giòn","14:30 Xe về Buôn Ma Thuột, nhận phòng khách sạn","19:00 Tối tự do khám phá ẩm thực đường Hai Bà Trưng"]},{"day":3,"title":"Bảo Tàng Đắk Lắk – Mua Sắm – Về","activities":["08:00 Bảo tàng Đắk Lắk – văn hoá 49 dân tộc anh em","10:00 Làng Cà Phê Trung Nguyên – thưởng thức cà phê chồn","11:30 Mua đặc sản bơ sáp, sầu riêng Dona, mắc ca","12:30 Ăn trưa Bún Đỏ Ban Mê","14:00 Xe ra sân bay"]}]$j$::jsonb,
  ARRAY['Chèo thuyền độc mộc trên hồ Lắk – hồ nước ngọt lớn nhất Tây Nguyên','Ngủ nhà dài M Nông đích thực tại Buôn Jun','Đêm rượu cần và cồng chiêng bên lửa trại','Biệt điện Bảo Đại view toàn cảnh hồ Lắk','Đạp xe qua ruộng lúa và buôn làng ven hồ'],
  'pending'
);

-- Tour 4: Buôn Đôn
INSERT INTO tours (name_vi, slug, destination, region, duration_days, duration_nights, base_price, child_price_pct, min_pax, max_pax, status, cover_image, images, includes_vi, itinerary_vi, highlights_vi, translation_status)
VALUES (
  'Buôn Ma Thuột – Buôn Đôn Xứ Sở Voi 3N2Đ',
  'buon-ma-thuot-buon-don-3n2d-10014',
  'Buôn Ma Thuột', 'central', 3, 2, 3700000, 70, 2, 20, 'ACTIVE',
  'https://images.unsplash.com/photo-1557050543-4d5f4e07ef46?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1557050543-4d5f4e07ef46?w=800&q=80','https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800&q=80'],
  $j${"hotel":{"star":3,"room_count":1,"desc":"Khách sạn 3 sao trung tâm Buôn Ma Thuột"},"guide":true,"transfer":true,"meals":true,"insurance":true}$j$::jsonb,
  $j$[{"day":1,"title":"Đến Ban Mê – Buôn Đôn – Cầu Treo Sêrêpốk","activities":["Sân bay Buôn Ma Thuột, xe đi Buôn Đôn (45km)","11:30 Ăn trưa Gà Nướng Bản Đôn chính gốc chấm muối é","13:30 Đi cầu treo lắc lư xuyên rừng si trăm tuổi trên sông Sêrêpốk","15:00 Thăm voi tại khu bảo tồn – cho voi ăn, chụp ảnh thân thiện","16:30 Mộ Vua Săn Voi Khun Ju Nốp và nhà sàn cổ 130 năm","18:00 Về thành phố, tối tự do"]},{"day":2,"title":"Vườn Quốc Gia Yok Đôn – Xem Voi Bán Hoang Dã","activities":["07:00 Xe vào Vườn Quốc Gia Yok Đôn – rừng khộp lớn nhất Việt Nam","08:30 Trekking cùng kiểm lâm theo dấu voi bán hoang dã","12:00 Picnic trưa bên suối trong rừng khộp","14:00 Đi thuyền trên sông Sêrêpốk ngắm chim và thú","16:30 Về Buôn Ma Thuột","19:00 Tối Lẩu Lá Rừng – hơn 10 loại lá Tây Nguyên"]},{"day":3,"title":"Buôn Ako Dhông – Cà Phê – Về","activities":["08:00 Buôn Ako Dhông – dãy nhà dài Ê Đê giữa lòng phố","09:30 Thưởng thức cà phê Ban Mê trong nhà dài","11:00 Mua đặc sản thổ cẩm, cà phê, mật ong rừng","12:00 Ăn trưa Bánh Canh Cá Dầm","14:00 Xe ra sân bay"]}]$j$::jsonb,
  ARRAY['Cầu treo Buôn Đôn xuyên rừng si trăm tuổi','Gặp voi thân thiện tại khu bảo tồn – không cưỡi voi','Trekking theo dấu voi hoang dã ở Yok Đôn cùng kiểm lâm','Gà Nướng Bản Đôn chính gốc chấm muối é','Lẩu Lá Rừng – tinh hoa ẩm thực Ê Đê'],
  'pending'
);

-- Tour 5: Trekking Chư Yang Sin
INSERT INTO tours (name_vi, slug, destination, region, duration_days, duration_nights, base_price, child_price_pct, min_pax, max_pax, status, cover_image, images, includes_vi, itinerary_vi, highlights_vi, translation_status)
VALUES (
  'Buôn Ma Thuột – Trekking Chư Yang Sin Nóc Nhà Đắk Lắk 3N2Đ',
  'buon-ma-thuot-trekking-chu-yang-sin-3n2d-10015',
  'Buôn Ma Thuột', 'central', 3, 2, 4500000, 60, 4, 12, 'ACTIVE',
  'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=800&q=80','https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800&q=80'],
  $j${"hotel":{"star":3,"room_count":1,"desc":"1 đêm khách sạn BMT + 1 đêm lều trại trong rừng (đầy đủ dụng cụ)"},"guide":true,"transfer":true,"meals":true,"insurance":true}$j$::jsonb,
  $j$[{"day":1,"title":"Ban Mê – Cửa Rừng – Trại Đêm Giữa Rừng","activities":["Sân bay Buôn Ma Thuột, xe đi huyện Lắk (60km)","11:00 Ăn trưa, kiểm tra trang bị cùng porter địa phương","12:30 Bắt đầu trekking xuyên rừng thường xanh (8km)","16:30 Dựng trại bên suối độ cao 1.400m","18:30 Cơm rừng nấu bếp củi, đêm lửa trại giữa đại ngàn"]},{"day":2,"title":"Chinh Phục Đỉnh Chư Yang Sin 2.442m","activities":["05:00 Dậy sớm, điểm tâm nhẹ, xuất phát lên đỉnh","09:30 Chạm đỉnh Chư Yang Sin 2.442m – nóc nhà Đắk Lắk","10:30 Ngắm biển mây và rừng nguyên sinh 360 độ","12:00 Ăn trưa trên núi, xuống núi theo đường suối","16:30 Ra cửa rừng, xe về Buôn Ma Thuột","19:30 Tối liên hoan Gà Nướng Cơm Lam mừng chinh phục thành công"]},{"day":3,"title":"Thư Giãn – Cà Phê – Về","activities":["Sáng tự do ngủ bù, massage thư giãn cơ","10:00 Cà phê tại Bảo Tàng Thế Giới Cà Phê","11:30 Mua đặc sản cà phê và mắc ca","12:30 Ăn trưa Bún Chìa Ban Mê","14:00 Xe ra sân bay"]}]$j$::jsonb,
  ARRAY['Chinh phục đỉnh Chư Yang Sin 2.442m – nóc nhà Đắk Lắk','Đêm lều trại bên suối giữa rừng nguyên sinh','Biển mây 360 độ trên đỉnh núi thiêng','Porter và HDV bản địa thông thuộc từng lối mòn','Bữa liên hoan mừng chinh phục kiểu Tây Nguyên'],
  'pending'
);

-- Tour 6: Mùa Hoa Cà Phê
INSERT INTO tours (name_vi, slug, destination, region, duration_days, duration_nights, base_price, child_price_pct, min_pax, max_pax, status, cover_image, images, includes_vi, itinerary_vi, highlights_vi, translation_status)
VALUES (
  'Buôn Ma Thuột – Mùa Hoa Cà Phê Trắng Trời 3N2Đ',
  'buon-ma-thuot-mua-hoa-ca-phe-3n2d-10016',
  'Buôn Ma Thuột', 'central', 3, 2, 4200000, 70, 2, 16, 'ACTIVE',
  'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=800&q=80','https://images.unsplash.com/photo-1447933601403-0c6688de566e?w=800&q=80'],
  $j${"hotel":{"star":4,"room_count":1,"desc":"Khách sạn 4 sao + 1 đêm farmstay giữa vườn cà phê"},"guide":true,"transfer":true,"meals":true,"insurance":true}$j$::jsonb,
  $j$[{"day":1,"title":"Đến Ban Mê – Săn Hoa Cà Phê (Tháng 2–3)","activities":["Sân bay Buôn Ma Thuột, xe đón về farmstay giữa vườn cà phê","11:30 Ăn trưa tại farm","14:00 Dạo vườn cà phê nở hoa trắng muốt thơm ngát như tuyết","16:00 Chụp ảnh cùng thợ ảnh địa phương (tặng 20 ảnh chỉnh sửa)","18:30 Tối BBQ tại farm, ngắm sao trời Tây Nguyên"]},{"day":2,"title":"Đồi Chè – Thác Dray Nur – Hoàng Hôn","activities":["06:00 Săn bình minh và sương sớm trên vườn hoa cà phê","08:30 Điểm tâm, xe đi thác Dray Nur","10:00 Thác Dray Nur hùng vĩ mùa nước đẹp","12:30 Ăn trưa cá lăng sông Sêrêpốk","14:30 Về thành phố, nhận phòng khách sạn 4 sao","16:30 Hoàng hôn tại hồ Ea Kao – điểm picnic của người Ban Mê","19:30 Tối Bún Đỏ và chè dạo phố"]},{"day":3,"title":"Bảo Tàng Cà Phê – Mua Sắm – Về","activities":["08:00 Bảo Tàng Thế Giới Cà Phê – triển lãm và thử nếm","10:30 Mua cà phê hoa nhài, mật ong hoa cà phê đặc biệt","12:00 Ăn trưa Bánh Ướt Thịt Nướng","14:00 Xe ra sân bay"]}]$j$::jsonb,
  ARRAY['Vườn cà phê nở hoa trắng như tuyết – chỉ có tháng 2–3','Tặng bộ 20 ảnh chụp giữa mùa hoa bởi thợ ảnh địa phương','Ngủ farmstay giữa vườn cà phê thơm ngát','Mật ong hoa cà phê – đặc sản theo mùa hiếm có','Hoàng hôn hồ Ea Kao như tranh vẽ'],
  'pending'
);

-- Tour 7: Văn Hoá Cồng Chiêng Ê Đê
INSERT INTO tours (name_vi, slug, destination, region, duration_days, duration_nights, base_price, child_price_pct, min_pax, max_pax, status, cover_image, images, includes_vi, itinerary_vi, highlights_vi, translation_status)
VALUES (
  'Buôn Ma Thuột – Đêm Cồng Chiêng & Văn Hoá Ê Đê 3N2Đ',
  'buon-ma-thuot-cong-chieng-e-de-3n2d-10017',
  'Buôn Ma Thuột', 'central', 3, 2, 4000000, 70, 4, 18, 'ACTIVE',
  'https://images.unsplash.com/photo-1533105079780-92b9be482077?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1533105079780-92b9be482077?w=800&q=80','https://images.unsplash.com/photo-1470770841072-f978cf4d019e?w=800&q=80'],
  $j${"hotel":{"star":3,"room_count":1,"desc":"1 đêm khách sạn BMT + 1 đêm nhà dài Ê Đê tại buôn"},"guide":true,"transfer":true,"meals":true,"insurance":true}$j$::jsonb,
  $j$[{"day":1,"title":"Đến Ban Mê – Buôn Ako Dhông – Sử Thi Đam San","activities":["Sân bay Buôn Ma Thuột, về khách sạn nhận phòng","12:00 Ăn trưa Bún Chìa giò heo","14:00 Buôn Ako Dhông – tìm hiểu chế độ mẫu hệ Ê Đê","15:30 Nghe nghệ nhân kể sử thi Đam San bên ché rượu cần","17:00 Học dệt thổ cẩm cùng các mế trong buôn","19:00 Tối Lẩu Lá Rừng và cà đắng đặc sản"]},{"day":2,"title":"Buôn Kmrơng Prông – Lễ Cúng Bến Nước – Đêm Cồng Chiêng","activities":["08:00 Xe về buôn Kmrơng Prông B ngoại thành","09:00 Tham dự tái hiện Lễ Cúng Bến Nước của người Ê Đê","11:00 Cùng gia đình nấu món Ê Đê: canh cà đắng, vếch bò","12:30 Ăn trưa trên nhà dài","15:00 Học đánh chiêng cơ bản cùng đội chiêng của buôn","18:30 Đêm hội cồng chiêng – múa xoang quanh lửa trại, rượu cần","Ngủ đêm tại nhà dài truyền thống"]},{"day":3,"title":"Chợ Sáng – Bảo Tàng – Về","activities":["07:00 Chợ sáng của buôn – trải nghiệm phiên chợ Tây Nguyên","09:30 Bảo tàng Đắk Lắk – không gian văn hoá cồng chiêng (di sản UNESCO)","11:30 Mua thổ cẩm và quà lưu niệm do chính tay nghệ nhân dệt","12:30 Ăn trưa Gà Nướng Cơm Lam","14:00 Xe ra sân bay"]}]$j$::jsonb,
  ARRAY['Đêm hội cồng chiêng – di sản văn hoá phi vật thể UNESCO','Ngủ nhà dài Ê Đê, tìm hiểu chế độ mẫu hệ độc đáo','Nghe sử thi Đam San bên ché rượu cần','Tự tay học dệt thổ cẩm và đánh chiêng','Lễ Cúng Bến Nước – nghi lễ thiêng của người Ê Đê'],
  'pending'
);

-- Tour 8: Ẩm Thực Tây Nguyên
INSERT INTO tours (name_vi, slug, destination, region, duration_days, duration_nights, base_price, child_price_pct, min_pax, max_pax, status, cover_image, images, includes_vi, itinerary_vi, highlights_vi, translation_status)
VALUES (
  'Buôn Ma Thuột – Food Tour Ẩm Thực Cao Nguyên 3N2Đ',
  'buon-ma-thuot-food-tour-3n2d-10018',
  'Buôn Ma Thuột', 'central', 3, 2, 3500000, 75, 2, 14, 'ACTIVE',
  'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800&q=80','https://images.unsplash.com/photo-1447933601403-0c6688de566e?w=800&q=80'],
  $j${"hotel":{"star":4,"room_count":1,"desc":"Khách sạn 4 sao trung tâm – gần phố ẩm thực"},"guide":true,"transfer":true,"meals":true,"insurance":true}$j$::jsonb,
  $j$[{"day":1,"title":"Đến Ban Mê – Food Tour Chiều Tối","activities":["Sân bay Buôn Ma Thuột, nhận phòng khách sạn","12:00 Mở màn với Bún Đỏ – linh hồn ẩm thực Ban Mê","15:00 Cà phê vợt kiểu xưa tại quán 60 năm tuổi","17:00 Food tour đường Hai Bà Trưng: Bánh Ướt Thịt Nướng cuốn tại bàn","19:00 Gà Nướng Bản Đôn, Cơm Lam chấm muối é","20:30 Tráng miệng chè thập cẩm và sữa chua dâu tằm"]},{"day":2,"title":"Chợ Sáng – Lớp Nấu Ăn – Đặc Sản Rừng","activities":["06:30 Đi chợ trung tâm cùng đầu bếp – chọn nguyên liệu","08:30 Lớp nấu ăn: Lẩu Lá Rừng, Canh Cà Đắng, Heo Rẫy Nướng","12:00 Thưởng thức thành quả bữa trưa tự nấu","14:30 Farm bơ sáp và sầu riêng Dona – thử tại vườn","17:00 Về thành phố","19:00 Tối Bò Nhúng Me và Bún Chìa trứ danh"]},{"day":3,"title":"Cà Phê Sáng – Mua Đặc Sản – Về","activities":["07:30 Cà phê chồn tại Làng Cà Phê Trung Nguyên","09:30 Mua đặc sản: cà phê, mắc ca, bơ sáp, mật ong, muối é","11:30 Bữa trưa chia tay: Bánh Canh Cá Dầm","13:30 Xe ra sân bay"]}]$j$::jsonb,
  ARRAY['Bún Đỏ, Bún Chìa, Gà Nướng Bản Đôn – tam tuyệt Ban Mê','Lớp nấu ăn món Ê Đê cùng đầu bếp địa phương','Đi chợ sáng chọn nguyên liệu như người bản xứ','Thử bơ sáp và sầu riêng Dona ngay tại vườn','Cà phê vợt 60 năm và cà phê chồn trứ danh'],
  'pending'
);

-- Tour 9: Đắk Lắk Liên Tuyến Trọn Gói
INSERT INTO tours (name_vi, slug, destination, region, duration_days, duration_nights, base_price, child_price_pct, min_pax, max_pax, status, cover_image, images, includes_vi, itinerary_vi, highlights_vi, translation_status)
VALUES (
  'Buôn Ma Thuột – Đắk Lắk Trọn Vẹn: Thác, Hồ Lắk, Buôn Đôn 3N2Đ',
  'buon-ma-thuot-dak-lak-tron-ven-3n2d-10019',
  'Buôn Ma Thuột', 'central', 3, 2, 4300000, 70, 2, 22, 'ACTIVE',
  'https://images.unsplash.com/photo-1470770841072-f978cf4d019e?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1470770841072-f978cf4d019e?w=800&q=80','https://images.unsplash.com/photo-1432405972618-c60b0225b8f9?w=800&q=80'],
  $j${"hotel":{"star":4,"room_count":1,"desc":"Khách sạn 4 sao trung tâm Buôn Ma Thuột 2 đêm"},"guide":true,"transfer":true,"meals":true,"insurance":true,"boat":true}$j$::jsonb,
  $j$[{"day":1,"title":"Đến Ban Mê – Thác Dray Nur – Bảo Tàng Cà Phê","activities":["Sân bay Buôn Ma Thuột, xe đón khởi hành đi thác","10:30 Thác Dray Nur – bức tường nước hùng vĩ nhất Tây Nguyên","12:30 Ăn trưa cá lăng sông Sêrêpốk","14:30 Bảo Tàng Thế Giới Cà Phê","16:30 Ngã 6 Ban Mê – check-in Tượng đài Chiến thắng","19:00 Tối Gà Nướng Cơm Lam, dạo phố đêm"]},{"day":2,"title":"Hồ Lắk – Thuyền Độc Mộc – Biệt Điện Bảo Đại","activities":["07:00 Xe đi hồ Lắk (52km) qua những rẫy cà phê bạt ngàn","09:00 Chèo thuyền độc mộc cùng ngư dân M Nông","11:00 Biệt điện Bảo Đại ngắm toàn cảnh hồ","12:00 Ăn trưa cá thát lát hồ Lắk và cơm lam","14:00 Dạo Buôn Jun – nhà dài và khung dệt thổ cẩm","16:00 Về thành phố","19:00 Tối Lẩu Lá Rừng và rượu cần"]},{"day":3,"title":"Buôn Đôn – Cầu Treo – Về","activities":["07:00 Xe đi Buôn Đôn (45km)","08:30 Cầu treo xuyên rừng si trên sông Sêrêpốk","10:00 Thăm voi tại khu bảo tồn, nhà sàn cổ 130 năm","11:30 Ăn trưa Gà Nướng Bản Đôn chính gốc","13:30 Về thành phố, mua đặc sản cà phê và mắc ca","15:30 Xe ra sân bay"]}]$j$::jsonb,
  ARRAY['Trọn bộ tinh hoa Đắk Lắk trong 3 ngày: thác, hồ, buôn làng','Thác Dray Nur + hồ Lắk + Buôn Đôn – 3 điểm không thể bỏ lỡ','Chèo thuyền độc mộc cùng ngư dân M Nông','Cầu treo Buôn Đôn và nhà sàn cổ 130 năm','Ẩm thực đủ vị: cá lăng, gà nướng, lẩu lá rừng'],
  'pending'
);

-- Tour 10: Glamping Hồ Ea Kao & Săn Mây
INSERT INTO tours (name_vi, slug, destination, region, duration_days, duration_nights, base_price, child_price_pct, min_pax, max_pax, status, cover_image, images, includes_vi, itinerary_vi, highlights_vi, translation_status)
VALUES (
  'Buôn Ma Thuột – Glamping Hồ Ea Kao & Săn Mây Cao Nguyên 3N2Đ',
  'buon-ma-thuot-glamping-ea-kao-3n2d-10020',
  'Buôn Ma Thuột', 'central', 3, 2, 4800000, 65, 2, 12, 'ACTIVE',
  'https://images.unsplash.com/photo-1478131143081-80f7f84ca84d?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1478131143081-80f7f84ca84d?w=800&q=80','https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800&q=80'],
  $j${"hotel":{"star":4,"room_count":1,"desc":"1 đêm lều glamping cao cấp ven hồ + 1 đêm khách sạn 4 sao"},"guide":true,"transfer":true,"meals":true,"insurance":true}$j$::jsonb,
  $j$[{"day":1,"title":"Đến Ban Mê – Glamping Ven Hồ Ea Kao","activities":["Sân bay Buôn Ma Thuột, xe đón về khu glamping hồ Ea Kao","12:00 Ăn trưa nhẹ tại khu trại","14:00 Chèo SUP trên hồ Ea Kao lặng gió","16:30 Trà chiều ngắm hoàng hôn nhuộm vàng mặt hồ","18:30 BBQ ngoài trời: heo rẫy, bò nướng ống tre","20:00 Đêm chiếu phim ngoài trời và ngắm sao"]},{"day":2,"title":"Săn Mây Đồi Cư H Lâm – Thác Dray Sáp","activities":["04:30 Xe đưa đi săn mây tại đồi thông Cư H Lâm","05:30 Biển mây bồng bềnh và bình minh cao nguyên","08:00 Điểm tâm Bún Đỏ, cà phê phin nóng","10:00 Thác Dray Sáp – thác khói huyền thoại","12:30 Ăn trưa gà nướng bên thác","15:00 Về thành phố nhận phòng khách sạn 4 sao, spa thư giãn","19:00 Tối Bò Nhúng Me phố Hai Bà Trưng"]},{"day":3,"title":"Bảo Tàng Cà Phê – Chill Cafe – Về","activities":["08:30 Bảo Tàng Thế Giới Cà Phê","10:30 Check-in các quán cafe view rẫy cà phê đẹp nhất Ban Mê","12:00 Ăn trưa Bánh Ướt Thịt Nướng","13:30 Mua đặc sản, xe ra sân bay"]}]$j$::jsonb,
  ARRAY['Glamping cao cấp ven hồ Ea Kao – tiện nghi giữa thiên nhiên','Săn biển mây bình minh trên đồi thông Cư H Lâm','Chèo SUP và chiếu phim ngoài trời bên hồ','BBQ heo rẫy, bò nướng ống tre kiểu Tây Nguyên','Kết hợp 1 đêm trại + 1 đêm khách sạn 4 sao trọn vẹn'],
  'pending'
);
