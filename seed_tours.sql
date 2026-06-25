-- ═══════════════════════════════════════════════════════════════════
-- BAGGIO TRAVEL — SEED 1000 TOURS
-- Dán vào: Supabase Dashboard → SQL Editor → Chạy (F5)
-- https://supabase.com/dashboard/project/lfnlezfphwjtdunyungi/sql/new
-- ═══════════════════════════════════════════════════════════════════

DO $$
DECLARE
  -- [tên điểm đến, vùng, slug, unsplash photo id]
  dests TEXT[][] := ARRAY[
    -- MIỀN BẮC
    ARRAY['Hà Nội',        'north', 'ha-noi',        'photo-1555921015-5532091f6026'],
    ARRAY['Hạ Long',       'north', 'ha-long',        'photo-1528360983277-13d401cdc186'],
    ARRAY['Sa Pa',         'north', 'sa-pa',          'photo-1506905925346-21bda4d32df4'],
    ARRAY['Ninh Bình',     'north', 'ninh-binh',      'photo-1570197788417-0e82375c9371'],
    ARRAY['Hà Giang',      'north', 'ha-giang',       'photo-1507034589631-9433cc6bc453'],
    ARRAY['Cao Bằng',      'north', 'cao-bang',       'photo-1528360983277-13d401cdc186'],
    ARRAY['Mộc Châu',      'north', 'moc-chau',       'photo-1506905925346-21bda4d32df4'],
    ARRAY['Mai Châu',      'north', 'mai-chau',       'photo-1506905925346-21bda4d32df4'],
    ARRAY['Cát Bà',        'north', 'cat-ba',         'photo-1528360983277-13d401cdc186'],
    ARRAY['Điện Biên',     'north', 'dien-bien',      'photo-1506905925346-21bda4d32df4'],
    ARRAY['Đồng Văn',      'north', 'dong-van',       'photo-1507034589631-9433cc6bc453'],
    ARRAY['Mù Cang Chải',  'north', 'mu-cang-chai',   'photo-1506905925346-21bda4d32df4'],
    -- MIỀN TRUNG
    ARRAY['Đà Nẵng',       'central', 'da-nang',        'photo-1583417319070-4a69db38a482'],
    ARRAY['Hội An',        'central', 'hoi-an',         'photo-1559592413-7cec4d0cae2b'],
    ARRAY['Huế',           'central', 'hue',            'photo-1621618358625-eb0d0e79c93f'],
    ARRAY['Nha Trang',     'central', 'nha-trang',      'photo-1559827260-dc66d52bef19'],
    ARRAY['Đà Lạt',        'central', 'da-lat',         'photo-1609602853490-36b2a95c50f9'],
    ARRAY['Mũi Né',        'central', 'mui-ne',         'photo-1584916201218-f4242ceb4809'],
    ARRAY['Phan Thiết',    'central', 'phan-thiet',     'photo-1584916201218-f4242ceb4809'],
    ARRAY['Quy Nhơn',      'central', 'quy-nhon',       'photo-1559827260-dc66d52bef19'],
    ARRAY['Phú Yên',       'central', 'phu-yen',        'photo-1559827260-dc66d52bef19'],
    ARRAY['Phong Nha',     'central', 'phong-nha',      'photo-1575311373937-040b8e1fd5b6'],
    ARRAY['Buôn Ma Thuột', 'central', 'buon-ma-thuot',  'photo-1587829741301-dc798b83add3'],
    ARRAY['Kon Tum',       'central', 'kon-tum',        'photo-1506905925346-21bda4d32df4'],
    ARRAY['Lý Sơn',        'central', 'ly-son',         'photo-1559827260-dc66d52bef19'],
    -- MIỀN NAM
    ARRAY['Hồ Chí Minh',  'south', 'ho-chi-minh',    'photo-1583417319070-4a69db38a482'],
    ARRAY['Phú Quốc',      'south', 'phu-quoc',       'photo-1512100356356-de1b841402bc'],
    ARRAY['Vũng Tàu',      'south', 'vung-tau',       'photo-1559827260-dc66d52bef19'],
    ARRAY['Cần Thơ',       'south', 'can-tho',        'photo-1572985025058-87efb85f3d6a'],
    ARRAY['Côn Đảo',       'south', 'con-dao',        'photo-1512100356356-de1b841402bc'],
    ARRAY['Châu Đốc',      'south', 'chau-doc',       'photo-1572985025058-87efb85f3d6a'],
    ARRAY['Mỹ Tho',        'south', 'my-tho',         'photo-1572985025058-87efb85f3d6a'],
    ARRAY['Cà Mau',        'south', 'ca-mau',         'photo-1572985025058-87efb85f3d6a']
  ];

  -- [tên loại tour, travel style, mô tả ngắn]
  types TEXT[][] := ARRAY[
    ARRAY['Khám Phá',            'adventure',  'Trải nghiệm những điều độc đáo, thú vị nhất'],
    ARRAY['Nghỉ Dưỡng Cao Cấp',  'wellness',   'Thư giãn tuyệt đối, tái tạo năng lượng'],
    ARRAY['Văn Hóa & Lịch Sử',   'culture',    'Tìm hiểu chiều sâu văn hóa, lịch sử địa phương'],
    ARRAY['Ẩm Thực Đường Phố',   'food',       'Trải nghiệm hương vị đặc trưng của vùng đất'],
    ARRAY['Biển & Đảo Xanh',     'beach',      'Tận hưởng biển trong xanh, cát trắng mịn màng'],
    ARRAY['Trekking & Bản Làng', 'mountain',   'Chinh phục núi rừng, giao lưu văn hóa dân tộc'],
    ARRAY['Tour Gia Đình',       'family',     'Phù hợp cho cả gia đình, an toàn và vui vẻ'],
    ARRAY['Tuần Trăng Mật',      'couple',     'Lãng mạn, riêng tư — dành cho cặp đôi'],
    ARRAY['Mạo Hiểm & Kayak',    'adventure',  'Canoeing, hang động, leo núi — dành cho người yêu thể thao'],
    ARRAY['Du Thuyền Hạng Sang', 'wellness',   'Trải nghiệm xa xỉ trên du thuyền 5 sao']
  ];

  -- Các mức ngày phổ biến (phân bố trọng số thực tế)
  durs INT[] := ARRAY[1,1,2,2,2,3,3,3,3,4,4,5,5,6,7,7,8,10,14];

  -- Template hoạt động theo loại ngày
  act_morning TEXT[] := ARRAY[
    'Xe đưa đón tận nơi, khởi hành sớm đến điểm tham quan đầu tiên',
    'Tập kết điểm hẹn, HDV phổ biến lịch trình — lên đường khám phá',
    'Check-in khách sạn sớm, ăn sáng buffet, chuẩn bị hành trình',
    'Đón tại sân bay / ga tàu, nhận phòng khách sạn, nghỉ ngơi',
    'Ăn sáng sớm, đi chợ sáng địa phương — bắt đầu ngày mới'
  ];
  act_day TEXT[] := ARRAY[
    'Tham quan các địa điểm nổi tiếng nhất — chụp ảnh lưu niệm',
    'Trải nghiệm hoạt động đặc sắc của vùng đất: chèo thuyền, leo núi, lặn biển',
    'Ăn trưa nhà hàng địa phương — thưởng thức đặc sản vùng miền',
    'Tham gia workshop: học nấu ăn địa phương, làm nghề thủ công truyền thống',
    'Dạo chợ địa phương, giao lưu với người dân bản địa',
    'Tham quan bảo tàng, di tích lịch sử — nghe thuyết minh chuyên sâu',
    'Tắm biển / hồ bơi khách sạn, thư giãn buổi chiều',
    'Ngắm hoàng hôn tại điểm view đẹp nhất vùng',
    'Đi thuyền / ca nô khám phá vùng nước xung quanh',
    'Trekking nhẹ đến điểm nhìn toàn cảnh, chụp ảnh toàn cảnh'
  ];
  act_evening TEXT[] := ARRAY[
    'Nhận phòng khách sạn, tự do khám phá buổi tối — phố đêm, bar, ẩm thực vỉa hè',
    'Ăn tối nhà hàng đặc sản địa phương, nghỉ ngơi tại khách sạn',
    'Xem show văn hóa / ca nhạc địa phương buổi tối',
    'Spa & Massage thư giãn, chuẩn bị cho ngày hôm sau',
    'Tự do mua sắm đặc sản, lưu niệm — nghỉ tại khách sạn'
  ];
  act_last TEXT[] := ARRAY[
    'Ăn sáng, trả phòng khách sạn — HDV đưa ra sân bay / ga, kết thúc tour',
    'Tự do buổi sáng mua sắm thêm, xe đưa về điểm xuất phát — về nhà an toàn',
    'Tiệc chia tay, giao lưu cùng đoàn — HDV tiễn về điểm hẹn, kết thúc hành trình'
  ];

  i INT; j INT; cnt INT := 0; skipped INT := 0;
  d_idx INT; t_idx INT; dur_idx INT; dur INT; nts INT;
  dest TEXT; rgn TEXT; sl TEXT; img TEXT;
  typ TEXT; style TEXT; typ_desc TEXT;
  tour_name TEXT; slug TEXT; price NUMERIC;
  star_level TEXT; has_flight BOOL;
  inc JSONB; itin JSONB; day_obj JSONB; day_acts TEXT[];
  day_title TEXT; hi TEXT[];
BEGIN
  FOR i IN 1..1000 LOOP
    d_idx   := ((i - 1) % array_length(dests, 1)) + 1;
    t_idx   := ((i - 1) % array_length(types, 1)) + 1;
    dur_idx := ((i - 1) % array_length(durs,  1)) + 1;
    dur     := durs[dur_idx];
    nts     := GREATEST(dur - 1, 0);

    dest     := dests[d_idx][1];
    rgn      := dests[d_idx][2];
    sl       := dests[d_idx][3];
    img      := 'https://images.unsplash.com/' || dests[d_idx][4] || '?w=800&q=80';
    typ      := types[t_idx][1];
    style    := types[t_idx][2];
    typ_desc := types[t_idx][3];

    -- Tên tour thực tế (đa dạng hóa bằng suffix)
    tour_name := CASE (i % 5)
      WHEN 0 THEN 'Tour ' || dest || ' ' || dur || 'N' || nts || 'Đ – ' || typ
      WHEN 1 THEN dest || ' ' || dur || ' Ngày – ' || typ || ' Trọn Gói'
      WHEN 2 THEN 'Khám Phá ' || dest || ' ' || dur || 'N – Tour ' || typ
      WHEN 3 THEN dest || ': ' || typ || ' ' || dur || 'N' || nts || 'Đ'
      ELSE      '[HOT] Tour ' || dest || ' ' || dur || 'N' || nts || 'Đ – ' || typ
    END;
    slug := sl || '-' || dur || 'n' || nts || 'd-' || i;

    -- Giá thực tế theo số ngày + hạng sao
    price := CASE
      WHEN dur = 1  THEN round((150000  + floor(random() * 650000))  / 50000)  * 50000
      WHEN dur = 2  THEN round((900000  + floor(random() * 1600000)) / 100000) * 100000
      WHEN dur = 3  THEN round((2000000 + floor(random() * 4000000)) / 200000) * 200000
      WHEN dur <= 5 THEN round((4000000 + floor(random() * 8000000)) / 500000) * 500000
      WHEN dur <= 7 THEN round((6000000 + floor(random() * 12000000))/ 500000) * 500000
      WHEN dur <= 10 THEN round((10000000+ floor(random()*15000000)) / 1000000)* 1000000
      ELSE           round((18000000 + floor(random() * 22000000))   / 1000000)* 1000000
    END;

    -- Hạng sao khách sạn theo giá
    star_level := CASE
      WHEN dur <= 1   THEN NULL
      WHEN price > 10000000 THEN '5-star'
      WHEN price > 5000000  THEN '4-star'
      ELSE                       '3-star'
    END;

    -- Bay khi đủ xa / đủ ngày
    has_flight := dur >= 6 OR (rgn = 'north' AND dur >= 5) OR (rgn = 'central' AND dur >= 5);

    -- Dịch vụ bao gồm
    inc := jsonb_strip_nulls(jsonb_build_object(
      'guide',    true,
      'transfer', true,
      'hotel',    star_level,
      'flights',  CASE WHEN has_flight THEN true ELSE NULL END,
      'meals',    CASE
        WHEN dur = 1 THEN ARRAY['Trưa']
        WHEN dur <= 3 THEN ARRAY['Sáng', 'Trưa']
        ELSE ARRAY['Sáng', 'Trưa', 'Tối']
      END
    ));

    -- Lịch trình từng ngày
    itin := '[]'::jsonb;
    FOR j IN 1..dur LOOP
      day_title := CASE
        WHEN j = 1 AND dur = 1 THEN 'Khám phá ' || dest || ' trong ngày'
        WHEN j = 1             THEN 'Ngày 1 – Khởi hành đến ' || dest
        WHEN j = dur           THEN 'Ngày ' || j || ' – Tham quan & Về nhà'
        ELSE                        'Ngày ' || j || ' – Khám phá ' || dest
      END;

      day_acts := ARRAY[
        act_morning[((i + j) % array_length(act_morning, 1)) + 1],
        act_day    [((i + j) % array_length(act_day,     1)) + 1],
        act_day    [((i + j + 3) % array_length(act_day, 1)) + 1],
        CASE WHEN j < dur
          THEN act_evening[((i + j) % array_length(act_evening, 1)) + 1]
          ELSE act_last   [((i + j) % array_length(act_last,    1)) + 1]
        END
      ];

      day_obj := jsonb_build_object(
        'day',        j,
        'title',      day_title,
        'activities', to_jsonb(day_acts)
      );
      itin := itin || jsonb_build_array(day_obj);
    END LOOP;

    -- Điểm nổi bật
    hi := ARRAY[
      'HDV địa phương nhiệt tình, am hiểu văn hóa vùng đất',
      CASE WHEN star_level IS NOT NULL
        THEN 'Khách sạn ' || star_level || ' tiêu chuẩn quốc tế'
        ELSE 'Phương tiện di chuyển thoải mái, an toàn'
      END,
      typ_desc,
      'Giá trọn gói – không phát sinh thêm chi phí'
    ];

    BEGIN
      INSERT INTO tours (
        name_vi, slug, destination, region,
        duration_days, duration_nights, base_price,
        max_pax, min_pax, status,
        includes_vi, itinerary_vi, highlights_vi,
        cover_image, travel_styles, tags
      ) VALUES (
        tour_name, slug, dest, rgn,
        dur, nts, price,
        20, 2, 'ACTIVE',
        inc, itin, hi,
        img,
        ARRAY[style]::text[],
        ARRAY[sl, rgn, style]::text[]
      );
      cnt := cnt + 1;
    EXCEPTION WHEN unique_violation THEN
      skipped := skipped + 1;
    END;
  END LOOP;

  RAISE NOTICE '✅ Hoàn thành: đã tạo % tours | bỏ qua % (slug trùng)', cnt, skipped;
END;
$$;


-- ═══════════════════════════════════════════════════════════════════
-- BƯỚC 2: SEED LỊCH KHỞI HÀNH cho tất cả ACTIVE tours
-- Mỗi tour tạo 6 lịch trong 12 tháng tới — hiện badge "Còn X chỗ"
-- Chạy NGAY SAU bước 1 ở trên
-- ═══════════════════════════════════════════════════════════════════

DO $$
DECLARE
  rec           RECORD;
  base_date     DATE;
  depart        DATE;
  ret           DATE;
  slots         INT;
  avail         INT;
  sched_status  TEXT;
  cnt           INT := 0;
  -- Tạo 6 lịch mỗi tour, cách nhau ~7-14 ngày
  offsets INT[] := ARRAY[7, 21, 35, 56, 84, 120];
  o INT;
BEGIN
  base_date := CURRENT_DATE;

  FOR rec IN
    SELECT id, duration_days, base_price
    FROM tours
    WHERE status = 'ACTIVE'
  LOOP
    FOREACH o IN ARRAY offsets LOOP
      depart := base_date + o;
      ret    := depart + rec.duration_days - 1;
      slots  := 10 + (random() * 20)::INT;   -- 10–30 chỗ
      avail  := (slots * (0.3 + random() * 0.7))::INT; -- 30–100% còn trống

      sched_status := CASE
        WHEN avail = 0 THEN 'FULL'
        ELSE 'OPEN'
      END;

      INSERT INTO tour_schedules (
        tour_id, depart_date, return_date,
        total_slots, available_slots,
        price_override, status
      ) VALUES (
        rec.id, depart, ret,
        slots, avail,
        NULL,  -- dùng base_price của tour
        sched_status
      )
      ON CONFLICT DO NOTHING;

      cnt := cnt + 1;
    END LOOP;
  END LOOP;

  RAISE NOTICE '✅ Đã tạo % lịch khởi hành', cnt;
END;
$$;
