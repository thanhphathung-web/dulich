# 🎒 Baggio Travel — Lộ trình phát triển (TODO)

> Cập nhật: 2026-07-08 · Dựa trên hiện trạng code thực tế trong repo.
> Quy ước ưu tiên: **P0** = chặn go-live / ảnh hưởng doanh thu · **P1** = trải nghiệm & tin cậy khách · **P2** = vận hành nội bộ · **P3** = tăng trưởng/SEO · **P4** = kỹ thuật/bảo trì.
>
> Đánh dấu: `[ ]` chưa làm · `[~]` đang làm · `[x]` xong. Dòng ⚠️ = việc chủ web phải tự chạy (Claude không thao tác được).

---

## 🚦 P0 — Chặn go-live / ảnh hưởng trực tiếp doanh thu

### Cơ sở dữ liệu (cần chạy tay trong Supabase SQL Editor)
- [x] ⚠️ Chạy `supabase/tours-add-columns.sql` — ✔ Đã chạy trên production 2026-07-11 (bảng tours giờ 58 cột).
- [x] ⚠️ Chạy `supabase/tours-add-zh-columns.sql` — ✔ Đã chạy trên production 2026-07-11 (đủ 9 cột `_zh`).
- [x] ⚠️ Chạy `supabase/suppliers.sql` — tạo bảng `suppliers` + `supplier_transactions` + RLS cho trang `/suppliers`. ✔ Đã chạy trên production 2026-07-08.
- [x] ⚠️ Chạy `supabase/comms.sql` — tạo bảng `communications` + `comm_reminders` + RLS cho trang `/comms`. ✔ Đã chạy trên production 2026-07-09.
- [x] ⚠️ Chạy `supabase/rls-tours.sql` — ✔ Đã chạy trên production 2026-07-11: 3 policy chuẩn, role admin đã gán cho `thanhphathung@gmail.com`. ⚠️ **CHỦ SHOP PHẢI ĐĂNG XUẤT/ĐĂNG NHẬP LẠI** rồi thử Lưu 1 tour trong /cms (JWT cũ chưa có role).
- [x] Kiểm tra lại toàn bộ RLS đã đúng — ✔ 2026-07-11: anon chỉ đọc tour `ACTIVE` (verify qua REST); admin sau khi đăng nhập lại ĐÃ ghi được từ CMS (test Đăng bán tour "Mùa Hoa Cà Phê" — updated_at + các cột mới lưu đủ, hết PGRST204/42501).

### Thanh toán (hiện tại: chuyển khoản thủ công + xác nhận qua Zalo)
- [ ] Tích hợp cổng thanh toán tự động (**VNPay** hoặc **Momo**) — hiện `baggio-vnpay.html`/`baggio-momo-integration.html` mới chỉ là **tài liệu hướng dẫn**, chưa nối vào luồng đặt tour thật.
- [ ] Serverless function tạo & verify signature thanh toán (không để secret key ở client). Vercel Functions (Node.js) là chỗ đặt hợp lý.
- [ ] Webhook cập nhật trạng thái booking `PENDING → SUCCESS` tự động khi thanh toán thành công (thay cho việc admin đối soát tay).
- [ ] Xử lý callback/return URL: trang "thanh toán thành công / thất bại" cho khách.

### Email / thông báo tự động
- [ ] Gửi **email xác nhận đặt tour tự động** — trang success đang *hứa* "email trong 2 tiếng" nhưng `baggio-email-system.html` mới là tài liệu, chưa chạy thật. Cần nối Resend/SendGrid qua serverless function.
- [ ] Email nhắc thanh toán cọc + email e-voucher trước ngày khởi hành.
- [ ] (Tuỳ chọn) Thông báo Zalo/SMS cho admin khi có đơn mới.

---

## 🧭 P1 — Trải nghiệm khách & độ tin cậy

### Tài khoản khách hàng (`/account`)
- [ ] Thêm phương thức đăng nhập ngoài Google: **email/mật khẩu** và/hoặc **OTP số điện thoại** (khách VN nhiều người không dùng Google).
- [ ] Hoàn thiện chức năng **Xoá tài khoản** — hiện chỉ hiện "Feature coming soon" (`baggio-account.html:556`).
- [ ] Trang "Đơn đặt tour của tôi": trạng thái đơn, hoá đơn/e-voucher tải về, nút huỷ/đổi lịch.

### Luồng đặt tour (`/booking`)
- [ ] Xác nhận cơ chế giữ chỗ (slot reserve/release RPC đã có) hoạt động đúng khi nhiều khách đặt cùng lúc; xử lý khi hết chỗ.
- [ ] Validate ngày khởi hành theo lịch tour thật (không cho chọn ngày không có chuyến).
- [ ] Trang chi tiết tour: đảm bảo mọi field hiển thị đủ sau khi chạy migration (mô tả, không bao gồm, video, chính sách huỷ...).

### Nội dung & tin cậy
- [ ] Ảnh tour thật thay cho ảnh Unsplash placeholder (ví dụ `sumImg` trong booking).
- [ ] Trang chính sách: **Điều khoản**, **Bảo mật**, **Chính sách huỷ/hoàn tiền** (bắt buộc cho trang có thanh toán).
- [ ] Đánh giá/review khách hàng thật trên trang chi tiết tour.

---

## 🛠️ P2 — Vận hành nội bộ (admin / CMS / ops) · ~80% xong

> Rà soát 2026-07-08, cập nhật 2026-07-09. Tình trạng nối Supabase:
> **Xong (DB thật):** `/admin` · `/guides-mgmt` · `/report` · `/suppliers` · `/comms`
> **Một phần:** `/operations` (chỉ đọc — muốn ghi/phân công ngay tại đây thì cần thêm)
> **Còn hở chính:** chưa phân quyền nhân viên (chỉ có 1 role admin)

- [x] **Báo cáo doanh thu** (`/report`) — số liệu thật từ `bookings`, có so sánh kỳ trước. ✔
- [x] **`/admin`** — CRUD đầy đủ: xác nhận/huỷ đơn, phân HDV, publish/xoá review, xem tours (`bookings`, `tours`, `guides`, `reviews`, `tour_schedules`). ✔
- [x] **`/guides-mgmt`** — CRUD `guides` đầy đủ, tính lương, xếp hạng từ reviews. ✔
- [x] **`/suppliers` — ĐÃ nối Supabase** (2026-07-08). Bỏ localStorage + seed giả; CRUD NCC & giao dịch chạy trên bảng `suppliers` + `supplier_transactions`, RLS admin-only. ⚠️ **Cần chạy `supabase/suppliers.sql`** trong SQL Editor để tạo bảng trước khi dùng.
- [x] **`/comms` — ĐÃ lưu log lên server** (2026-07-09). Nhật ký liên lạc + nhắc nhở chuyển từ localStorage sang bảng `communications` + `comm_reminders` (RLS admin-only); staff_name lấy từ email đăng nhập. ⚠️ Cần chạy `supabase/comms.sql` (đã chạy trên production). "Gửi" vẫn là deeplink Zalo thủ công — việc ghi nhận liên lạc giờ đồng bộ đa thiết bị.
- [ ] **`/operations` — hiện chỉ đọc.** Dashboard điều phối read-only; nếu muốn phân công/đổi lịch ngay tại đây thì cần thêm thao tác ghi (giờ phải làm ở `/admin`).
- [ ] **Phân quyền nhân viên** — mới chỉ có 1 role `admin` (ai đăng nhập admin cũng full quyền). Cần role-based access (điều phối viên / kế toán / HDV...) trong RLS.
- [ ] Đối soát thanh toán trong `/admin`: hiện **thủ công** (đọc `payment_status`, xác nhận tay) → chuyển tự động sau khi có webhook (phụ thuộc P0).
- [ ] Quy trình đăng tour hàng loạt theo memory: nhập dữ liệu THẬT → AI soạn nháp song ngữ (`DRAFT`) → người duyệt → `ACTIVE`. **Không auto-publish.** *(chưa xác minh trong lượt rà soát này)*

---

## 📈 P3 — SEO / Marketing / Tăng trưởng

- [x] Mở rộng `sitemap.xml` — đã thêm 20 URL tour (`/tour?slug=...`) + `/chinh-sach` (2026-07-11). ⚠️ Sitemap là file tĩnh: khi thêm/gỡ tour cần cập nhật lại.
- [x] Thêm structured data — JSON-LD `Product` (giá, brand, rating thật nếu có review) + meta description + canonical, inject sau khi load tour (2026-07-11).
- [ ] Cài Google Analytics / GA4 (hướng dẫn có sẵn trong `baggio-seo-guide.html`, cần gắn thật `G-XXXXXXXXXX`).
- [ ] Meta tags / OpenGraph động cho trang chi tiết tour (chia sẻ Facebook/Zalo đẹp).
- [ ] Trang blog/cẩm nang du lịch để kéo traffic organic.
- [ ] Đa ngôn ngữ: kiểm tra VI/EN/ZH đầy đủ trên mọi trang khách xem.

---

## 🧰 P4 — Kỹ thuật / Bảo trì

- [ ] Rà soát API key để lộ ở client: chatbot & tour-import nhập key lúc chạy (OK), nhưng đảm bảo **không** commit Supabase service_role key hay secret cổng thanh toán.
- [ ] Cân nhắc tách JS/CSS inline khổng lồ (index.html ~82KB, cms.html ~118KB) để dễ bảo trì — hoặc chấp nhận đánh đổi vì đang là static.
- [ ] Backup định kỳ database Supabase.
- [x] Trang 404 tuỳ chỉnh — `404.html` theo style trang chủ, Vercel tự nhận (2026-07-11).
- [ ] Kiểm thử responsive/mobile toàn bộ luồng đặt tour.
- [ ] Dọn các trang "tài liệu" khỏi production nếu không cần (đã `Disallow` trong robots.txt nhưng vẫn truy cập được qua URL).

---

## ✅ Đã xong gần đây (tham khảo, từ git log)
- [x] Sửa modal xem nhanh tour ở trang chủ (lịch trình, khoá scroll, includes)
- [x] Thêm tab dịch tiếng Trung (ZH) vào CMS tours
- [x] Script SQL dọn tour giả, giữ ~20 tour thật
- [x] RPC giữ/nhả chỗ nguyên tử (atomic slot reserve/release) + nối vào luồng đặt tour
- [x] RLS cho bảng CMS/khách hàng; vá lỗ rò rỉ PII ở bookings
- [x] Khôi phục trang đăng nhập trên production (`/account`)
- [x] Công cụ dịch tên tour hàng loạt (`/translate`)

---

*File này là bản nháp lộ trình do Claude tạo dựa trên đọc code. Hãy chỉnh sửa/ưu tiên lại theo nhu cầu kinh doanh thực tế của bạn.*
