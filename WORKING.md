# WORKING.md — Nhật ký làm việc & trạng thái hệ thống

> Cập nhật: 2026-07-11. File này ghi lại đợt audit + sửa lỗi "sẵn sàng bán hàng"
> (mục tiêu: bán 100 tour có doanh số thực). KHÔNG ghi secret vào file này — repo public.

## 0. Đợt 2026-07-11

- **3 migration P0 ĐÃ CHẠY trên production** (qua Chrome → Dashboard SQL Editor,
  paste bằng monaco API): `tours-add-columns.sql` (58 cột), `tours-add-zh-columns.sql`
  (9 cột _zh), `rls-tours.sql` (3 policy chuẩn + role admin cho thanhphathung@gmail.com).
  Verify: anon qua REST chỉ thấy đúng 20 tour ACTIVE. **Chủ shop cần đăng xuất/đăng
  nhập lại rồi thử Lưu tour trong /cms** (JWT cũ chưa mang role admin).

- **🔥 BUG P0 phát hiện & sửa**: trang chi tiết tour (`/tour?slug=...`) trên production
  **treo "Đang tải..." vĩnh viễn** do đệ quy vô hạn `setDetailLang` ↔ `renderTour`
  (lỗi từ đợt i18n trước, RangeError trong console). Khách không xem được chi tiết
  tour nào cho đến bản vá này. Đã test lại render + đổi ngôn ngữ VI/EN/ZH.
- Trang chủ: bỏ cột "Điểm đến" footer → cột "Loại tour" (3 vùng + 10 sở thích);
  nav "Tour" thành dropdown cùng phân loại; link áp filter và nhảy tới #tours (`7dda4c5`).
- SEO: sitemap.xml thêm 20 URL tour + /chinh-sach (file tĩnh — thêm tour mới phải cập nhật);
  JSON-LD Product + meta description + canonical trên trang chi tiết tour; 404.html mới.
- Lưu ý kỹ thuật: `html{scroll-behavior:smooth}` trên trang chủ bị Chrome hủy scroll
  khi grid render lại → hàm `scrollToTours()` phải dùng `behavior:'instant'`.

## 1. Kết quả audit trang chủ (2026-07-10, sáng)

Dữ liệu thực tế lúc audit: 20 tour ACTIVE · 80 lịch khởi hành OPEN · 5 HDV · **0 review** · og-cover.jpg 404.

Kết luận: giao diện đủ tốt để bán — thứ chặn doanh số là khâu chốt đơn và niềm tin:

| # | Vấn đề | Mức | Trạng thái |
|---|---|---|---|
| 1 | Số Zalo GIẢ `090 123 4567` trong hướng dẫn chuyển khoản; `0901234567` ở nút Zalo/Gọi trang tour detail | P0 | ✅ Đã sửa → 0906 306 286 |
| 2 | Nút MoMo/VNPay giả (không thanh toán thật, khách tưởng đã trả tiền) | P0 | ✅ Đã gỡ, QR chuyển khoản mặc định, ghi "sắp ra mắt" |
| 3 | Không ai được báo khi có đơn mới (booking chỉ nằm trong DB) | P0 | ✅ Trigger + push ntfy (xem mục 3) |
| 4 | Claim 4.9★ trong khi 0 review | P1 | ✅ Gỡ; section review tự ẩn khi trống, hiện điểm TB thật khi có |
| 5 | Footer thiếu số giấy phép lữ hành, tên pháp nhân, MST | P1 | ⏳ CHỜ chủ shop cung cấp |
| 6 | Chính sách hoàn hủy là link chết `#` | P1 | ✅ Trang `/chinh-sach` (chinh-sach-hoan-huy.html) |
| 7 | og-cover.jpg 404 → share FB/Zalo không có ảnh | P1 | ✅ Ảnh 1200×630 |
| 8 | Link Admin/Quản lý/Báo cáo lộ trên nav+footer trang khách | P1 | ✅ Đã gỡ (admin vẫn vào qua /admin) |
| 9 | Chưa có GA4/Meta Pixel; danh mục lệch (9/20 tour BMT); Zalo float ở trang chủ | P2 | ⏭ User quyết định bỏ qua đợt này |

Bug nhỏ đã sửa kèm: review đọc `r.tours?.name` sai cột → `name_vi`; load review lỗi giờ ẩn section thay vì treo skeleton; màn hình đặt tour thành công bỏ lời hứa "email xác nhận trong 2 tiếng" (chưa có hệ thống email), thay bằng hướng dẫn nhắn Zalo.

## 2. Các commit đã deploy (Vercel auto-deploy từ main)

| Commit | Nội dung |
|---|---|
| `fb306c8` | Sửa số điện thoại giả + lời hứa success screen + file SQL notify |
| `3740f07` | P1: gỡ 4.9★, trang chính sách, og-cover.jpg, gỡ link admin, bỏ "Inc." |
| `2ad167d` | Gỡ MoMo/VNPay, QR mặc định, lưu payment_method (fallback 42703) |

Tất cả đã verify trên https://baggio.website sau deploy (curl check số cũ = 0 chỗ, trang chính sách 200, og-cover 200).

## 3. Hệ thống báo đơn mới (đang chạy trên production)

- Trigger `trg_notify_new_booking` (AFTER INSERT trên `bookings`) → hàm `public.notify_new_booking()` → `net.http_post` (pg_net) đẩy push lên **ntfy.sh**.
- Nội dung push: mã đơn, tour, ngày đi, tên khách, SĐT, email, số khách, tổng tiền, cọc 30%, **phương thức thanh toán**, ghi chú.
- Lỗi gửi được nuốt trong exception handler — không bao giờ chặn việc tạo booking.
- File: `supabase/notify-new-booking.sql` — **topic trong file là placeholder**; topic thật là bí mật (repo public, ai biết topic đọc được PII khách). Topic thật lưu ngoài repo (chủ shop giữ, xem Zalo/ghi chú riêng).
- Đã thêm cột `bookings.payment_method` (text): BANK_TRANSFER / CASH.
- Đã test end-to-end 2 lần (insert thật qua anon REST → nhận push). Đơn test `TEST-PM-02`/`TEST-ROT-03`: chủ shop quyết định GIỮ LẠI, không cần xóa (2026-07-11) — đừng hỏi lại.
- **Kênh email ĐÃ NỐI (2026-07-11)**: Resend, gửi email xác nhận cho KHÁCH (guest_email) khi có booking.
  - Domain `baggio.website` verified trong Resend (4 DNS record trên Vercel: MX+SPF trên `send`, DKIM `resend._domainkey`, DMARC p=none). From: `booking@baggio.website`, reply-to Gmail chủ shop.
  - API key nằm trong Supabase Vault tên `resend_api_key` (chủ shop tự dán). Function đọc key runtime — không có key thì bỏ qua email, không chặn booking.
  - Migration: `supabase/booking-confirm-email.sql` — vá function TẠI CHỖ (giữ topic ntfy bí mật; lưu ý body function trên DB dùng CRLF). Nếu chạy lại `notify-new-booking.sql` phải chạy lại file email sau đó.
  - Test end-to-end OK: đơn `TEST-EMAIL-01` → ntfy 200 + Resend 200 (kiểm tra qua `net._http_response`). Debug sau này: `select id,status_code,left(content::text,200) from net._http_response order by id desc;`
- **Email nhắc cọc + e-voucher (2026-07-11, cùng ngày)**: 2 job pg_cron — xem `supabase/booking-emails-cron.sql`.
  - `baggio-deposit-reminders` (mỗi giờ :15): đơn payment PENDING quá 24h (≤7 ngày, chưa hủy), nhắc đúng 1 lần (`deposit_reminder_sent_at`), chỉ gửi 8h–20h VN.
  - `baggio-evouchers` (mỗi giờ 8:45–19:45 VN): đơn CONFIRMED+SUCCESS có lịch đi trong ≤2 ngày (`voucher_sent_at`), kèm tên/SĐT HDV nếu đã phân công.
  - ⚠️ **Resend free = 2 request/giây** → mỗi lượt cron chỉ gửi tối đa 2 email (đã dính 429 khi burst 3 email lúc test). Mọi email trong 1 transaction commit cùng lúc → pg_net bắn burst; đừng gộp nhiều email 1 lượt.
  - Test cả 2 luồng OK (TEST-EMAIL-01 nhắc cọc, TEST-VOUCHER-01 e-voucher — đơn voucher giữ lại, lịch test FULL đã xóa).

## 4. Việc còn treo

1. **Chủ shop cung cấp**: tên pháp nhân + MST + số GP lữ hành quốc tế → chèn footer. Nếu chưa có GP thì bỏ dòng claim ở footer.
2. **Chủ shop duyệt** các con số trong `chinh-sach-hoan-huy.html` (mức hoàn 50% khi hủy 3–6 ngày, đổi lịch miễn phí 1 lần… là bản nháp theo chuẩn ngành, khớp 3 mức `cancel_policy` trong CMS).
3. **MoMo/VNPay thật**: cần đăng ký merchant (MoMo Business / VNPay-QR) — làm khi có GP kinh doanh; UI chỉ cần thêm lại nút + redirect.
4. **Email báo đơn qua Resend** (khi user sẵn sàng đăng ký).
5. **P2 (đã hoãn)**: GA4 + Meta Pixel, cân bằng danh mục tour (9/20 là Buôn Ma Thuột), nút Zalo float trang chủ, xin review thật từ khách cũ.

## 5. Hạ tầng & cách vận hành (cho phiên sau)

- Site tĩnh HTML thuần trên Vercel, domain baggio.website; rewrite URL trong `vercel.json` (`/booking`, `/admin`, `/chinh-sach`…).
- DB: Supabase project `lfnlezfphwjtdunyungi`; tour ACTIVE hiện qua RLS; bookings: anon INSERT được, SELECT chỉ chủ đơn (JWT email) hoặc admin.
- Supabase CLI có sẵn tại `C:\Users\GlobalDMC\AppData\Local\supabase-cli\supabase.exe` nhưng **PAT đã revoke** — chạy SQL bằng Dashboard SQL Editor (user tự dán hoặc qua Chrome extension khi có quyền).
- Đặt cọc = 30% tổng tour; QR chuyển khoản vẽ qua `qr.sepay.vn` (TCB 4042828666 / TRAN HUNG VI).
