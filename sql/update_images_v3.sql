-- Cập nhật ảnh xoay vòng 3 ảnh theo tỉnh thành — khớp đúng tên trong DB
-- Chạy trong Supabase SQL Editor

UPDATE tours t
SET cover_image = sub.img
FROM (
  SELECT id,
    CASE ((ROW_NUMBER() OVER (PARTITION BY destination ORDER BY created_at) - 1) % 3)
    WHEN 0 THEN i1 WHEN 1 THEN i2 ELSE i3
    END AS img
  FROM tours
  JOIN (VALUES
    ('An Giang',           'https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=800&q=80','https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80','https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=800&q=80'),
    ('Bà Rịa - Vũng Tàu', 'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=800&q=80','https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=800&q=80','https://images.unsplash.com/photo-1557400128-9a431afe5ff5?w=800&q=80'),
    ('Bắc Giang',          'https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=800&q=80','https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80','https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80'),
    ('Bắc Kạn',            'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80','https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80','https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=800&q=80'),
    ('Bạc Liêu',           'https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=800&q=80','https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80','https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=800&q=80'),
    ('Bắc Ninh',           'https://images.unsplash.com/photo-1555400038-63f5ba517a47?w=800&q=80','https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80','https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80'),
    ('Bến Tre',            'https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=800&q=80','https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80','https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80'),
    ('Bình Định',          'https://images.unsplash.com/photo-1557400128-9a431afe5ff5?w=800&q=80','https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=800&q=80','https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=800&q=80'),
    ('Bình Dương',         'https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=800&q=80','https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80','https://images.unsplash.com/photo-1555400038-63f5ba517a47?w=800&q=80'),
    ('Bình Phước',         'https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80','https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80','https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=800&q=80'),
    ('Bình Thuận',         'https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=800&q=80','https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=800&q=80','https://images.unsplash.com/photo-1557400128-9a431afe5ff5?w=800&q=80'),
    ('Cà Mau',             'https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=800&q=80','https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80','https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80'),
    ('Cần Thơ',            'https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=800&q=80','https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80','https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80'),
    ('Cao Bằng',           'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80','https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=800&q=80','https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80'),
    ('Đà Lạt',             'https://images.unsplash.com/photo-1555400038-63f5ba517a47?w=800&q=80','https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80','https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80'),
    ('Đà Nẵng',            'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=800&q=80','https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80','https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=800&q=80'),
    ('Đắk Lắk',            'https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80','https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=800&q=80','https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80'),
    ('Đắk Nông',           'https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80','https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80','https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=800&q=80'),
    ('Điện Biên',          'https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=800&q=80','https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80','https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80'),
    ('Đồng Nai',           'https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=800&q=80','https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80','https://images.unsplash.com/photo-1555400038-63f5ba517a47?w=800&q=80'),
    ('Đồng Tháp',          'https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=800&q=80','https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80','https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=800&q=80'),
    ('Gia Lai',            'https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80','https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80','https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=800&q=80'),
    ('Hà Giang',           'https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=800&q=80','https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80','https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=800&q=80'),
    ('Hạ Long',            'https://images.unsplash.com/photo-1557400128-9a431afe5ff5?w=800&q=80','https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80','https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80'),
    ('Hà Nam',             'https://images.unsplash.com/photo-1555400038-63f5ba517a47?w=800&q=80','https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80','https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80'),
    ('Hà Nội',             'https://images.unsplash.com/photo-1555400038-63f5ba517a47?w=800&q=80','https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80','https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80'),
    ('Hà Tĩnh',            'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=800&q=80','https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=800&q=80','https://images.unsplash.com/photo-1557400128-9a431afe5ff5?w=800&q=80'),
    ('Hải Dương',          'https://images.unsplash.com/photo-1555400038-63f5ba517a47?w=800&q=80','https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80','https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80'),
    ('Hải Phòng',          'https://images.unsplash.com/photo-1557400128-9a431afe5ff5?w=800&q=80','https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=800&q=80','https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80'),
    ('Hậu Giang',          'https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=800&q=80','https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80','https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=800&q=80'),
    ('Hòa Bình',           'https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=800&q=80','https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80','https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80'),
    ('Hội An',             'https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80','https://images.unsplash.com/photo-1555400038-63f5ba517a47?w=800&q=80','https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=800&q=80'),
    ('Hưng Yên',           'https://images.unsplash.com/photo-1555400038-63f5ba517a47?w=800&q=80','https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80','https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80'),
    ('Khánh Hòa',          'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=800&q=80','https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=800&q=80','https://images.unsplash.com/photo-1557400128-9a431afe5ff5?w=800&q=80'),
    ('Kiên Giang',         'https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=800&q=80','https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=800&q=80','https://images.unsplash.com/photo-1557400128-9a431afe5ff5?w=800&q=80'),
    ('Kon Tum',            'https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80','https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=800&q=80','https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80'),
    ('Lai Châu',           'https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=800&q=80','https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80','https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80'),
    ('Lâm Đồng',           'https://images.unsplash.com/photo-1555400038-63f5ba517a47?w=800&q=80','https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80','https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80'),
    ('Lạng Sơn',           'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80','https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=800&q=80','https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80'),
    ('Lào Cai',            'https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=800&q=80','https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80','https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80'),
    ('Long An',            'https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=800&q=80','https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80','https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=800&q=80'),
    ('Nam Định',           'https://images.unsplash.com/photo-1555400038-63f5ba517a47?w=800&q=80','https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=800&q=80','https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80'),
    ('Nghệ An',            'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=800&q=80','https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=800&q=80','https://images.unsplash.com/photo-1557400128-9a431afe5ff5?w=800&q=80'),
    ('Nha Trang',          'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=800&q=80','https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=800&q=80','https://images.unsplash.com/photo-1557400128-9a431afe5ff5?w=800&q=80'),
    ('Ninh Bình',          'https://images.unsplash.com/photo-1555400038-63f5ba517a47?w=800&q=80','https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80','https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80'),
    ('Ninh Thuận',         'https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=800&q=80','https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=800&q=80','https://images.unsplash.com/photo-1557400128-9a431afe5ff5?w=800&q=80'),
    ('Phú Quốc',           'https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=800&q=80','https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=800&q=80','https://images.unsplash.com/photo-1557400128-9a431afe5ff5?w=800&q=80'),
    ('Phú Thọ',            'https://images.unsplash.com/photo-1555400038-63f5ba517a47?w=800&q=80','https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=800&q=80','https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80'),
    ('Phú Yên',            'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=800&q=80','https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=800&q=80','https://images.unsplash.com/photo-1557400128-9a431afe5ff5?w=800&q=80'),
    ('Quảng Bình',         'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80','https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80','https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=800&q=80'),
    ('Quảng Nam',          'https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80','https://images.unsplash.com/photo-1555400038-63f5ba517a47?w=800&q=80','https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80'),
    ('Quảng Ngãi',         'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=800&q=80','https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=800&q=80','https://images.unsplash.com/photo-1557400128-9a431afe5ff5?w=800&q=80'),
    ('Quảng Ninh',         'https://images.unsplash.com/photo-1557400128-9a431afe5ff5?w=800&q=80','https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80','https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80'),
    ('Quảng Trị',          'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=800&q=80','https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80','https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=800&q=80'),
    ('Sa Pa',              'https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=800&q=80','https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80','https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80'),
    ('Sóc Trăng',          'https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=800&q=80','https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80','https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=800&q=80'),
    ('Sơn La',             'https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=800&q=80','https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80','https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=800&q=80'),
    ('Tây Ninh',           'https://images.unsplash.com/photo-1555400038-63f5ba517a47?w=800&q=80','https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80','https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=800&q=80'),
    ('Thái Bình',          'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=800&q=80','https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80','https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=800&q=80'),
    ('Thái Nguyên',        'https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80','https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=800&q=80','https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80'),
    ('Thanh Hóa',          'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=800&q=80','https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=800&q=80','https://images.unsplash.com/photo-1557400128-9a431afe5ff5?w=800&q=80'),
    ('Thừa Thiên Huế',     'https://images.unsplash.com/photo-1555400038-63f5ba517a47?w=800&q=80','https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80','https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80'),
    ('Tiền Giang',         'https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=800&q=80','https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80','https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=800&q=80'),
    ('TP Hồ Chí Minh',     'https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=800&q=80','https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80','https://images.unsplash.com/photo-1555400038-63f5ba517a47?w=800&q=80'),
    ('Trà Vinh',           'https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=800&q=80','https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80','https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=800&q=80'),
    ('Tuyên Quang',        'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80','https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80','https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=800&q=80'),
    ('Vĩnh Long',          'https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=800&q=80','https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80','https://images.unsplash.com/photo-1596422846543-75c6fc197f07?w=800&q=80'),
    ('Vĩnh Phúc',          'https://images.unsplash.com/photo-1555400038-63f5ba517a47?w=800&q=80','https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80','https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80'),
    ('Yên Bái',            'https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=800&q=80','https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80','https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80')
  ) AS m(dest, i1, i2, i3) ON tours.destination = m.dest
) AS sub
WHERE t.id = sub.id;

-- Kiểm tra: đếm tỉnh nào chưa có ảnh
SELECT destination, COUNT(*) as total,
  SUM(CASE WHEN cover_image LIKE '%unsplash%' THEN 1 ELSE 0 END) as co_anh
FROM tours
GROUP BY destination
HAVING SUM(CASE WHEN cover_image LIKE '%unsplash%' THEN 1 ELSE 0 END) < COUNT(*)
ORDER BY destination;
