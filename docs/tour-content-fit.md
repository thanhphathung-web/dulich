# Nội dung Tour Mẫu — Baggio Travel (FIT & Private)

> Copy từng tour vào CMS (`/cms`). Ảnh dùng URL Unsplash trực tiếp.  
> Schema: `name_vi` · `destination` · `region` · `duration_days/nights` · `base_price` · `max_pax` · `cover_image` · `includes_vi` (JSON) · `itinerary_vi` (JSON) · `highlights_vi` · `status: ACTIVE`

---

## MIỀN BẮC

### Tour 1 — Sa Pa Bản Làng Riêng Tư 3N2Đ
| Field | Giá trị |
|---|---|
| `name_vi` | Sa Pa – Y Tý Riêng Tư: Bản Làng & Ruộng Bậc Thang 3N2Đ |
| `name_en` | Sapa – Y Ty Private: Villages & Rice Terraces 3D2N |
| `destination` | Sa Pa |
| `region` | north |
| `duration_days` | 3 |
| `duration_nights` | 2 |
| `base_price` | 4200000 |
| `max_pax` | 8 |
| `cover_image` | https://images.unsplash.com/photo-1558642084-fd07fae5282e?w=800&q=80 |

**includes_vi (JSON):**
```json
{
  "hotel": "3-star",
  "guide": true,
  "private_car": true,
  "transfer": true,
  "entrance_fees": true,
  "meals": "Sáng buffet · Trưa tại bản · Tối ở Sa Pa"
}
```

**itinerary_vi (JSON):**
```json
[
  {
    "day": 1,
    "title": "Hà Nội – Sa Pa – Bản Cát Cát",
    "activities": [
      "07:00 — Xe riêng đón tại khách sạn Hà Nội, đi cao tốc Nội Bài – Lào Cai (3.5h)",
      "11:30 — Nhận phòng khách sạn 3★ Sa Pa, nghỉ trưa",
      "14:00 — HDV đón, đi bộ vào Bản Cát Cát: nhà người Mông, nghề thêu dệt truyền thống, thác nước",
      "17:30 — Tự do dạo phố Sa Pa, thử thắng cố và thẩm rượu ngô tại chợ đêm",
      "19:00 — Tối tự do hoặc ăn lẩu gà đen cùng đoàn"
    ]
  },
  {
    "day": 2,
    "title": "Trekking Y Tý – Bản A Lù – Ruộng Bậc Thang",
    "activities": [
      "06:30 — Khởi hành sớm đi Y Tý (1.5h xe, đường đèo núi đẹp)",
      "08:30 — Trekking nhẹ qua bản A Lù: gặp gỡ người Hà Nhì, xem làm ruộng bậc thang thủ công",
      "11:30 — Ăn trưa tại nhà người dân địa phương (cơm lam, gà đồi nướng, rau rừng)",
      "13:30 — Tiếp tục trekking, ngắm ruộng bậc thang mùa lúa chín hoặc nước đổ tùy mùa",
      "16:00 — Về Sa Pa, tắm ngâm thảo dược người Dao Đỏ tại spa",
      "19:00 — Tối tự do"
    ]
  },
  {
    "day": 3,
    "title": "Bản Tả Phìn – Về Hà Nội",
    "activities": [
      "08:00 — Ăn sáng, check-out",
      "09:00 — Thăm Bản Tả Phìn: người Dao Đỏ, nghề thuốc đông y và thêu thổ cẩm",
      "11:00 — Mua đồ lưu niệm tại Sa Pa, ăn trưa",
      "13:00 — Xe đưa về Hà Nội, trả phòng khách sạn (về khoảng 17:30)"
    ]
  }
]
```

**highlights_vi:**
- Xe riêng suốt hành trình, không chung đoàn
- HDV người địa phương nói tiếng Anh lưu loát
- Bữa trưa tại bản thật, không phải nhà hàng du lịch
- Ngâm thuốc thảo dược Dao Đỏ chính gốc
- Lịch trình linh hoạt theo thể lực đoàn

---

### Tour 2 — Hạ Long Du Thuyền Đêm Riêng 2N1Đ
| Field | Giá trị |
|---|---|
| `name_vi` | Hạ Long Bay: Du Thuyền Đêm Riêng – Kayak & Hang Sáng Tối 2N1Đ |
| `name_en` | Halong Bay Private Cruise – Kayak & Cave 2D1N |
| `destination` | Hạ Long |
| `region` | north |
| `duration_days` | 2 |
| `duration_nights` | 1 |
| `base_price` | 3800000 |
| `max_pax` | 12 |
| `cover_image` | https://images.unsplash.com/photo-1473186578172-c141e6798cf4?w=800&q=80 |

**includes_vi (JSON):**
```json
{
  "hotel": "4-star-cruise",
  "guide": true,
  "transfer": true,
  "entrance_fees": true,
  "boat": true,
  "meals": "Trưa · Tối buffet hải sản · Sáng"
}
```

**itinerary_vi (JSON):**
```json
[
  {
    "day": 1,
    "title": "Hà Nội – Cảng Tuần Châu – Vịnh Hạ Long",
    "activities": [
      "07:30 — Xe đón tại khách sạn Hà Nội (Hoàn Kiếm hoặc Tây Hồ)",
      "11:30 — Xuống cảng Tuần Châu, lên du thuyền, check-in phòng cabin",
      "12:00 — Trưa buffet trên thuyền, thuyền rời bến vào vịnh",
      "14:30 — Khám phá Hang Sáng Tối hoặc Hang Thiên Cung (tùy lịch trình năm)",
      "16:00 — Chèo kayak qua các rừng đước và đảo nhỏ, tắm biển",
      "18:30 — Tắt mặt trời trên boong, cocktail chào buổi tối",
      "19:00 — Tối buffet hải sản: tôm nướng, mực, hàu Hạ Long",
      "21:00 — Câu mực đêm hoặc giao lưu trên boong"
    ]
  },
  {
    "day": 2,
    "title": "Bình Minh Vịnh – Làng Chài – Về Hà Nội",
    "activities": [
      "06:00 — Tập Tai Chi trên boong ngắm bình minh",
      "07:30 — Sáng nhẹ, thuyền đến Làng Chài Cửa Vạn: tham quan nhà nổi, gặp ngư dân",
      "09:00 — Kayak tự do quanh các đảo đá vôi nhỏ",
      "10:30 — Check-out cabin, trưa nhẹ trên thuyền",
      "12:00 — Thuyền cập bến, xe về Hà Nội (về khoảng 16:30)"
    ]
  }
]
```

**highlights_vi:**
- Du thuyền 4★ cabin riêng với ban công nhìn ra vịnh
- Kayak qua rừng đước buổi chiều — trải nghiệm hiếm có
- Câu mực đêm cùng thủy thủ đoàn
- Ngắm bình minh Hạ Long từ boong trên
- Ăn tối hải sản tươi vừa được đánh ngay trong vịnh

---

### Tour 3 — Ninh Bình Tràng An & Hang Múa 1 Ngày
| Field | Giá trị |
|---|---|
| `name_vi` | Ninh Bình – Tràng An & Hang Múa: Hành Trình Di Sản UNESCO 1 Ngày |
| `name_en` | Ninh Binh – Trang An & Mua Cave: UNESCO Heritage Day Trip |
| `destination` | Ninh Bình |
| `region` | north |
| `duration_days` | 1 |
| `duration_nights` | 0 |
| `base_price` | 950000 |
| `max_pax` | 10 |
| `cover_image` | https://images.unsplash.com/photo-1570959028052-f5a98eb22a7c?w=800&q=80 |

**includes_vi (JSON):**
```json
{
  "guide": true,
  "private_car": true,
  "transfer": true,
  "entrance_fees": true,
  "boat": true,
  "meals": "Trưa tại nhà hàng địa phương"
}
```

**itinerary_vi (JSON):**
```json
[
  {
    "day": 1,
    "title": "Hà Nội – Ninh Bình – Tràng An – Hang Múa – Về Hà Nội",
    "activities": [
      "07:30 — Xe đón tại khách sạn Hà Nội, đi Ninh Bình (2h)",
      "09:30 — Đến Tràng An, lên thuyền nan (thuyền 4 người, chèo tay): qua 3 hang động bí ẩn, ngắm vách đá vôi dựng đứng và ruộng lúa",
      "11:30 — Ăn trưa: cơm niêu đá, dê núi Ninh Bình, rau sắng chùa Hương",
      "13:30 — Leo 500 bậc lên đỉnh Hang Múa: toàn cảnh đồng bằng Ninh Bình hình rồng chào mây",
      "15:00 — Tùy chọn: thăm Chùa Bái Đính (lớn nhất Đông Nam Á) hoặc mua đồ thủ công mỹ nghệ cói",
      "16:00 — Xe về Hà Nội, trả phòng khoảng 18:30"
    ]
  }
]
```

**highlights_vi:**
- Thuyền nan chèo tay qua 3 hang động (khác thuyền máy ồn ào)
- Leo Hang Múa: view panorama đẹp nhất Ninh Bình
- Ăn trưa đặc sản thật — không phải nhà hàng du lịch đại trà
- Xe riêng, không phụ thuộc xe chung giờ giấc

---

## MIỀN TRUNG

### Tour 4 — Hội An Cổ Phố & Ẩm Thực Private 1 Ngày
| Field | Giá trị |
|---|---|
| `name_vi` | Hội An: Phố Cổ, Làng Rau Trà Quế & Lớp Nấu Ăn Private |
| `name_en` | Hoi An: Ancient Town, Tra Que Village & Private Cooking Class |
| `destination` | Hội An |
| `region` | central |
| `duration_days` | 1 |
| `duration_nights` | 0 |
| `base_price` | 1150000 |
| `max_pax` | 8 |
| `cover_image` | https://images.unsplash.com/photo-1509030450996-dd1a26dda07a?w=800&q=80 |

**includes_vi (JSON):**
```json
{
  "guide": true,
  "private_car": true,
  "entrance_fees": true,
  "meals": "Trưa ăn thử Cao Lầu – Mì Quảng · Buổi tối tham gia nấu ăn 5 món"
}
```

**itinerary_vi (JSON):**
```json
[
  {
    "day": 1,
    "title": "Hội An Phố Cổ – Làng Rau – Lớp Nấu Ăn – Đèn Lồng",
    "activities": [
      "08:00 — Xe đón tại khách sạn, đến Làng Rau Trà Quế: cùng nông dân tưới rau, nhổ cỏ, học làm rau quế",
      "09:30 — Ghé thăm 5 điểm di sản phố cổ: Chùa Cầu Nhật Bản, Nhà Cổ Tấn Ký, Hội Quán Phúc Kiến, Museum Văn Hóa Dân Gian",
      "11:30 — Thưởng thức Cao Lầu và Mì Quảng tại quán ăn địa phương thật (không phải nhà hàng du lịch)",
      "13:30 — Nghỉ trưa, HDV đưa về khách sạn",
      "15:30 — Lớp nấu ăn private 5 món: ra chợ Hội An chọn nguyên liệu cùng đầu bếp, nấu Cao Lầu, Bánh Mì Hội An, Hoành Thánh, Cơm Gà, Chè",
      "18:00 — Dạo phố cổ buổi tối, thả đèn lồng sông Hoài (tùy ý)"
    ]
  }
]
```

**highlights_vi:**
- Lớp nấu ăn private với đầu bếp người Hội An thật — không phải show du lịch
- Ra chợ chọn nguyên liệu cùng đầu bếp (trải nghiệm chợ địa phương thật)
- HDV dẫn vào ngõ phố cổ ít khách biết
- Không chung đoàn, thời gian linh hoạt

---

### Tour 5 — Huế Cố Đô & Ẩm Thực Cung Đình 2N1Đ
| Field | Giá trị |
|---|---|
| `name_vi` | Huế Cố Đô: Hoàng Thành, Lăng Tẩm & Ẩm Thực Cung Đình 2N1Đ |
| `name_en` | Hue Imperial City: Citadel, Royal Tombs & Royal Cuisine 2D1N |
| `destination` | Huế |
| `region` | central |
| `duration_days` | 2 |
| `duration_nights` | 1 |
| `base_price` | 2600000 |
| `max_pax` | 10 |
| `cover_image` | https://images.unsplash.com/photo-1624526267942-1e7fe8e0b00f?w=800&q=80 |

**includes_vi (JSON):**
```json
{
  "hotel": "3-star",
  "guide": true,
  "private_car": true,
  "entrance_fees": true,
  "boat": true,
  "meals": "Sáng · Trưa cơm Huế · Tối tiệc cung đình 12 món"
}
```

**itinerary_vi (JSON):**
```json
[
  {
    "day": 1,
    "title": "Hoàng Thành – Chùa Thiên Mụ – Thuyền Rồng Sông Hương",
    "activities": [
      "08:00 — Xe đón, tham quan Hoàng Thành Huế (Cố Đô Triều Nguyễn): Ngọ Môn, Điện Thái Hòa, Tử Cấm Thành",
      "11:00 — Cơm Huế bình dân: Bún Bò Huế, Bánh Canh, Bèo – Nậm – Lọc chính gốc",
      "13:30 — Thăm Chùa Thiên Mụ — tháp Phước Duyên 7 tầng nhìn ra sông Hương",
      "15:00 — Thuyền rồng ngược sông Hương, nghe ca Huế (nhạc cổ điển Huế)",
      "17:00 — Check-in khách sạn 3★ boutique trung tâm Huế",
      "19:00 — Tối tiệc cung đình 12 món: các món ăn vua triều Nguyễn phục dựng"
    ]
  },
  {
    "day": 2,
    "title": "Lăng Khải Định – Lăng Tự Đức – Làng Nghề",
    "activities": [
      "08:00 — Ăn sáng Bánh Mì Phượng Huế tại quán địa phương",
      "09:00 — Lăng Khải Định: kiến trúc kết hợp Á–Âu kỳ lạ nhất Việt Nam",
      "10:30 — Lăng Tự Đức: hồ sen, vườn cổ thụ, bia mộ tự vua viết",
      "12:00 — Trưa tại nhà hàng Làng Cổ Phước Tích",
      "13:30 — Thăm làng nghề đúc đồng Phường Đúc hoặc làng hoa giấy Thanh Tiên",
      "15:30 — Tự do mua sắm, xe đưa về điểm xuất phát"
    ]
  }
]
```

---

### Tour 6 — Đà Nẵng – Bà Nà Hills – Marble Mountains 2N1Đ
| Field | Giá trị |
|---|---|
| `name_vi` | Đà Nẵng: Bà Nà Hills – Ngũ Hành Sơn – Cầu Vàng 2N1Đ |
| `name_en` | Da Nang: Ba Na Hills – Marble Mountains – Golden Bridge 2D1N |
| `destination` | Đà Nẵng |
| `region` | central |
| `duration_days` | 2 |
| `duration_nights` | 1 |
| `base_price` | 2900000 |
| `max_pax` | 10 |
| `cover_image` | https://images.unsplash.com/photo-1552465011-b4e21bf6e79a?w=800&q=80 |

**includes_vi (JSON):**
```json
{
  "hotel": "4-star",
  "guide": true,
  "private_car": true,
  "entrance_fees": true,
  "meals": "Sáng · Trưa hải sản · Tối bánh mì Đà Nẵng"
}
```

**itinerary_vi (JSON):**
```json
[
  {
    "day": 1,
    "title": "Bà Nà Hills – Cầu Vàng – Làng Pháp",
    "activities": [
      "08:00 — Xe đón, lên cáp treo Bà Nà Hills (dài nhất thế giới một thời)",
      "09:30 — Cầu Vàng: chụp ảnh với bàn tay khổng lồ đỡ cầu, view toàn thành phố",
      "10:30 — Khám phá Làng Pháp: kiến trúc cổ châu Âu trên đỉnh núi 1500m",
      "12:30 — Trưa tại nhà hàng Bà Nà, trở về Đà Nẵng",
      "15:00 — Check-in khách sạn 4★ sát biển Mỹ Khê",
      "17:00 — Tắm biển Mỹ Khê (một trong những bãi biển đẹp nhất thế giới theo Forbes)",
      "19:30 — Tối hải sản tươi tại bến cá Mắm"
    ]
  },
  {
    "day": 2,
    "title": "Ngũ Hành Sơn – Chợ Hàn – Cầu Rồng",
    "activities": [
      "08:00 — Ăn sáng Mì Quảng Đà Nẵng",
      "09:00 — Ngũ Hành Sơn: leo núi Thuỷ Sơn, thăm động Huyền Không, chùa Tam Thai",
      "10:30 — Làng đá mỹ nghệ Non Nước: xem nghệ nhân đục đá (không bắt mua)",
      "12:00 — Trưa Bánh Xèo Đà Nẵng tại quán vỉa hè",
      "14:00 — Chợ Hàn: mua đặc sản Đà Nẵng (mắm ruốc, bánh tráng cuốn, mì gói đặc biệt)",
      "16:00 — Cầu Rồng phun lửa (thứ 7 và chủ nhật tối 21h) hoặc tự do",
      "17:00 — Xe đưa về sân bay / khách sạn"
    ]
  }
]
```

---

## MIỀN NAM

### Tour 7 — Phú Quốc Boutique Private 4N3Đ
| Field | Giá trị |
|---|---|
| `name_vi` | Phú Quốc: Biển Ngọc, Lặn San Hô & Rừng Nguyên Sinh Private 4N3Đ |
| `name_en` | Phu Quoc: Pearl Island, Coral Diving & Jungle Private 4D3N |
| `destination` | Phú Quốc |
| `region` | south |
| `duration_days` | 4 |
| `duration_nights` | 3 |
| `base_price` | 8500000 |
| `max_pax` | 8 |
| `cover_image` | https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&q=80 |

**includes_vi (JSON):**
```json
{
  "flights": true,
  "hotel": "resort",
  "guide": true,
  "private_car": true,
  "transfer": true,
  "entrance_fees": true,
  "boat": true,
  "meals": "Sáng buffet · Trưa hải sản trên đảo · Tối 2 bữa"
}
```

**itinerary_vi (JSON):**
```json
[
  {
    "day": 1,
    "title": "Bay Phú Quốc – Check-in Resort – Hoàng Hôn Bãi Sao",
    "activities": [
      "Sáng — Bay từ Hà Nội hoặc TP.HCM đến Phú Quốc (1.5h – 45 phút)",
      "Trưa — Xe đón sân bay, check-in resort boutique, nghỉ ngơi",
      "15:00 — Xe đưa đến Bãi Sao: tắm biển nước trong xanh nhất Phú Quốc",
      "18:00 — Hoàng hôn cocktail tại nhà hàng trên bãi biển",
      "19:30 — Tối hải sản: tôm hùm, cá bóp, ghẹ rang muối"
    ]
  },
  {
    "day": 2,
    "title": "Lặn San Hô – Câu Mực Đêm",
    "activities": [
      "08:00 — Thuyền riêng ra cụm đảo An Thới: snorkel và lặn biển ngắm san hô (có hướng dẫn)",
      "12:00 — Trưa hải sản BBQ ngay trên đảo hoang (cá tươi, tôm, bạch tuộc)",
      "14:00 — Tắm biển tự do tại Bãi Dài hoặc Bãi Ông Lang",
      "16:30 — Về resort, nghỉ ngơi, spa (tùy chọn)",
      "20:00 — Câu mực đêm cùng ngư dân: trải nghiệm thật không diễn"
    ]
  },
  {
    "day": 3,
    "title": "Vườn Quốc Gia – Làng Chài – Chợ Đêm Dương Đông",
    "activities": [
      "08:00 — Tour Vườn Quốc Gia Phú Quốc: rừng nguyên sinh, thác Tranh, vooc mặt trắng",
      "11:30 — Ghé làng chài Hàm Ninh: ăn trưa sò điệp nướng mỡ hành tươi",
      "14:00 — Tự do: tắm biển, nghỉ resort, massage",
      "18:00 — Chợ Đêm Dương Đông: thử bún quậy Phú Quốc, bánh mì hội an thu nhỏ, mua tiêu và nước mắm Phú Quốc"
    ]
  },
  {
    "day": 4,
    "title": "Sáng Tự Do – Ra Sân Bay",
    "activities": [
      "Sáng — Tự do ở resort, tắm biển lần cuối hoặc thuê xe đạp dạo quanh",
      "Trưa — Ăn nhẹ, check-out",
      "Chiều — Xe đưa sân bay, bay về theo lịch"
    ]
  }
]
```

---

### Tour 8 — Mekong Delta Cần Thơ – Châu Đốc 2N1Đ
| Field | Giá trị |
|---|---|
| `name_vi` | Mekong Thực Sự: Chợ Nổi Cái Răng – Châu Đốc – Núi Sam 2N1Đ |
| `name_en` | Real Mekong: Cai Rang Floating Market – Chau Doc – Sam Mountain 2D1N |
| `destination` | Cần Thơ |
| `region` | south |
| `duration_days` | 2 |
| `duration_nights` | 1 |
| `base_price` | 2200000 |
| `max_pax` | 10 |
| `cover_image` | https://images.unsplash.com/photo-1516026672322-bc52d61a9f3c?w=800&q=80 |

**includes_vi (JSON):**
```json
{
  "hotel": "3-star",
  "guide": true,
  "private_car": true,
  "boat": true,
  "entrance_fees": true,
  "meals": "Sáng · Trưa bánh mì Mekong · Tối lẩu mắm"
}
```

**itinerary_vi (JSON):**
```json
[
  {
    "day": 1,
    "title": "TP.HCM – Cần Thơ – Chợ Nổi Bình Thuỷ – Làng Nghề",
    "activities": [
      "06:00 — Xe đón tại TP.HCM, đi cao tốc đến Cần Thơ (3h, qua Mỹ Thuận, cầu Cần Thơ đẹp)",
      "09:00 — Thuyền máy đi chợ nổi Cái Răng: mua trái cây từ ghe trực tiếp, ăn bún riêu cua trên thuyền",
      "10:30 — Thuyền nhỏ chèo tay vào rạch nhỏ: nhà vườn nhãn, vườn dừa, làm kẹo dừa và bánh tráng",
      "12:30 — Trưa bánh mì thịt nướng + chè Cần Thơ",
      "14:00 — Xe đi Châu Đốc (2h), check-in khách sạn",
      "16:00 — Thuyền ra thăm làng cá bè Châu Đốc: cá tra, basa nuôi ngay dưới nhà",
      "19:00 — Lẩu mắm Châu Đốc: đặc sản không thể bỏ qua"
    ]
  },
  {
    "day": 2,
    "title": "Núi Sam – Tây An – Biên Giới Campuchia – Về TP.HCM",
    "activities": [
      "06:30 — Leo Núi Sam buổi sáng: view Đồng Tháp Mười, cánh đồng lúa bạt ngàn",
      "08:30 — Chùa Bà Chúa Xứ: ngôi chùa đông khách nhất miền Nam",
      "09:30 — Tùy chọn: qua cửa khẩu Tịnh Biên sang Campuchia (mang hộ chiếu, xem chợ biên giới)",
      "11:30 — Trưa bún cá Châu Đốc + mắm Thái chính gốc",
      "13:00 — Xe về TP.HCM, ghé Cần Thơ mua đặc sản",
      "18:00 — Về đến TP.HCM"
    ]
  }
]
```

---

### Tour 9 — TP. Hồ Chí Minh Food & History Day Tour
| Field | Giá trị |
|---|---|
| `name_vi` | Sài Gòn Thực Sự: Ẩm Thực Vỉa Hè & Lịch Sử Ngầm 1 Ngày |
| `name_en` | Real Saigon: Street Food & Underground History Day Tour |
| `destination` | Hồ Chí Minh |
| `region` | south |
| `duration_days` | 1 |
| `duration_nights` | 0 |
| `base_price` | 890000 |
| `max_pax` | 8 |
| `cover_image` | https://images.unsplash.com/photo-1555993539-1732b0258235?w=800&q=80 |

**includes_vi (JSON):**
```json
{
  "guide": true,
  "private_car": true,
  "entrance_fees": true,
  "meals": "Sáng bánh mì Sài Gòn · Trưa bún bò · Tối 5 món ăn vặt vỉa hè"
}
```

**itinerary_vi (JSON):**
```json
[
  {
    "day": 1,
    "title": "Sài Gòn: Chợ Bà Chiểu – Địa Đạo – Ẩm Thực Chiều Tối",
    "activities": [
      "07:00 — Ăn sáng Bánh Mì Huynh Hoa (nổi tiếng nhất Sài Gòn), cà phê vợt 100 tuổi",
      "08:30 — Chợ Bình Tây (Chợ Lớn): khu người Hoa, thương xá cổ nhất TP.HCM",
      "10:00 — Nhà thờ Đức Bà, Bưu điện Thành phố, Phố đi bộ Nguyễn Huệ",
      "11:30 — Bảo tàng Chứng tích Chiến tranh (khách nước ngoài rất muốn đến)",
      "13:00 — Bún Bò Huế hoặc Phở Bắc tại quán cơm gia đình vỉa hè",
      "14:30 — Xe đi Địa Đạo Củ Chi: trải nghiệm chui hầm thật (dài 120m), bắn súng trường AK thật (tùy chọn)",
      "17:00 — Về trung tâm, nghỉ ngơi",
      "18:30 — Tour ẩm thực tối: Bánh Tráng Nướng Đà Lạt kiểu Sài Gòn, Bò Né, Cháo Lòng, Sữa Đậu Nành nóng",
      "20:30 — Phố Bùi Viện: bar phố Tây nếu muốn"
    ]
  }
]
```

---

### Tour 10 — Côn Đảo Hoang Sơ & Lịch Sử 3N2Đ
| Field | Giá trị |
|---|---|
| `name_vi` | Côn Đảo: Biển Hoang Sơ, Di Tích Lịch Sử & Lặn Rạn San Hô 3N2Đ |
| `name_en` | Con Dao: Pristine Beaches, Historical Sites & Coral Diving 3D2N |
| `destination` | Côn Đảo |
| `region` | south |
| `duration_days` | 3 |
| `duration_nights` | 2 |
| `base_price` | 9800000 |
| `max_pax` | 8 |
| `cover_image` | https://images.unsplash.com/photo-1509392676773-fd5dc56d1e48?w=800&q=80 |

**includes_vi (JSON):**
```json
{
  "flights": true,
  "hotel": "resort",
  "guide": true,
  "private_car": true,
  "transfer": true,
  "entrance_fees": true,
  "boat": true,
  "meals": "Sáng · Trưa hải sản đảo · Tối 1 bữa"
}
```

**itinerary_vi (JSON):**
```json
[
  {
    "day": 1,
    "title": "Bay Côn Đảo – Resort – Bãi Đầm Trầu",
    "activities": [
      "Sáng — Bay từ TP.HCM đến Côn Đảo (45 phút, máy bay nhỏ)",
      "Trưa — Check-in resort, ăn trưa hải sản",
      "15:00 — Bãi Đầm Trầu: bãi biển hoang nhất Côn Đảo, nước trong veo",
      "18:00 — Hoàng hôn tại Mũi Cá Mập, tối tự do"
    ]
  },
  {
    "day": 2,
    "title": "Lặn San Hô – Nhà Tù Côn Đảo – Nghĩa Trang Hàng Dương",
    "activities": [
      "07:00 — Thuyền ra Hòn Bảy Cạnh: lặn biển ngắm san hô (có hướng dẫn), tắm biển hoang",
      "12:00 — Trưa ghẹ Côn Đảo hấp sả tươi",
      "14:00 — Nhà tù Côn Đảo (Côn Lôn): tìm hiểu lịch sử đấu tranh của tù chính trị Việt Nam",
      "17:00 — Nghĩa trang Hàng Dương: thăm mộ cô Sáu Võ Thị Sáu — nhân vật lịch sử huyền thoại",
      "19:00 — Tối hải sản tươi tại bến thuyền"
    ]
  },
  {
    "day": 3,
    "title": "Rừng Nguyên Sinh – Sân Bay – Về",
    "activities": [
      "07:00 — Trekking nhẹ trong Vườn Quốc Gia Côn Đảo: rừng nguyên sinh 100 năm, chim yến",
      "09:00 — Tắm biển lần cuối tại Bãi An Hội hoặc Bãi Lò Vôi",
      "11:00 — Check-out, ăn trưa nhẹ",
      "13:00 — Xe sân bay, bay về TP.HCM"
    ]
  }
]
```

---

## HÌNH ẢNH UNSPLASH ĐỀ XUẤT THEO ĐIỂM ĐẾN

| Điểm đến | URL Unsplash |
|---|---|
| Sa Pa ruộng bậc thang | `https://images.unsplash.com/photo-1558642084-fd07fae5282e?w=800&q=80` |
| Hạ Long vịnh | `https://images.unsplash.com/photo-1473186578172-c141e6798cf4?w=800&q=80` |
| Ninh Bình Tràng An | `https://images.unsplash.com/photo-1570959028052-f5a98eb22a7c?w=800&q=80` |
| Hội An đèn lồng | `https://images.unsplash.com/photo-1509030450996-dd1a26dda07a?w=800&q=80` |
| Huế Hoàng Thành | `https://images.unsplash.com/photo-1624526267942-1e7fe8e0b00f?w=800&q=80` |
| Đà Nẵng Cầu Rồng | `https://images.unsplash.com/photo-1552465011-b4e21bf6e79a?w=800&q=80` |
| Phú Quốc biển | `https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&q=80` |
| Mekong Delta | `https://images.unsplash.com/photo-1516026672322-bc52d61a9f3c?w=800&q=80` |
| Sài Gòn đường phố | `https://images.unsplash.com/photo-1555993539-1732b0258235?w=800&q=80` |
| Côn Đảo biển | `https://images.unsplash.com/photo-1509392676773-fd5dc56d1e48?w=800&q=80` |
| Hà Giang đèo | `https://images.unsplash.com/photo-1552465011-b4e21bf6e79a?w=800&q=80` |
| Đà Lạt sương mù | `https://images.unsplash.com/photo-1501854140801-50d01698950b?w=800&q=80` |

---

## BẢNG GIÁ PRIVATE THEO NHÓM (THAM KHẢO)

| Tour | 2 pax | 4 pax | 6–8 pax |
|---|---|---|---|
| Day tour Hà Nội | 1.800.000đ/người | 1.200.000đ/người | 950.000đ/người |
| Day tour Hội An | 1.500.000đ/người | 1.150.000đ/người | 900.000đ/người |
| Sa Pa 3N2Đ | 5.800.000đ/người | 4.200.000đ/người | 3.600.000đ/người |
| Hạ Long 2N1Đ | 5.200.000đ/người | 3.800.000đ/người | 3.200.000đ/người |
| Huế 2N1Đ | 3.800.000đ/người | 2.600.000đ/người | 2.100.000đ/người |
| Phú Quốc 4N3Đ | 12.000.000đ/người | 8.500.000đ/người | 7.200.000đ/người |
| Côn Đảo 3N2Đ | 14.000.000đ/người | 9.800.000đ/người | 8.500.000đ/người |

> **Lưu ý CMS:** `base_price` là giá tham khảo cho 4 pax. Giá 2 pax và 6+ pax ghi vào `notes` hoặc thêm field riêng sau.
