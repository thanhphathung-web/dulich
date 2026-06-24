-- Cập nhật ảnh xoay vòng theo thứ tự tour trong tỉnh
-- Mỗi tỉnh có 3 ảnh khác nhau, xoay theo row_number

-- Tạo function xoay vòng ảnh
WITH ranked AS (
  SELECT id, destination,
    ROW_NUMBER() OVER (PARTITION BY destination ORDER BY created_at) AS rn
  FROM tours
  WHERE status = 'ACTIVE'
)
UPDATE tours t SET cover_image = CASE
  -- Miền Bắc
  WHEN r.destination = 'Hà Nội' AND r.rn % 3 = 1 THEN 'https://images.unsplash.com/photo-1555400038-63f5ba517a47?w=800&q=80'
  WHEN r.destination = 'Hà Nội' AND r.rn % 3 = 2 THEN 'https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80'
  WHEN r.destination = 'Hà Nội' AND r.rn % 3 = 0 THEN 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80'

  WHEN r.destination = 'Quảng Ninh' AND r.rn % 3 = 1 THEN 'https://images.unsplash.com/photo-1557400128-9a431afe5ff5?w=800&q=80'
  WHEN r.destination = 'Quảng Ninh' AND r.rn % 3 = 2 THEN 'https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80'
  WHEN r.destination = 'Quảng Ninh' AND r.rn % 3 = 0 THEN 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80'

  WHEN r.destination = 'Lào Cai' AND r.rn % 3 = 1 THEN 'https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=800&q=80'
  WHEN r.destination = 'Lào Cai' AND r.rn % 3 = 2 THEN 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80'
  WHEN r.destination = 'Lào Cai' AND r.rn % 3 = 0 THEN 'https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80'

  WHEN r.destination = 'Hà Giang' AND r.rn % 3 = 1 THEN 'https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=800&q=80'
  WHEN r.destination = 'Hà Giang' AND r.rn % 3 = 2 THEN 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80'
  WHEN r.destination = 'Hà Giang' AND r.rn % 3 = 0 THEN 'https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=800&q=80'

  WHEN r.destination = 'Ninh Bình' AND r.rn % 3 = 1 THEN 'https://images.unsplash.com/photo-1555400038-63f5ba517a47?w=800&q=80'
  WHEN r.destination = 'Ninh Bình' AND r.rn % 3 = 2 THEN 'https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80'
  WHEN r.destination = 'Ninh Bình' AND r.rn % 3 = 0 THEN 'https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80'

  WHEN r.destination = 'Hải Phòng' AND r.rn % 3 = 1 THEN 'https://images.unsplash.com/photo-1557400128-9a431afe5ff5?w=800&q=80'
  WHEN r.destination = 'Hải Phòng' AND r.rn % 3 = 2 THEN 'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=800&q=80'
  WHEN r.destination = 'Hải Phòng' AND r.rn % 3 = 0 THEN 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80'

  WHEN r.destination = 'Hòa Bình' AND r.rn % 3 = 1 THEN 'https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=800&q=80'
  WHEN r.destination = 'Hòa Bình' AND r.rn % 3 = 2 THEN 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80'
  WHEN r.destination = 'Hòa Bình' AND r.rn % 3 = 0 THEN 'https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80'

  WHEN r.destination = 'Cao Bằng' AND r.rn % 3 = 1 THEN 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80'
  WHEN r.destination = 'Cao Bằng' AND r.rn % 3 = 2 THEN 'https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=800&q=80'
  WHEN r.destination = 'Cao Bằng' AND r.rn % 3 = 0 THEN 'https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80'

  WHEN r.destination = 'Điện Biên' AND r.rn % 3 = 1 THEN 'https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=800&q=80'
  WHEN r.destination = 'Điện Biên' AND r.rn % 3 = 2 THEN 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80'
  WHEN r.destination = 'Điện Biên' AND r.rn % 3 = 0 THEN 'https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80'

  WHEN r.destination = 'Sơn La' AND r.rn % 3 = 1 THEN 'https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=800&q=80'
  WHEN r.destination = 'Sơn La' AND r.rn % 3 = 2 THEN 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80'
  WHEN r.destination = 'Sơn La' AND r.rn % 3 = 0 THEN 'https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=800&q=80'

  WHEN r.destination = 'Yên Bái' AND r.rn % 3 = 1 THEN 'https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=800&q=80'
  WHEN r.destination = 'Yên Bái' AND r.rn % 3 = 2 THEN 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80'
  WHEN r.destination = 'Yên Bái' AND r.rn % 3 = 0 THEN 'https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80'

  -- Miền Trung
  WHEN r.destination = 'Đà Nẵng' AND r.rn % 3 = 1 THEN 'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=800&q=80'
  WHEN r.destination = 'Đà Nẵng' AND r.rn % 3 = 2 THEN 'https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80'
  WHEN r.destination = 'Đà Nẵng' AND r.rn % 3 = 0 THEN 'https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=800&q=80'

  WHEN r.destination = 'Khánh Hòa' AND r.rn % 3 = 1 THEN 'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=800&q=80'
  WHEN r.destination = 'Khánh Hòa' AND r.rn % 3 = 2 THEN 'https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=800&q=80'
  WHEN r.destination = 'Khánh Hòa' AND r.rn % 3 = 0 THEN 'https://images.unsplash.com/photo-1557400128-9a431afe5ff5?w=800&q=80'

  WHEN r.destination = 'Lâm Đồng' AND r.rn % 3 = 1 THEN 'https://images.unsplash.com/photo-1555400038-63f5ba517a47?w=800&q=80'
  WHEN r.destination = 'Lâm Đồng' AND r.rn % 3 = 2 THEN 'https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80'
  WHEN r.destination = 'Lâm Đồng' AND r.rn % 3 = 0 THEN 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80'

  WHEN r.destination = 'Thừa Thiên Huế' AND r.rn % 3 = 1 THEN 'https://images.unsplash.com/photo-1555400038-63f5ba517a47?w=800&q=80'
  WHEN r.destination = 'Thừa Thiên Huế' AND r.rn % 3 = 2 THEN 'https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80'
  WHEN r.destination = 'Thừa Thiên Huế' AND r.rn % 3 = 0 THEN 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80'

  WHEN r.destination = 'Quảng Nam' AND r.rn % 3 = 1 THEN 'https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80'
  WHEN r.destination = 'Quảng Nam' AND r.rn % 3 = 2 THEN 'https://images.unsplash.com/photo-1555400038-63f5ba517a47?w=800&q=80'
  WHEN r.destination = 'Quảng Nam' AND r.rn % 3 = 0 THEN 'https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80'

  WHEN r.destination = 'Bình Định' AND r.rn % 3 = 1 THEN 'https://images.unsplash.com/photo-1557400128-9a431afe5ff5?w=800&q=80'
  WHEN r.destination = 'Bình Định' AND r.rn % 3 = 2 THEN 'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=800&q=80'
  WHEN r.destination = 'Bình Định' AND r.rn % 3 = 0 THEN 'https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=800&q=80'

  WHEN r.destination = 'Phú Yên' AND r.rn % 3 = 1 THEN 'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=800&q=80'
  WHEN r.destination = 'Phú Yên' AND r.rn % 3 = 2 THEN 'https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=800&q=80'
  WHEN r.destination = 'Phú Yên' AND r.rn % 3 = 0 THEN 'https://images.unsplash.com/photo-1557400128-9a431afe5ff5?w=800&q=80'

  WHEN r.destination = 'Ninh Thuận' AND r.rn % 3 = 1 THEN 'https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=800&q=80'
  WHEN r.destination = 'Ninh Thuận' AND r.rn % 3 = 2 THEN 'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=800&q=80'
  WHEN r.destination = 'Ninh Thuận' AND r.rn % 3 = 0 THEN 'https://images.unsplash.com/photo-1557400128-9a431afe5ff5?w=800&q=80'

  WHEN r.destination = 'Bình Thuận' AND r.rn % 3 = 1 THEN 'https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=800&q=80'
  WHEN r.destination = 'Bình Thuận' AND r.rn % 3 = 2 THEN 'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=800&q=80'
  WHEN r.destination = 'Bình Thuận' AND r.rn % 3 = 0 THEN 'https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=800&q=80'

  WHEN r.destination = 'Quảng Bình' AND r.rn % 3 = 1 THEN 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80'
  WHEN r.destination = 'Quảng Bình' AND r.rn % 3 = 2 THEN 'https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80'
  WHEN r.destination = 'Quảng Bình' AND r.rn % 3 = 0 THEN 'https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=800&q=80'

  WHEN r.destination = 'Đắk Lắk' AND r.rn % 3 = 1 THEN 'https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80'
  WHEN r.destination = 'Đắk Lắk' AND r.rn % 3 = 2 THEN 'https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=800&q=80'
  WHEN r.destination = 'Đắk Lắk' AND r.rn % 3 = 0 THEN 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80'

  WHEN r.destination = 'Gia Lai' AND r.rn % 3 = 1 THEN 'https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80'
  WHEN r.destination = 'Gia Lai' AND r.rn % 3 = 2 THEN 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80'
  WHEN r.destination = 'Gia Lai' AND r.rn % 3 = 0 THEN 'https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=800&q=80'

  -- Miền Nam
  WHEN r.destination = 'Hồ Chí Minh' AND r.rn % 3 = 1 THEN 'https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=800&q=80'
  WHEN r.destination = 'Hồ Chí Minh' AND r.rn % 3 = 2 THEN 'https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80'
  WHEN r.destination = 'Hồ Chí Minh' AND r.rn % 3 = 0 THEN 'https://images.unsplash.com/photo-1555400038-63f5ba517a47?w=800&q=80'

  WHEN r.destination = 'Kiên Giang' AND r.rn % 3 = 1 THEN 'https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=800&q=80'
  WHEN r.destination = 'Kiên Giang' AND r.rn % 3 = 2 THEN 'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=800&q=80'
  WHEN r.destination = 'Kiên Giang' AND r.rn % 3 = 0 THEN 'https://images.unsplash.com/photo-1557400128-9a431afe5ff5?w=800&q=80'

  WHEN r.destination = 'Cần Thơ' AND r.rn % 3 = 1 THEN 'https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=800&q=80'
  WHEN r.destination = 'Cần Thơ' AND r.rn % 3 = 2 THEN 'https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80'
  WHEN r.destination = 'Cần Thơ' AND r.rn % 3 = 0 THEN 'https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80'

  WHEN r.destination = 'An Giang' AND r.rn % 3 = 1 THEN 'https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=800&q=80'
  WHEN r.destination = 'An Giang' AND r.rn % 3 = 2 THEN 'https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80'
  WHEN r.destination = 'An Giang' AND r.rn % 3 = 0 THEN 'https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=800&q=80'

  WHEN r.destination = 'Bà Rịa - Vũng Tàu' AND r.rn % 3 = 1 THEN 'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=800&q=80'
  WHEN r.destination = 'Bà Rịa - Vũng Tàu' AND r.rn % 3 = 2 THEN 'https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=800&q=80'
  WHEN r.destination = 'Bà Rịa - Vũng Tàu' AND r.rn % 3 = 0 THEN 'https://images.unsplash.com/photo-1557400128-9a431afe5ff5?w=800&q=80'

  WHEN r.destination = 'Đồng Tháp' AND r.rn % 3 = 1 THEN 'https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=800&q=80'
  WHEN r.destination = 'Đồng Tháp' AND r.rn % 3 = 2 THEN 'https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80'
  WHEN r.destination = 'Đồng Tháp' AND r.rn % 3 = 0 THEN 'https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=800&q=80'

  -- Tất cả tỉnh còn lại — xoay 3 ảnh chung
  WHEN r.rn % 3 = 1 THEN 'https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80'
  WHEN r.rn % 3 = 2 THEN 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80'
  ELSE                    'https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80'
END
FROM ranked r
WHERE t.id = r.id;

-- Kiểm tra kết quả
SELECT destination, COUNT(*) as total,
  COUNT(DISTINCT cover_image) as so_anh_khac_nhau
FROM tours
GROUP BY destination
ORDER BY destination
LIMIT 20;
