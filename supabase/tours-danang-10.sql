-- ═══════════════════════════════════════════════════════════════
-- 10 TOUR ĐÀ NẴNG cho khách nước ngoài — slug 10041 → 10050
-- Chạy trong Supabase → SQL Editor. Idempotent: mỗi INSERT có
-- WHERE NOT EXISTS theo slug — chạy lặp không tạo trùng.
-- Giá base_price là ƯỚC TÍNH theo mặt bằng thị trường 2026 (cách làm
-- chủ web đã duyệt ở batch TP.HCM & Hà Nội). Ảnh Unsplash placeholder.
-- Cuối file: gọi extend_day_tour_schedules() để có lịch hàng ngày ngay.
-- ═══════════════════════════════════════════════════════════════

-- Kiểm tra trước: các slug sắp thêm đã tồn tại chưa (mong đợi 0 dòng)
select slug, status from public.tours where slug ~ '-1004[1-9]$' or slug ~ '-10050$';

-- ─────────────────────────────────────────────────────────────
-- 1. Bà Nà Hills & Cầu Vàng 1 ngày
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
  'Đà Nẵng – Bà Nà Hills & Cầu Vàng 1 Ngày',
  'Ba Na Hills and Golden Bridge Full-Day Tour from Da Nang',
  'ba-na-hills-cau-vang-1-ngay-10041',
  'Đà Nẵng', 'central', 1, 0,
  1650000, 75, 24, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1564596823821-79b97151055e?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1564596823821-79b97151055e?w=800&q=80'],
  ARRAY[
    'Cầu Vàng trên đôi bàn tay đá — biểu tượng du lịch Việt Nam mới',
    'Cáp treo dài kỷ lục thế giới lên đỉnh Núi Chúa 1.487m',
    'Làng Pháp, vườn hoa Le Jardin và hầm rượu Debay trăm tuổi',
    'Fantasy Park — công viên trong nhà miễn phí trò chơi',
    'Buffet trưa quốc tế trên đỉnh núi (đã gồm trong giá)'
  ],
  ARRAY[
    'The Golden Bridge held by giant stone hands — the new icon of Vietnam',
    'A world-record cable car up to the 1,487m Chua Mountain summit',
    'French Village, Le Jardin flower garden and the century-old Debay wine cellar',
    'Fantasy Park indoor theme park with free-play rides',
    'International buffet lunch at the summit (included)'
  ],
  '[{"day":1,"title":"Đà Nẵng – Bà Nà Hills – Đà Nẵng","activities":["07:30 Xe đón khách tại khách sạn trung tâm Đà Nẵng","08:30 Đến chân núi Bà Nà, lên cáp treo kỷ lục thế giới","09:00 Cầu Vàng — check-in sớm tránh đông, ngắm biển mây","10:00 Vườn hoa Le Jardin d Amour và hầm rượu Debay 100 năm","11:00 Làng Pháp với nhà thờ, quảng trường kiểu châu Âu","12:00 Buffet trưa quốc tế nhà hàng trên đỉnh","13:30 Fantasy Park: tàu lượn, phim 4D, tháp rơi tự do (miễn phí)","15:30 Cáp treo xuống núi","16:30 Về đến khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Da Nang – Ba Na Hills – Da Nang","activities":["07:30 Hotel pickup in central Da Nang","08:30 Arrive at the foot of Ba Na, board the world-record cable car","09:00 Golden Bridge — early check-in before the crowds, sea of clouds","10:00 Le Jardin d Amour gardens and the 100-year-old Debay wine cellar","11:00 French Village with its cathedral and European square","12:00 International buffet lunch at the summit restaurant","13:30 Fantasy Park: roller coaster, 4D cinema, free-fall tower (free play)","15:30 Cable car down the mountain","16:30 Drop off at your hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Vé cáp treo + toàn bộ công viên","meals":"Buffet trưa quốc tế trên đỉnh"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Cable car and full park ticket","meals":"International buffet lunch"}'::jsonb,
  'Cầu Vàng trên đôi bàn tay khổng lồ đã đưa Bà Nà Hills thành điểm check-in nổi tiếng toàn cầu. Tour trọn gói lo hết: xe đón tận khách sạn, vé cáp treo kỷ lục thế giới, buffet trưa trên đỉnh và cả Fantasy Park chơi thả ga — bạn chỉ việc lên đỉnh Núi Chúa săn biển mây.',
  'The Golden Bridge resting on giant stone hands has made Ba Na Hills world-famous. This all-inclusive tour handles everything: hotel pickup, the world-record cable car, a summit buffet lunch and free play at Fantasy Park — all you do is chase the sea of clouds on Chua Mountain.',
  'Full-day Ba Na Hills tour with Golden Bridge, record cable car, French Village, Fantasy Park and buffet lunch.',
  'Tour Bà Nà Hills 1 ngày từ Đà Nẵng: Cầu Vàng, cáp treo kỷ lục, Làng Pháp, Fantasy Park, buffet trưa. Trọn gói vé, đón tận khách sạn.',
  '["Trò chơi có thu phí riêng trong Fantasy Park (bảo tàng sáp...)","Đồ uống ngoài chương trình","Tip cho HDV và tài xế"]'::jsonb,
  '["Separately charged attractions inside Fantasy Park (wax museum...)","Drinks outside the program","Tips for guide and driver"]'::jsonb,
  'Đón tại khách sạn trung tâm Đà Nẵng', '07:30',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["bà nà hills","cầu vàng","cáp treo","1 ngày"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'ba-na-hills-cau-vang-1-ngay-10041');

-- ─────────────────────────────────────────────────────────────
-- 2. Hội An chiều tối: phố cổ & thả hoa đăng
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
  'Đà Nẵng – Hội An Chiều Tối: Phố Cổ & Thả Hoa Đăng',
  'Hoi An Afternoon and Evening Tour with Lantern Boat Ride',
  'hoi-an-chieu-toi-hoa-dang-10042',
  'Đà Nẵng', 'central', 1, 0,
  850000, 75, 20, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1553603227-2358aabe821e?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1553603227-2358aabe821e?w=800&q=80','https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800&q=80'],
  ARRAY[
    'Phố cổ Hội An lúc đẹp nhất — khi đèn lồng bắt đầu thắp sáng',
    'Thuyền thả hoa đăng trên sông Hoài huyền ảo',
    'Chùa Cầu Nhật Bản 400 năm và hội quán người Hoa',
    'Ăn tối đặc sản: cao lầu, bánh vạc "hoa hồng trắng"',
    'Khởi hành buổi chiều — sáng vẫn tự do tắm biển'
  ],
  ARRAY[
    'Hoi An at its finest hour — as thousands of lanterns light up',
    'Release flower lanterns from a boat on the dreamy Hoai River',
    'The 400-year-old Japanese Covered Bridge and Chinese assembly halls',
    'Local dinner: cao lau noodles and white rose dumplings',
    'Afternoon departure — your morning stays free for the beach'
  ],
  '[{"day":1,"title":"Đà Nẵng – Hội An về đêm – Đà Nẵng","activities":["14:30 Xe đón khách tại khách sạn Đà Nẵng, đi Hội An (30km)","15:15 Đi bộ phố cổ: Chùa Cầu, nhà cổ Tấn Ký, hội quán Phúc Kiến","16:30 Tự do dạo phố, may đo lấy nhanh hoặc cà phê ven sông","18:00 Ăn tối đặc sản Hội An: cao lầu, bánh vạc, hoành thánh","19:00 Thuyền trên sông Hoài — tự tay thả hoa đăng cầu may","19:45 Dạo chợ đêm Nguyễn Hoàng, phố đèn lồng lung linh","20:30 Lên xe về Đà Nẵng, 21:15 kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Da Nang – Hoi An by night – Da Nang","activities":["14:30 Hotel pickup in Da Nang, drive to Hoi An (30km)","15:15 Old town walk: Japanese Bridge, Tan Ky ancient house, Fujian assembly hall","16:30 Free time for tailor shops or a riverside coffee","18:00 Hoi An specialty dinner: cao lau, white rose dumplings, wonton","19:00 Boat on the Hoai River — release your own flower lantern","19:45 Nguyen Hoang night market and the glowing lantern streets","20:30 Drive back to Da Nang, 21:15 tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Vé tham quan phố cổ","boat":"Thuyền hoa đăng sông Hoài","meals":"Ăn tối cao lầu, bánh vạc"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Old town entrance ticket","boat":"Hoai River lantern boat","meals":"Cao lau and white rose dinner"}'::jsonb,
  'Hội An đẹp nhất khi hoàng hôn buông và nghìn chiếc đèn lồng thắp sáng — tour này canh đúng khoảnh khắc đó. Chiều dạo Chùa Cầu và nhà cổ, tối ăn cao lầu chính gốc rồi lên thuyền thả hoa đăng trên sông Hoài. Buổi sáng của bạn vẫn trọn vẹn cho bãi biển Mỹ Khê.',
  'Hoi An is most beautiful when dusk falls and a thousand lanterns glow — this tour is timed exactly for that moment. Walk the Japanese Bridge and ancient houses in the afternoon, dine on authentic cao lau, then drift down the Hoai River releasing flower lanterns. Your morning stays free for My Khe beach.',
  'Afternoon-evening Hoi An tour with old town walk, specialty dinner and a lantern boat ride on the Hoai River.',
  'Tour Hội An chiều tối từ Đà Nẵng: phố cổ, Chùa Cầu, ăn tối cao lầu, thuyền thả hoa đăng sông Hoài, chợ đêm. Đón khách sạn Đà Nẵng.',
  '["Đồ uống ngoài chương trình","Chi phí may đo, mua sắm","Tip cho HDV, tài xế và người chèo thuyền"]'::jsonb,
  '["Drinks outside the program","Tailoring and shopping expenses","Tips for guide, driver and boat rower"]'::jsonb,
  'Đón tại khách sạn trung tâm Đà Nẵng', '14:30',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["hội an","hoa đăng","phố cổ","chiều tối"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'hoi-an-chieu-toi-hoa-dang-10042');

-- ─────────────────────────────────────────────────────────────
-- 3. Ngũ Hành Sơn + chùa Linh Ứng + Hội An 1 ngày
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
  'Đà Nẵng – Ngũ Hành Sơn, Chùa Linh Ứng & Hội An 1 Ngày',
  'Marble Mountains, Linh Ung Pagoda and Hoi An Full-Day Tour',
  'ngu-hanh-son-linh-ung-hoi-an-10043',
  'Đà Nẵng', 'central', 1, 0,
  1150000, 75, 20, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1533050487297-09b450131914?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1533050487297-09b450131914?w=800&q=80'],
  ARRAY[
    'Ngũ Hành Sơn: động Huyền Không huyền ảo và chùa Tam Thai',
    'Tượng Phật Bà 67m tại chùa Linh Ứng bán đảo Sơn Trà',
    'Làng đá mỹ nghệ Non Nước 400 năm tuổi',
    'Chiều tối dạo phố cổ Hội An khi đèn lồng thắp sáng',
    'Gói gọn 3 điểm nổi tiếng nhất Đà Nẵng - Quảng Nam trong 1 ngày'
  ],
  ARRAY[
    'Marble Mountains: the mystical Huyen Khong Cave and Tam Thai Pagoda',
    'The 67m Lady Buddha at Linh Ung Pagoda on Son Tra Peninsula',
    'The 400-year-old Non Nuoc stone carving village',
    'Hoi An old town in the evening as the lanterns come on',
    'The three biggest sights of the region packed into one day'
  ],
  '[{"day":1,"title":"Sơn Trà – Ngũ Hành Sơn – Hội An","activities":["08:00 Xe đón khách tại khách sạn Đà Nẵng","08:30 Bán đảo Sơn Trà: chùa Linh Ứng, tượng Phật Bà 67m nhìn ra vịnh","10:00 Ngũ Hành Sơn — thang máy lên Thủy Sơn, động Huyền Không, chùa Tam Thai","11:45 Làng đá mỹ nghệ Non Nước dưới chân núi","12:30 Ăn trưa đặc sản Quảng: mì Quảng, bánh tráng cuốn thịt heo","14:00 Đến Hội An: Chùa Cầu, nhà cổ, hội quán","17:00 Ngắm phố cổ lên đèn, tự do chụp ảnh","18:30 Về Đà Nẵng, 19:15 kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Son Tra – Marble Mountains – Hoi An","activities":["08:00 Hotel pickup in Da Nang","08:30 Son Tra Peninsula: Linh Ung Pagoda and the 67m Lady Buddha overlooking the bay","10:00 Marble Mountains — elevator up Thuy Son, Huyen Khong Cave, Tam Thai Pagoda","11:45 Non Nuoc stone carving village at the foot of the mountain","12:30 Quang specialty lunch: mi Quang noodles, pork rice-paper rolls","14:00 Hoi An: Japanese Bridge, ancient houses, assembly halls","17:00 Watch the old town light up, free photo time","18:30 Drive back to Da Nang, 19:15 tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"meals":"Ăn trưa mì Quảng, bánh tráng thịt heo"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"meals":"Mi Quang lunch with pork rolls"}'::jsonb,
  'Một ngày gói trọn tam giác vàng của miền Trung: sáng viếng Phật Bà 67m trên bán đảo Sơn Trà, trưa chui động Huyền Không trong lòng Ngũ Hành Sơn, chiều tối thả bước trong phố cổ Hội An khi nghìn đèn lồng thắp sáng. Lịch trình được khách quốc tế chọn nhiều nhất khi chỉ có một ngày ở Đà Nẵng.',
  'One day around the golden triangle of central Vietnam: morning with the 67m Lady Buddha on Son Tra Peninsula, midday inside the mystical Huyen Khong Cave of the Marble Mountains, and evening strolling Hoi An as a thousand lanterns switch on. The most popular one-day combination in Da Nang.',
  'Full-day combo of Son Tra Lady Buddha, Marble Mountains caves and evening Hoi An old town.',
  'Tour 1 ngày Đà Nẵng: chùa Linh Ứng Sơn Trà, Ngũ Hành Sơn động Huyền Không, làng đá Non Nước, phố cổ Hội An lên đèn. Kèm ăn trưa, vé, HDV.',
  '["Thang máy Ngũ Hành Sơn chiều xuống (tự chọn)","Đồ uống ngoài chương trình","Tip cho HDV và tài xế"]'::jsonb,
  '["Marble Mountains elevator on the way down (optional)","Drinks outside the program","Tips for guide and driver"]'::jsonb,
  'Đón tại khách sạn trung tâm Đà Nẵng', '08:00',
  'day_tour', 'moderate', 'vi_en', 'flexible', 'standard',
  '["ngũ hành sơn","sơn trà","hội an","1 ngày"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'ngu-hanh-son-linh-ung-hoi-an-10043');

-- ─────────────────────────────────────────────────────────────
-- 4. Thánh địa Mỹ Sơn nửa ngày
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
  'Đà Nẵng – Thánh Địa Mỹ Sơn Nửa Ngày',
  'My Son Sanctuary Half-Day Tour from Da Nang',
  'my-son-nua-ngay-10044',
  'Đà Nẵng', 'central', 1, 0,
  950000, 75, 24, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1526772662000-3f88f10405ff?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1526772662000-3f88f10405ff?w=800&q=80'],
  ARRAY[
    'Di sản UNESCO — quần thể đền tháp Chăm Pa hơn 1.000 năm tuổi',
    'Kỹ thuật xây gạch không mạch vữa vẫn là bí ẩn khảo cổ',
    'Xem múa Apsara Chăm Pa trong thung lũng thánh địa',
    'Đi sớm tránh nắng và kịp về trước giờ trưa',
    'HDV am hiểu văn hóa Chăm kể chuyện vương quốc biến mất'
  ],
  ARRAY[
    'UNESCO heritage — a Cham temple complex over 1,000 years old',
    'Mortarless brick construction that still puzzles archaeologists',
    'Apsara dance performance inside the sanctuary valley',
    'Early start to beat the heat and return by lunchtime',
    'A guide versed in Cham culture tells the story of the vanished kingdom'
  ],
  '[{"day":1,"title":"Bình minh trong thung lũng thánh địa","activities":["07:30 Xe đón khách tại khách sạn Đà Nẵng, đi Duy Xuyên (45km)","08:45 Đến Mỹ Sơn, xe điện vào thung lũng thánh địa","09:00 Tham quan các cụm tháp B-C-D: đền chính, bia ký Phạn ngữ","Nghe HDV giải mã kỹ thuật gạch Chăm và dấu tích chiến tranh","10:15 Xem biểu diễn múa Apsara và nhạc cụ Chăm truyền thống","11:00 Tự do chụp ảnh cụm tháp trong nắng sớm","11:30 Lên xe về Đà Nẵng","12:45 Về đến khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Morning light in the sanctuary valley","activities":["07:30 Hotel pickup in Da Nang, drive to Duy Xuyen (45km)","08:45 Arrive at My Son, take the electric shuttle into the valley","09:00 Explore temple groups B-C-D: main sanctuaries and Sanskrit steles","Your guide decodes the Cham brick mystery and the scars of war","10:15 Apsara dance show with traditional Cham instruments","11:00 Free photo time among the towers in the morning light","11:30 Drive back to Da Nang","12:45 Drop off at your hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Vé Mỹ Sơn + xe điện"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"My Son ticket and shuttle"}'::jsonb,
  'Trước Angkor Wat, người Chăm đã dựng nên Mỹ Sơn — thánh địa Ấn Độ giáo hơn nghìn năm tuổi nép trong thung lũng xanh. Tour nửa ngày khởi hành sớm để bạn đi giữa những tháp gạch không mạch vữa lúc còn vắng và mát, xem múa Apsara, rồi về lại Đà Nẵng kịp bữa trưa.',
  'Before Angkor Wat, the Cham people raised My Son — a Hindu sanctuary over a thousand years old tucked in a green valley. This half-day tour starts early so you can wander among the mortarless brick towers while it is still cool and quiet, watch an Apsara dance, and be back in Da Nang for lunch.',
  'Half-day trip to the UNESCO My Son Sanctuary with electric shuttle, Apsara dance and a Cham culture guide.',
  'Tour Mỹ Sơn nửa ngày từ Đà Nẵng: thánh địa Chăm UNESCO nghìn năm, múa Apsara, đi sớm tránh nắng, về trước trưa. Trọn gói vé và xe đón.',
  '["Ăn trưa (về trước giờ trưa)","Đồ uống ngoài chương trình","Tip cho HDV và tài xế"]'::jsonb,
  '["Lunch (returns before noon)","Drinks outside the program","Tips for guide and driver"]'::jsonb,
  'Đón tại khách sạn trung tâm Đà Nẵng', '07:30',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["mỹ sơn","chăm pa","unesco","nửa ngày"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'my-son-nua-ngay-10044');

-- ─────────────────────────────────────────────────────────────
-- 5. Rừng dừa Bảy Mẫu — thúng chai & Hội An
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
  'Đà Nẵng – Rừng Dừa Bảy Mẫu: Thúng Chai & Hội An',
  'Cam Thanh Coconut Village Basket Boat and Hoi An Tour',
  'rung-dua-bay-mau-thung-chai-10045',
  'Đà Nẵng', 'central', 1, 0,
  950000, 75, 20, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?w=800&q=80'],
  ARRAY[
    'Ngồi thúng chai — thuyền tròn độc nhất Việt Nam — luồn rạch dừa nước',
    'Màn "lắc thúng" quay tít điêu luyện của ngư dân',
    'Câu cua, quăng chài và làm đồ chơi từ lá dừa',
    'Ăn trưa hải sản bên rừng dừa',
    'Chiều ghé phố cổ Hội An trước khi về Đà Nẵng'
  ],
  ARRAY[
    'Ride a basket boat — Vietnam one-of-a-kind round coracle — through nipa palm creeks',
    'The famous spinning basket performance by local fishermen',
    'Crab fishing, net casting and palm-leaf toy crafting',
    'Seafood lunch beside the coconut forest',
    'Afternoon stop in Hoi An old town before returning'
  ],
  '[{"day":1,"title":"Đà Nẵng – Rừng dừa Cẩm Thanh – Hội An – Đà Nẵng","activities":["08:30 Xe đón khách tại khách sạn Đà Nẵng, đi Cẩm Thanh","09:30 Xuống thúng chai cùng ngư dân — luồn lạch giữa rừng dừa Bảy Mẫu","Trải nghiệm quăng chài, câu cua, làm nhẫn và mũ từ lá dừa","Xem màn lắc thúng quay tít trên nước cùng nhạc sôi động","12:00 Ăn trưa hải sản bên rừng dừa","13:30 Sang phố cổ Hội An: Chùa Cầu, nhà cổ, chợ Hội An","16:00 Lên xe về Đà Nẵng","16:45 Về đến khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Da Nang – Cam Thanh coconut forest – Hoi An – Da Nang","activities":["08:30 Hotel pickup in Da Nang, drive to Cam Thanh","09:30 Board a basket boat with a local fisherman through the Bay Mau coconut forest","Try net casting, crab fishing, and palm-leaf ring and hat crafting","Watch the spinning basket show on the water","12:00 Seafood lunch beside the coconut forest","13:30 Continue to Hoi An old town: Japanese Bridge, ancient houses, market","16:00 Drive back to Da Nang","16:45 Drop off at your hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"boat":"Thúng chai rừng dừa (2 khách/thúng)","meals":"Ăn trưa hải sản"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"boat":"Basket boat (2 guests per boat)","meals":"Seafood lunch"}'::jsonb,
  'Chiếc thúng chai tròn xoay là trải nghiệm khiến khách quốc tế thích thú nhất ở miền Trung: ngư dân chèo bạn luồn qua rạch dừa nước Bảy Mẫu, dạy quăng chài, câu cua, tết nhẫn lá dừa — và trình diễn màn lắc thúng quay tít kinh điển. Trưa ăn hải sản, chiều dạo phố cổ Hội An.',
  'The spinning round basket boat is the experience foreign guests love most in central Vietnam: a fisherman paddles you through the Bay Mau nipa palm creeks, teaches net casting and crab fishing, weaves you a palm-leaf ring — and performs the legendary spinning basket show. Seafood lunch at noon, Hoi An old town in the afternoon.',
  'Day tour with basket boat ride in the coconut forest, fishing activities, seafood lunch and Hoi An old town.',
  'Tour rừng dừa Bảy Mẫu từ Đà Nẵng: thúng chai, lắc thúng, câu cua, quăng chài, ăn trưa hải sản, chiều phố cổ Hội An. Đón tận khách sạn.',
  '["Đồ uống ngoài chương trình","Tip cho HDV, tài xế và người chèo thúng","Chi phí cá nhân khác"]'::jsonb,
  '["Drinks outside the program","Tips for guide, driver and boat paddler","Other personal expenses"]'::jsonb,
  'Đón tại khách sạn trung tâm Đà Nẵng', '08:30',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["thúng chai","rừng dừa","hội an","trải nghiệm"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'rung-dua-bay-mau-thung-chai-10045');

-- ─────────────────────────────────────────────────────────────
-- 6. Cù Lao Chàm — lặn ngắm san hô 1 ngày
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
  'Đà Nẵng – Cù Lao Chàm 1 Ngày: Lặn Ngắm San Hô',
  'Cham Islands Day Trip with Snorkeling from Da Nang',
  'cu-lao-cham-lan-bien-10046',
  'Đà Nẵng', 'central', 1, 0,
  1250000, 75, 20, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&q=80','https://images.unsplash.com/photo-1500375592092-40eb2168fd21?w=800&q=80'],
  ARRAY[
    'Khu dự trữ sinh quyển thế giới với rạn san hô nguyên sơ',
    'Lặn ống thở ngắm san hô tại 2 điểm (kính + ống thở miễn phí)',
    'Cano cao tốc 20 phút từ Cửa Đại ra đảo',
    'Tắm biển Bãi Chồng cát trắng nước xanh ngọc',
    'Ăn trưa hải sản tươi của ngư dân đảo'
  ],
  ARRAY[
    'A UNESCO biosphere reserve with pristine coral reefs',
    'Snorkel two coral spots (mask and snorkel included)',
    'A 20-minute speedboat hop from Cua Dai to the islands',
    'Swim at Bai Chong beach with white sand and jade water',
    'Fresh seafood lunch from the island fishermen'
  ],
  '[{"day":1,"title":"Đà Nẵng – Cù Lao Chàm – Đà Nẵng","activities":["07:30 Xe đón khách tại khách sạn Đà Nẵng, đi cảng Cửa Đại","08:45 Cano cao tốc rời cảng — 20 phút lướt sóng ra đảo","09:15 Dạo làng chài: giếng cổ Chăm, chùa Hải Tạng, chợ hải sản","10:00 Lặn ống thở ngắm san hô tại Bãi Xếp và Hòn Dài","12:00 Ăn trưa hải sản tươi tại nhà hàng ngư dân","13:00 Tự do tắm biển, nằm võng dừa tại Bãi Chồng","14:30 Cano về Cửa Đại","15:30 Xe về Đà Nẵng, 16:15 kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Da Nang – Cham Islands – Da Nang","activities":["07:30 Hotel pickup in Da Nang, drive to Cua Dai port","08:45 Speedboat departure — a 20-minute ride to the islands","09:15 Fishing village walk: ancient Cham well, Hai Tang Pagoda, seafood market","10:00 Snorkeling at Bai Xep and Hon Dai coral spots","12:00 Fresh seafood lunch at a fishermen restaurant","13:00 Free swim and coconut hammocks at Bai Chong beach","14:30 Speedboat back to Cua Dai","15:30 Drive to Da Nang, 16:15 tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"boat":"Cano cao tốc khứ hồi + đồ lặn ống thở","meals":"Ăn trưa hải sản đảo"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":true,"boat":"Round-trip speedboat plus snorkel gear","meals":"Island seafood lunch"}'::jsonb,
  'Cách Hội An chỉ 20 phút cano, Cù Lao Chàm là khu dự trữ sinh quyển thế giới nơi san hô còn nguyên sơ và làng chài vẫn giữ nếp sống trăm năm. Một ngày ở đây: lặn ống thở hai điểm san hô, ăn hải sản ngư dân vừa kéo lên, và thả mình trên bãi Chồng cát trắng. Tour chỉ chạy khi biển đẹp (tháng 3-9).',
  'Twenty speedboat minutes from Hoi An, the Cham Islands form a UNESCO biosphere reserve where the coral is pristine and the fishing village keeps its century-old rhythm. One day here: snorkeling at two coral spots, seafood pulled from the sea that morning, and lazy hours on white-sand Bai Chong. Runs only in fair-sea season (March-September).',
  'Cham Islands day trip with speedboat, two snorkeling spots, fishing village walk and island seafood lunch.',
  'Tour Cù Lao Chàm 1 ngày từ Đà Nẵng: cano cao tốc, lặn ngắm san hô 2 điểm, làng chài, ăn trưa hải sản, tắm Bãi Chồng. Mùa biển đẹp 3-9.',
  '["Ảnh chụp dưới nước (thuê riêng)","Đồ uống ngoài chương trình","Tip cho HDV và thuyền viên","Tour phụ thuộc thời tiết biển — hoàn/đổi lịch khi biển động"]'::jsonb,
  '["Underwater photos (rented separately)","Drinks outside the program","Tips for guide and crew","Weather-dependent — refund or reschedule in rough seas"]'::jsonb,
  'Đón tại khách sạn trung tâm Đà Nẵng', '07:30',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["cù lao chàm","lặn biển","san hô","1 ngày"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'cu-lao-cham-lan-bien-10046');

-- ─────────────────────────────────────────────────────────────
-- 7. Food tour Đà Nẵng xe máy đêm
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
  'Đà Nẵng – Food Tour Xe Máy Đêm & Cầu Rồng Phun Lửa',
  'Da Nang Night Street Food Tour by Motorbike with Dragon Bridge',
  'da-nang-food-tour-xe-may-dem-10047',
  'Đà Nẵng', 'central', 1, 0,
  1050000, 75, 12, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800&q=80'],
  ARRAY[
    '5+ món miền Trung: mì Quảng, bánh xèo, nem lụi, ốc hút, chè xoa xoa',
    'Ngồi sau xe máy cùng rider bản địa dọc hai bờ sông Hàn',
    'Cầu Rồng phun lửa - phun nước (tối thứ 7, CN lúc 21h)',
    'Hải sản vỉa hè kiểu người Đà Nẵng bên bãi Mỹ Khê',
    'Nhóm nhỏ tối đa 12 khách, mỗi khách một xe một rider'
  ],
  ARRAY[
    'Five-plus central dishes: mi Quang, banh xeo, nem lui skewers, snails, che dessert',
    'Ride pillion with local riders along both banks of the Han River',
    'Dragon Bridge fire and water show (9pm Saturday and Sunday)',
    'Sidewalk seafood the Da Nang way near My Khe beach',
    'Small group of max 12, one bike and one rider per guest'
  ],
  '[{"day":1,"title":"Đà Nẵng về đêm trên yên xe máy","activities":["18:00 Rider đón khách bằng xe máy tại khách sạn","Điểm 1: mì Quảng tôm thịt trứng cút quán gia truyền","Điểm 2: bánh xèo miền Trung + nem lụi cuốn rau rừng","Chạy dọc sông Hàn ngắm cầu Rồng, cầu Tình Yêu lên đèn","Điểm 3: ốc hút xào sả ớt + hải sản vỉa hè gần biển Mỹ Khê","Điểm 4: chè xoa xoa hạt lựu Chợ Cồn tráng miệng","21:00 Dừng chân cầu Rồng — xem phun lửa nếu là tối cuối tuần","21:30 Rider đưa khách về khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Da Nang after dark on the back of a motorbike","activities":["18:00 Your rider picks you up by motorbike at your hotel","Stop 1: mi Quang with shrimp, pork and quail egg at a family eatery","Stop 2: central-style banh xeo and nem lui skewers with wild herbs","Cruise the Han riverside past the glowing Dragon and Love bridges","Stop 3: chili-lemongrass snails and sidewalk seafood near My Khe","Stop 4: che dessert with jelly and pomegranate seeds at Con Market","21:00 Dragon Bridge stop — fire show if it is a weekend night","21:30 Ride back to your hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":"Xe máy + nón bảo hiểm, mỗi khách một rider","insurance":true,"meals":"Toàn bộ món ăn và 1 đồ uống mỗi điểm"}'::jsonb,
  '{"guide":true,"transfer":"Motorbike with helmet, one rider per guest","insurance":true,"meals":"All food stops plus one drink per stop"}'::jsonb,
  'Đà Nẵng có bãi biển đẹp ban ngày và bụng đói ban đêm: mì Quảng gia truyền, bánh xèo giòn rụm, nem lụi than hoa, ốc hút cay xé và chè xoa xoa mát lịm — tất cả trên yên xe máy cùng rider bản địa, chạy dọc sông Hàn rực đèn. Đi tối thứ 7 hoặc CN để kịp xem cầu Rồng phun lửa lúc 21h.',
  'Da Nang means beautiful beaches by day and a hungry stomach by night: heritage mi Quang, crackling banh xeo, charcoal nem lui, fiery snails and cooling che dessert — all from the back of a motorbike with a local rider, cruising the lit-up Han riverside. Go on Saturday or Sunday to catch the Dragon Bridge breathing fire at 9pm.',
  'Night motorbike food tour with five-plus central Vietnamese dishes and the Dragon Bridge fire show on weekends.',
  'Food tour xe máy đêm Đà Nẵng: mì Quảng, bánh xèo, nem lụi, ốc hút, chè xoa xoa, cầu Rồng phun lửa cuối tuần. Mỗi khách một rider.',
  '["Đồ uống có cồn ngoài chương trình","Tip cho rider","Chi phí cá nhân khác"]'::jsonb,
  '["Alcoholic drinks beyond the program","Tips for riders","Other personal expenses"]'::jsonb,
  'Đón tại khách sạn trung tâm Đà Nẵng', '18:00',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["food tour","xe máy","về đêm","cầu rồng"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'da-nang-food-tour-xe-may-dem-10047');

-- ─────────────────────────────────────────────────────────────
-- 8. Đèo Hải Vân & Lăng Cô bằng xe jeep nửa ngày
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
  'Đà Nẵng – Đèo Hải Vân & Lăng Cô Bằng Xe Jeep',
  'Hai Van Pass and Lang Co Bay by Army Jeep',
  'deo-hai-van-lang-co-jeep-10048',
  'Đà Nẵng', 'central', 1, 0,
  1450000, 75, 8, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1516426122078-c23e76319801?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1516426122078-c23e76319801?w=800&q=80','https://images.unsplash.com/photo-1540541338287-41700207dee6?w=800&q=80'],
  ARRAY[
    'Ngồi xe jeep mui trần vượt "thiên hạ đệ nhất hùng quan"',
    'Cung đèo ven biển đẹp nhất Việt Nam từng lên Top Gear',
    'Hải Vân Quan — cửa ải trăm năm trên đỉnh đèo',
    'Vịnh Lăng Cô cong như vầng trăng dưới chân đèo',
    'Cà phê view làng chài + ghé bãi biển hoang sơ'
  ],
  ARRAY[
    'Ride an open-top army jeep over the Ocean Cloud Pass',
    'Vietnam most scenic coastal road, made famous by Top Gear',
    'Hai Van Quan — the century-old gate fortress at the summit',
    'Crescent-shaped Lang Co Bay at the foot of the pass',
    'Fishing village viewpoint coffee and a wild beach stop'
  ],
  '[{"day":1,"title":"Cung đèo huyền thoại trên xe jeep mui trần","activities":["08:00 Xe jeep đón khách tại khách sạn Đà Nẵng","08:30 Chạy dọc vịnh Đà Nẵng, ngắm bán đảo Sơn Trà từ xa","09:00 Bắt đầu leo đèo Hải Vân — dừng các khúc cua view biển","09:45 Hải Vân Quan trên đỉnh: cửa ải cổ, lô cốt và toàn cảnh hai đầu đèo","10:30 Đổ đèo phía Bắc xuống vịnh Lăng Cô","11:00 Cà phê view đầm Lập An, dạo làng chài nuôi hàu","11:45 Ghé bãi biển Lăng Cô chụp ảnh","12:15 Jeep quay về Đà Nẵng qua hầm Hải Vân","13:00 Về đến khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"The legendary pass in an open-top jeep","activities":["08:00 Jeep pickup at your Da Nang hotel","08:30 Cruise along Da Nang Bay with Son Tra Peninsula views","09:00 Climb the Hai Van Pass — photo stops at the sea-view bends","09:45 Hai Van Quan at the summit: the old gate, bunkers and views both ways","10:30 Descend the north side to Lang Co Bay","11:00 Coffee overlooking Lap An lagoon and its oyster farms","11:45 Photo stop at Lang Co beach","12:15 Jeep back to Da Nang through the Hai Van tunnel","13:00 Drop off at your hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":"Xe jeep mui trần (tối đa 4 khách/xe)","insurance":true,"meals":"1 cà phê view đầm Lập An"}'::jsonb,
  '{"guide":true,"transfer":"Open-top army jeep (max 4 guests per jeep)","insurance":true,"meals":"One coffee overlooking Lap An lagoon"}'::jsonb,
  'Đèo Hải Vân — "thiên hạ đệ nhất hùng quan" — đẹp nhất khi đi mui trần: gió biển, những khúc cua tay áo và vịnh Lăng Cô cong như vầng trăng hiện dần dưới bánh xe jeep. Nửa ngày: chinh phục đỉnh đèo, thăm cửa ải trăm năm, uống cà phê bên đầm Lập An rồi về lại Đà Nẵng qua hầm xuyên núi.',
  'The Hai Van Pass — the Ocean Cloud Pass — is best experienced topless: sea wind, hairpin bends and crescent Lang Co Bay unfolding beneath the wheels of an army jeep. Half a day: conquer the summit, explore the century-old gate fortress, sip coffee over Lap An lagoon, then roll back to Da Nang through the mountain tunnel.',
  'Half-day open-top jeep ride over the Hai Van Pass with Hai Van Quan fortress, Lang Co Bay and lagoon coffee.',
  'Tour xe jeep đèo Hải Vân từ Đà Nẵng: mui trần vượt đèo, Hải Vân Quan, vịnh Lăng Cô, cà phê đầm Lập An. Nửa ngày, tối đa 4 khách/xe.',
  '["Ăn trưa","Đồ uống ngoài chương trình","Tip cho tài xế jeep"]'::jsonb,
  '["Lunch","Drinks outside the program","Tips for the jeep driver"]'::jsonb,
  'Đón tại khách sạn trung tâm Đà Nẵng', '08:00',
  'day_tour', 'easy', 'vi_en', 'flexible', 'premium',
  '["hải vân","xe jeep","lăng cô","nửa ngày"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'deo-hai-van-lang-co-jeep-10048');

-- ─────────────────────────────────────────────────────────────
-- 9. Cooking class + chợ Hàn
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
  'Đà Nẵng – Lớp Nấu Ăn Miền Trung & Đi Chợ Hàn',
  'Da Nang Cooking Class with Han Market Tour',
  'cooking-class-cho-han-10049',
  'Đà Nẵng', 'central', 1, 0,
  1150000, 75, 10, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1504754524776-8f4f37790ca0?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1504754524776-8f4f37790ca0?w=800&q=80'],
  ARRAY[
    'Đi chợ Hàn trăm tuổi chọn nguyên liệu cùng đầu bếp',
    'Tự tay nấu 3 món miền Trung: mì Quảng, bánh xèo, gỏi cuốn tôm',
    'Bí quyết nước dùng mì Quảng sánh đậm vị củ nén',
    'Thưởng thức thành quả trên sân thượng view sông Hàn',
    'Bộ công thức tiếng Anh + chứng nhận mang về'
  ],
  ARRAY[
    'Shop the century-old Han Market with your chef',
    'Cook 3 central classics yourself: mi Quang, banh xeo, shrimp fresh rolls',
    'The secret of rich mi Quang broth with local shallot oil',
    'Enjoy your dishes on a rooftop overlooking the Han River',
    'English recipe booklet and certificate to take home'
  ],
  '[{"day":1,"title":"Từ sạp chợ Hàn đến sân thượng sông Hàn","activities":["08:30 Gặp đầu bếp tại cổng chợ Hàn","Dạo chợ 45 phút: chọn tôm tươi, bánh tráng, rau húng và nghệ tươi","09:30 Về lớp học trên sân thượng nhìn ra sông Hàn","Bài 1: cuốn gỏi cuốn tôm và pha nước chấm đậu phộng","Bài 2: đổ bánh xèo miền Trung nhân tôm giá","Bài 3: nấu mì Quảng — nước lèo củ nén, đậu phộng, bánh tráng nướng","12:00 Thưởng thức bữa trưa tự nấu với view sông","13:00 Nhận công thức + chứng nhận, kết thúc chương trình"]}]'::jsonb,
  '[{"day":1,"title":"From Han Market stalls to a riverside rooftop","activities":["08:30 Meet your chef at the Han Market gate","45-minute market walk: fresh shrimp, rice paper, herbs and turmeric","09:30 Up to the rooftop kitchen overlooking the Han River","Lesson 1: roll shrimp fresh rolls and mix the peanut dipping sauce","Lesson 2: fry a central-style banh xeo with shrimp and bean sprouts","Lesson 3: cook mi Quang — shallot-oil broth, peanuts, toasted rice crackers","12:00 Enjoy the lunch you cooked with river views","13:00 Receive recipes and certificate, program ends"]}]'::jsonb,
  '{"guide":true,"insurance":true,"activities":"Lớp nấu 3 món + đi chợ cùng đầu bếp","meals":"Thưởng thức toàn bộ món tự nấu"}'::jsonb,
  '{"guide":true,"insurance":true,"activities":"3-dish class plus market tour with the chef","meals":"All dishes you cook"}'::jsonb,
  'Món miền Trung đậm và thẳng thắn như chính người Đà Nẵng — và mì Quảng là linh hồn của nó. Từ sạp chợ Hàn trăm tuổi đến gian bếp sân thượng nhìn ra sông Hàn, đầu bếp song ngữ sẽ chỉ bạn từng bí quyết: nước lèo củ nén, bánh xèo giòn cạnh, cuốn gỏi chặt tay. Ăn trưa bằng chính thành quả của mình.',
  'Central Vietnamese food is bold and direct, just like Da Nang itself — and mi Quang is its soul. From the century-old Han Market stalls to a rooftop kitchen above the Han River, a bilingual chef walks you through every secret: shallot-oil broth, crisp-edged banh xeo, tightly rolled fresh rolls. Lunch is whatever you just cooked.',
  'Hands-on Da Nang cooking class with Han Market tour, three central dishes and rooftop river views.',
  'Lớp nấu ăn Đà Nẵng: đi chợ Hàn cùng đầu bếp, tự nấu mì Quảng, bánh xèo, gỏi cuốn trên sân thượng view sông Hàn. Nhóm nhỏ 10 khách.',
  '["Đưa đón khách sạn (điểm hẹn tại chợ Hàn)","Đồ uống ngoài chương trình","Tip cho đầu bếp"]'::jsonb,
  '["Hotel transfer (meeting point at Han Market)","Drinks outside the program","Tips for the chef"]'::jsonb,
  'Cổng chính chợ Hàn, đường Trần Phú', '08:30',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["cooking class","mì quảng","chợ hàn","trải nghiệm"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'cooking-class-cho-han-10049');

-- ─────────────────────────────────────────────────────────────
-- 10. Huế 1 ngày từ Đà Nẵng
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
  'Đà Nẵng – Huế 1 Ngày: Đại Nội, Lăng Khải Định & Sông Hương',
  'Hue Day Trip from Da Nang: Imperial City, Royal Tomb and Perfume River',
  'hue-1-ngay-tu-da-nang-10050',
  'Đà Nẵng', 'central', 1, 0,
  1550000, 75, 24, 2, 'ACTIVE',
  'https://images.unsplash.com/photo-1544644181-1484b3fdfc62?w=800&q=80',
  ARRAY['https://images.unsplash.com/photo-1544644181-1484b3fdfc62?w=800&q=80'],
  ARRAY[
    'Đại Nội Huế — Tử Cấm Thành của 13 đời vua Nguyễn (UNESCO)',
    'Lăng Khải Định — lăng mộ khảm sành sứ lộng lẫy nhất triều Nguyễn',
    'Chùa Thiên Mụ 7 tầng soi bóng sông Hương',
    'Thuyền rồng xuôi sông Hương êm đềm',
    'Vượt đèo Hải Vân chiều đi — ngắm vịnh Lăng Cô từ trên cao'
  ],
  ARRAY[
    'The Hue Imperial City — Forbidden City of 13 Nguyen emperors (UNESCO)',
    'Khai Dinh Tomb — the most ornate porcelain-mosaic mausoleum of the dynasty',
    'The seven-story Thien Mu Pagoda mirrored in the Perfume River',
    'A gentle dragon boat cruise on the Perfume River',
    'Cross the Hai Van Pass on the way up with Lang Co Bay views'
  ],
  '[{"day":1,"title":"Đà Nẵng – Huế – Đà Nẵng","activities":["07:00 Xe đón khách tại khách sạn Đà Nẵng, vượt đèo Hải Vân","08:00 Dừng đỉnh đèo ngắm vịnh Lăng Cô, chụp ảnh Hải Vân Quan","09:30 Lăng Khải Định — kiệt tác khảm sành sứ trên sườn núi","11:00 Đại Nội: Ngọ Môn, điện Thái Hòa, Tử Cấm Thành, Thế Miếu","12:30 Ăn trưa món Huế: bún bò, bánh khoái, nem lụi","14:00 Chùa Thiên Mụ — tháp Phước Duyên 7 tầng bên sông","15:00 Thuyền rồng xuôi sông Hương về bến Tòa Khâm","16:00 Xe về Đà Nẵng qua hầm Hải Vân","18:00 Về đến khách sạn, kết thúc tour"]}]'::jsonb,
  '[{"day":1,"title":"Da Nang – Hue – Da Nang","activities":["07:00 Hotel pickup in Da Nang, drive over the Hai Van Pass","08:00 Summit stop for Lang Co Bay views and Hai Van Quan photos","09:30 Khai Dinh Tomb — a porcelain-mosaic masterpiece on the hillside","11:00 Imperial City: Noon Gate, Thai Hoa Palace, Forbidden City, royal shrines","12:30 Hue specialty lunch: bun bo, banh khoai pancake, nem lui","14:00 Thien Mu Pagoda with its seven-story tower over the river","15:00 Dragon boat cruise down the Perfume River","16:00 Drive back to Da Nang through the Hai Van tunnel","18:00 Drop off at your hotel, tour ends"]}]'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Vé Đại Nội + lăng Khải Định","boat":"Thuyền rồng sông Hương","meals":"Ăn trưa món Huế"}'::jsonb,
  '{"guide":true,"transfer":true,"insurance":true,"entrance_fees":"Imperial City and Khai Dinh tickets","boat":"Perfume River dragon boat","meals":"Hue specialty lunch"}'::jsonb,
  'Cố đô Huế cách Đà Nẵng chỉ một con đèo — và con đèo ấy lại chính là Hải Vân hùng vĩ. Một ngày trọn vẹn: sáng vượt đèo ngắm Lăng Cô, thăm lăng Khải Định khảm sành sứ và Đại Nội của 13 đời vua Nguyễn, trưa ăn bún bò chính gốc, chiều lên thuyền rồng xuôi sông Hương qua chùa Thiên Mụ.',
  'The imperial city of Hue sits just one mountain pass from Da Nang — and that pass happens to be the mighty Hai Van. One full day: cross the pass with Lang Co views, explore the porcelain-mosaic Khai Dinh Tomb and the Imperial City of 13 Nguyen emperors, lunch on authentic bun bo, then drift down the Perfume River past Thien Mu Pagoda on a dragon boat.',
  'Full-day Hue trip from Da Nang with the Imperial City, Khai Dinh Tomb, Thien Mu Pagoda and a Perfume River dragon boat.',
  'Tour Huế 1 ngày từ Đà Nẵng: vượt đèo Hải Vân, Đại Nội, lăng Khải Định, chùa Thiên Mụ, thuyền rồng sông Hương, ăn trưa bún bò. Trọn gói vé.',
  '["Đồ uống ngoài chương trình","Tip cho HDV, tài xế và lái thuyền","Chi phí cá nhân khác"]'::jsonb,
  '["Drinks outside the program","Tips for guide, driver and boatman","Other personal expenses"]'::jsonb,
  'Đón tại khách sạn trung tâm Đà Nẵng', '07:00',
  'day_tour', 'easy', 'vi_en', 'flexible', 'standard',
  '["huế","đại nội","sông hương","1 ngày"]'::jsonb,
  'auto'
where not exists (select 1 from public.tours where slug = 'hue-1-ngay-tu-da-nang-10050');

-- ─────────────────────────────────────────────────────────────
-- Tạo lịch khởi hành ngay (không cần chờ cron đêm)
-- ─────────────────────────────────────────────────────────────
select public.extend_day_tour_schedules();

-- Kiểm tra: 10 tour Đà Nẵng ACTIVE, mỗi tour 60 lịch
select t.slug, t.base_price, count(s.id) as so_lich, min(s.depart_date) as ngay_dau
from public.tours t
left join public.tour_schedules s on s.tour_id = t.id and s.depart_date > current_date
where t.destination = 'Đà Nẵng'
group by t.slug, t.base_price
order by t.slug;
