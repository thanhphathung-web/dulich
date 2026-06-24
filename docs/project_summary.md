# Baggio Travel — Project Summary

## 1. Tech Stack

| Layer | Công nghệ |
|---|---|
| **Frontend** | HTML/CSS/JS thuần (Single-file apps), không dùng framework |
| **Fonts/UI** | Be Vietnam Pro, Playfair Display / Cormorant Garamond, Space Mono, DM Sans |
| **Charts** | Chart.js (dùng trong Admin & Report) |
| **Backend API** | Node.js 20 + Express 5 |
| **ORM** | Prisma ORM |
| **Database** | PostgreSQL (qua Supabase) |
| **BaaS** | Supabase (Auth, Realtime, REST auto-API) |
| **Email** | Resend API + React Email (transactional) |
| **Validation** | Zod |
| **AI Chatbot** | Anthropic Claude API (key nhập tại runtime) |
| **Deploy** | Vercel (frontend + backend), Supabase (DB) |
| **Security** | Helmet, CORS whitelist, express-rate-limit, JWT |

---

## 2. Cấu trúc thư mục chính

```
baggio-travel/
├── index.html                  # Trang chủ (website public)
├── baggio-website.html         # Brand/creative landing page (dark mode)
├── baggio-tour-detail.html     # Trang chi tiết tour
├── baggio-booking-engine.html  # Booking flow (UI prototype/static)
├── baggio-booking-live.html    # Booking flow (kết nối Supabase thực)
├── baggio-chatbot.html         # AI Chatbot widget
│
├── baggio-admin.html           # Admin dashboard (tổng quan + bookings)
├── baggio-cms.html             # CMS: quản lý tour & blog
├── baggio-guides-mgmt.html     # Quản lý hướng dẫn viên (HDV)
├── baggio-suppliers.html       # Quản lý nhà cung cấp
├── baggio-operations.html      # Vận hành tour (checklist)
├── baggio-comms.html           # Communication log (Zalo/Email/SMS)
├── baggio-report.html          # Báo cáo kinh doanh
│
├── baggio-email-system.html    # Tài liệu + preview email templates
├── baggio-backend-api.html     # Tài liệu Backend API (Node/Express)
├── baggio-database-schema.html # Database schema / ERD viewer
├── baggio-deploy-guide.html    # Hướng dẫn deploy (dark, chi tiết)
├── baggio-deploy-free.html     # Hướng dẫn deploy miễn phí
└── baggio-seo-guide.html       # SEO guide cho website

Backend (tham chiếu từ baggio-backend-api.html):
src/
├── app.ts                      # Express app setup
├── routes/
│   ├── tours.ts
│   ├── bookings.ts
│   ├── payments.ts
│   ├── auth.ts
│   ├── users.ts
│   └── guides.ts
├── middleware/
│   ├── auth.ts                 # JWT middleware
│   └── errors.ts               # Global error handler
└── lib/
    ├── db.ts                   # Prisma client
    ├── email.ts                # Resend helper
    └── utils.ts
prisma/
├── schema.prisma
└── migrations/
```

---

## 3. Tính năng / Logic cốt lõi

### `index.html` — Trang chủ
Trang public chính kết nối Supabase để load danh sách tour thật. Có Trip Planner form (lọc điểm đến, ngày, số người, sở thích) và hiển thị kết quả tour dạng card. Hỗ trợ đa ngôn ngữ (VI/EN).

### `baggio-tour-detail.html` — Chi tiết tour
Trang tour chi tiết load dữ liệu từ Supabase theo tour ID. Hiển thị lịch trình theo ngày, bao gồm/không bao gồm, review/đánh giá và sidebar booking card với lịch khởi hành còn chỗ.

### `baggio-booking-live.html` — Booking flow (live)
Flow đặt tour 5 bước: chọn tour → chọn ngày (calendar) → chọn số khách & phòng → nhập thông tin liên hệ → thanh toán. Kết nối Supabase thực, ghi booking vào DB.

### `baggio-chatbot.html` — AI Chatbot
Chatbot tư vấn du lịch dùng Claude API (key nhập qua modal khi mở). Có quick-reply chips, hiển thị mini tour card trong bubble, side panel xem thông tin tour được hỏi.

### `baggio-admin.html` — Admin Dashboard
Dashboard quản trị với stats cards (doanh thu, booking, tỷ lệ hủy...), charts Chart.js, bảng bookings với filter/search/action. Kết nối Supabase, hỗ trợ confirm/cancel booking.

### `baggio-cms.html` — Content Management
CMS hai-pane: list tour bên trái, form chỉnh sửa bên phải. Quản lý cả tour lẫn blog. Có validation fields (OK/warn/err), upload ảnh grid, tag checkboxes, star rating.

### `baggio-guides-mgmt.html` — Quản lý HDV
Quản lý hướng dẫn viên: grid card với stats (tours, rating, revenue), mini calendar lịch bận/rảnh, tab profile/lịch/đánh giá/KPI. Kết nối Supabase.

### `baggio-suppliers.html` — Nhà cung cấp
Danh sách nhà cung cấp (khách sạn, xe, nhà hàng...) dạng card với giá hợp đồng vs thị trường, margin, rating. Hỗ trợ filter theo category và CRUD qua modal.

### `baggio-operations.html` — Vận hành tour
Checklist vận hành cho từng tour đang chạy (flight, hotel, transport, food, guide). Có progress bar tổng thể, thêm task mới, deadline tracking, note modal.

### `baggio-comms.html` — Communication Log
Quản lý lịch sử liên lạc với khách hàng theo booking. Hỗ trợ nhiều kênh (Zalo, Email, SMS, Call, Meeting), tạo reminder, templates tin nhắn nhanh.

### `baggio-report.html` — Báo cáo
Báo cáo kinh doanh với filter theo tháng/quý/năm. Hiển thị stats cards, charts doanh thu theo ngày, bảng top tours/guides. Xuất PDF & CSV, hỗ trợ print styles.

### `baggio-email-system.html` — Email System
Tài liệu 5 email templates tự động: xác nhận đặt tour, thanh toán thành công, nhắc lịch 48h, yêu cầu review, hủy & hoàn tiền. Dùng Resend API + React Email, preview HTML inline.

### `baggio-backend-api.html` — Backend API Docs
Tài liệu API Node.js/Express gồm: kiến trúc request lifecycle, JWT auth middleware, rate limiting (100 req/15min), các endpoint REST cho tours/bookings/payments/users/guides.

### `baggio-database-schema.html` — Database Schema
Viewer ERD và schema chi tiết cho các bảng: `users`, `tours`, `bookings`, `payments`, `guides`, `reviews`, `notifications`, `sessions`. Có tab ERD view và schema detail view.

### `baggio-seo-guide.html` — SEO Guide
Hướng dẫn SEO kỹ thuật cho website: meta tags, schema.org structured data (TouristTrip, BreadcrumbList), SERP preview, performance checklist, sitemap/robots.txt.

---

## 4. Biến môi trường & Cấu hình quan trọng

### Supabase (Frontend — khai báo đầu mỗi file live)
```js
const SUPABASE_URL  = 'https://lfnlezfphwjtdunyungi.supabase.co'
const SUPABASE_ANON = 'eyJhbGci...'  // anon public key
```
> Các file đã có URL/key thật: `index.html`, `baggio-booking-live.html`, `baggio-cms.html`, `baggio-comms.html`, `baggio-guides-mgmt.html`, `baggio-operations.html`, `baggio-report.html`, `baggio-suppliers.html`, `baggio-tour-detail.html`
>
> Các file cần điền: `baggio-admin.html`, `baggio-booking-engine.html` (có placeholder `xxxx`)

### Backend (`.env`)
```env
DATABASE_URL=postgresql://...    # Supabase DB connection string
DIRECT_URL=postgresql://...      # Cho Prisma migrations
JWT_SECRET=...
JWT_EXPIRES_IN=7d
RESEND_API_KEY=re_...
FROM_EMAIL=booking@baggiotravel.com
FRONTEND_URL=https://baggiotravel.com
```

### CORS Whitelist (src/app.ts)
```js
origin: ['https://baggiotravel.com', 'http://localhost:3000']
```

### Rate Limiting
- Global: 100 requests / 15 phút / IP
- Webhook endpoint (`/api/payment/webhook`): dùng `express.raw()` để verify signature

### AI Chatbot
- Claude API key: nhập tại runtime qua modal (không hardcode), gọi thẳng từ browser
- Model được dùng: Claude (xác nhận version khi tích hợp thật)

---

*Cập nhật: tuần 1 dự án — 19 HTML files, chủ yếu single-file apps kết nối Supabase trực tiếp từ frontend.*
