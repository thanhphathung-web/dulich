-- ═══════════════════════════════════════════════════════════════════
-- BAGGIO TRAVEL — CẬP NHẬT ẢNH BÌA THEO TỪNG ĐIỂM ĐẾN
-- Dán vào: Supabase Dashboard → SQL Editor → Chạy
-- https://supabase.com/dashboard/project/lfnlezfphwjtdunyungi/sql/new
-- Chạy SAU khi đã chạy seed_tours.sql
-- ═══════════════════════════════════════════════════════════════════

-- ── MIỀN BẮC ──────────────────────────────────────────────────────

UPDATE tours SET cover_image = 'https://images.unsplash.com/photo-1555921015-5532091f6026?w=800&q=80'
WHERE destination = 'Hà Nội';
-- Hồ Hoàn Kiếm, đường phố Hà Nội

UPDATE tours SET cover_image = 'https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800&q=80'
WHERE destination IN ('Hạ Long', 'Cát Bà', 'Vân Đồn');
-- Vịnh Hạ Long thuyền truyền thống

UPDATE tours SET cover_image = 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80'
WHERE destination IN ('Sa Pa', 'Mù Cang Chải', 'Bắc Hà');
-- Ruộng bậc thang mùa lúa chín

UPDATE tours SET cover_image = 'https://images.unsplash.com/photo-1570197788417-0e82375c9371?w=800&q=80'
WHERE destination = 'Ninh Bình';
-- Tràng An / Tam Cốc nhìn từ trên cao

UPDATE tours SET cover_image = 'https://images.unsplash.com/photo-1563286350-4c9b653ec3a9?w=800&q=80'
WHERE destination IN ('Hà Giang', 'Đồng Văn');
-- Đèo Mã Pí Lèng, cung đường uốn lượn

UPDATE tours SET cover_image = 'https://images.unsplash.com/photo-1563286172-078b4e2935ee?w=800&q=80'
WHERE destination = 'Cao Bằng';
-- Thác Bản Giốc / núi rừng Cao Bằng

UPDATE tours SET cover_image = 'https://images.unsplash.com/photo-1560390984-5b636c4cb1de?w=800&q=80'
WHERE destination = 'Mộc Châu';
-- Đồi chè Mộc Châu / hoa anh đào

UPDATE tours SET cover_image = 'https://images.unsplash.com/photo-1585749987635-1f88d93c4d68?w=800&q=80'
WHERE destination IN ('Mai Châu', 'Hòa Bình');
-- Thung lũng Mai Châu xanh mướt

UPDATE tours SET cover_image = 'https://images.unsplash.com/photo-1528606589862-7d68b7e3c95a?w=800&q=80'
WHERE destination IN ('Điện Biên', 'Lai Châu', 'Sơn La');
-- Núi rừng Tây Bắc

UPDATE tours SET cover_image = 'https://images.unsplash.com/photo-1563286172-6704d757bc53?w=800&q=80'
WHERE destination IN ('Na Hang', 'Tuyên Quang', 'Yên Bái');
-- Hồ nước xanh giữa núi rừng

UPDATE tours SET cover_image = 'https://images.unsplash.com/photo-1585750902356-851a02b424f9?w=800&q=80'
WHERE destination IN ('Tam Đảo', 'Lạng Sơn', 'Bắc Ninh', 'Phú Thọ');
-- Phong cảnh miền núi phía Bắc

-- ── MIỀN TRUNG ────────────────────────────────────────────────────

UPDATE tours SET cover_image = 'https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=800&q=80'
WHERE destination = 'Đà Nẵng';
-- Cầu Rồng / bãi biển Mỹ Khê

UPDATE tours SET cover_image = 'https://images.unsplash.com/photo-1528127269322-539801943592?w=800&q=80'
WHERE destination IN ('Hội An', 'Cù Lao Chàm');
-- Phố cổ Hội An đèn lồng lung linh

UPDATE tours SET cover_image = 'https://images.unsplash.com/photo-1621618358625-eb0d0e79c93f?w=800&q=80'
WHERE destination = 'Huế';
-- Đại Nội / Hoàng thành Huế

UPDATE tours SET cover_image = 'https://images.unsplash.com/photo-1585155683190-0e92394ac1ea?w=800&q=80'
WHERE destination = 'Nha Trang';
-- Bãi biển Nha Trang xanh biếc

UPDATE tours SET cover_image = 'https://images.unsplash.com/photo-1609602853490-36b2a95c50f9?w=800&q=80'
WHERE destination IN ('Đà Lạt', 'Bảo Lộc', 'Lâm Đồng');
-- Thung lũng Đà Lạt sương mù

UPDATE tours SET cover_image = 'https://images.unsplash.com/photo-1584916201218-f4242ceb4809?w=800&q=80'
WHERE destination IN ('Mũi Né', 'Phan Thiết');
-- Đồi cát đỏ Mũi Né

UPDATE tours SET cover_image = 'https://images.unsplash.com/photo-1588513340145-25887e90a1c8?w=800&q=80'
WHERE destination IN ('Quy Nhơn', 'Bình Định');
-- Bãi biển Quy Nhơn hoang sơ

UPDATE tours SET cover_image = 'https://images.unsplash.com/photo-1585986701407-afaffc96eec7?w=800&q=80'
WHERE destination IN ('Phú Yên', 'Tuy Hòa');
-- Gành Đá Đĩa / Phú Yên

UPDATE tours SET cover_image = 'https://images.unsplash.com/photo-1575311373937-040b8e1fd5b6?w=800&q=80'
WHERE destination IN ('Phong Nha', 'Quảng Bình');
-- Hang động Phong Nha kỳ vĩ

UPDATE tours SET cover_image = 'https://images.unsplash.com/photo-1523538290088-51e3e7d1c00d?w=800&q=80'
WHERE destination IN ('Lý Sơn', 'Quảng Ngãi');
-- Đảo hoang sơ nhiệt đới

UPDATE tours SET cover_image = 'https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=800&q=80'
WHERE destination IN ('Buôn Ma Thuột', 'Đắk Lắk', 'Đắk Nông');
-- Nương cà phê Tây Nguyên

UPDATE tours SET cover_image = 'https://images.unsplash.com/photo-1580695252680-1a1caf49bf07?w=800&q=80'
WHERE destination IN ('Kon Tum', 'Gia Lai');
-- Cao nguyên Tây Nguyên

UPDATE tours SET cover_image = 'https://images.unsplash.com/photo-1526139334526-f591a54b477c?w=800&q=80'
WHERE destination IN ('Quảng Nam', 'Quảng Trị', 'Nghệ An', 'Hà Tĩnh', 'Thanh Hóa');
-- Phong cảnh miền Trung

UPDATE tours SET cover_image = 'https://images.unsplash.com/photo-1649372315722-b6d9cc9737dc?w=800&q=80'
WHERE destination IN ('Ninh Thuận', 'Phan Rang', 'Bình Thuận');
-- Biển xanh miền Nam Trung Bộ

-- ── MIỀN NAM ──────────────────────────────────────────────────────

UPDATE tours SET cover_image = 'https://images.unsplash.com/photo-1705253920175-8df4e2408113?w=800&q=80'
WHERE destination = 'Hồ Chí Minh';
-- Skyline TP.HCM ban đêm

UPDATE tours SET cover_image = 'https://images.unsplash.com/photo-1572572216428-91def7b78278?w=800&q=80'
WHERE destination = 'Phú Quốc';
-- Bãi biển nhiệt đới Phú Quốc trong xanh

UPDATE tours SET cover_image = 'https://images.unsplash.com/photo-1610610822995-752bc72117dd?w=800&q=80'
WHERE destination = 'Vũng Tàu';
-- Bờ biển Vũng Tàu

UPDATE tours SET cover_image = 'https://images.unsplash.com/photo-1572985025058-87efb85f3d6a?w=800&q=80'
WHERE destination IN ('Cần Thơ', 'Mỹ Tho', 'Tiền Giang');
-- Chợ nổi miền Tây

UPDATE tours SET cover_image = 'https://images.unsplash.com/photo-1605036687969-9c2878c7395b?w=800&q=80'
WHERE destination = 'Côn Đảo';
-- Đảo nhiệt đới Côn Đảo

UPDATE tours SET cover_image = 'https://images.unsplash.com/photo-1732243395944-cb3ff9311091?w=800&q=80'
WHERE destination IN ('Châu Đốc', 'An Giang');
-- Sông nước châu thổ

UPDATE tours SET cover_image = 'https://images.unsplash.com/photo-1588212363039-063d86a880b5?w=800&q=80'
WHERE destination IN ('Cà Mau', 'Bạc Liêu', 'Sóc Trăng');
-- Rừng ngập mặn Cà Mau

UPDATE tours SET cover_image = 'https://images.unsplash.com/photo-1585986701407-afaffc96eec7?w=800&q=80'
WHERE destination IN ('Bến Tre', 'Trà Vinh', 'Vĩnh Long', 'Đồng Tháp', 'Long An');
-- Miệt vườn sông nước

UPDATE tours SET cover_image = 'https://images.unsplash.com/photo-1585750902356-851a02b424f9?w=800&q=80'
WHERE destination IN ('Tây Ninh', 'Bình Dương', 'Đồng Nai', 'Bình Phước', 'Kiên Giang');
-- Miền Nam xanh tươi

-- ── XÁC NHẬN ──────────────────────────────────────────────────────
SELECT
  destination,
  count(*)         AS so_tour,
  left(cover_image, 60) AS anh_bia
FROM tours
WHERE status = 'ACTIVE'
GROUP BY destination, cover_image
ORDER BY destination;
