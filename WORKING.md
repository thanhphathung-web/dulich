# WORKING.md — Nhật ký làm việc & trạng thái hệ thống

> Cập nhật: 2026-07-14. File này ghi lại đợt audit + sửa lỗi "sẵn sàng bán hàng"
> (mục tiêu: bán 100 tour có doanh số thực). KHÔNG ghi secret vào file này — repo public.
> Mục 6 (dưới cùng): chương trình đăng tour hàng loạt + phiên 2026-07-14 (Nha Trang + fix filter).

## 0. Đợt 2026-07-10 → 07-11 (phiên lớn: UI + SEO + P0 database + email + RBAC)

### 0a. Trang chủ & SEO
- Footer: bỏ cột "Điểm đến" (tự sinh) → cột **"Loại tour"** (3 vùng miền + 10 sở thích,
  lưới 2 cột); nav "Tour" thành **dropdown hover** cùng phân loại. Link áp filter thật
  (đồng bộ chip trên trang) và nhảy tới #tours (`7dda4c5`).
- **🔥 BUG P0 phát hiện & sửa**: trang chi tiết tour (`/tour?slug=...`) trên production
  **treo "Đang tải..." vĩnh viễn** do đệ quy vô hạn `setDetailLang` ↔ `renderTour`
  (lỗi từ đợt i18n trước). Khách không xem được chi tiết tour nào cho tới bản vá
  (`5d395f8`). Đã test render + đổi ngôn ngữ VI/EN/ZH trên production.
- SEO: `sitemap.xml` 3 → 24 URL (20 tour + /chinh-sach; file tĩnh — thêm tour mới phải
  cập nhật); JSON-LD Product + meta description + canonical inject sau khi load tour
  (rating chỉ đưa khi có review thật); `404.html` tùy chỉnh theo style trang chủ.
- Lưu ý kỹ thuật: `html{scroll-behavior:smooth}` bị Chrome hủy scroll khi grid render
  lại → `scrollToTours()` phải dùng `behavior:'instant'` và gọi SAU khi loadTours xong.

### 0b. P0 database (3 migration, chạy qua Chrome → Dashboard SQL Editor, bơm SQL bằng monaco API)
- `tours-add-columns.sql` → bảng tours 58 cột (hết lỗi PGRST204 khi Đăng bán trong CMS).
- `tours-add-zh-columns.sql` → đủ 9 cột `_zh` cho tab dịch tiếng Trung.
- `rls-tours.sql` → 3 policy chuẩn; role admin (app_metadata) gán cho thanhphathung@gmail.com.
- Verify 2 chiều: anon qua REST chỉ thấy đúng 20 tour ACTIVE; chủ shop đăng nhập lại
  → **Đăng bán tour từ /cms thành công** (updated_at + các cột mới lưu đủ, hết 42501).

### 0c. Hệ thống email (Resend) — 3 luồng, CHẠY TRÊN PRODUCTION
- **Xác nhận đơn cho khách**: Kênh 2 trong trigger `notify_new_booking` (chi tiết mục 3).
- **Nhắc cọc + e-voucher**: 2 job pg_cron (chi tiết mục 3).
- Domain `baggio.website` verified trong Resend; 4 DNS record thêm vào Vercel DNS
  (MX + SPF trên `send`, DKIM `resend._domainkey` — dán qua clipboard, DMARC p=none).
- Màn hình đặt tour thành công giờ ghi "Email xác nhận đã gửi..." — lời hứa THẬT (`1950db5`).

### 0d. RBAC phân quyền nhân viên (Phases 1–4) — CHẠY TRÊN PRODUCTION
- **6 role**: admin / manager / sales / ops / accountant / content. Ma trận quyền từng
  bảng: `docs/rbac-plan.md` §3 (content không thấy PII khách + giá vốn; accountant chỉ đọc).
- **Cơ chế**: bảng `staff_roles` + `staff_role()`/`has_role()` (security definer) — đổi role
  hiệu lực NGAY không cần re-login; RPC `set_staff_role`/`remove_staff_role` admin-only,
  có guard **chống tự khóa admin cuối cùng**. File: `supabase/rbac-phase1.sql`.
- **RLS 10 bảng** viết lại theo ma trận qua `has_role_or_legacy()` — **fallback app_metadata
  admin còn giữ 1 nhịp, cần gỡ khi chạy ổn**. File: `supabase/rbac-phase2.sql`.
- **Guard client 9 trang nội bộ** (admin/report/comms/operations/guides-mgmt/suppliers/
  cms/tour-import/translate) — sai role đá về /account; CMS giữ kiểu banner cảnh báo.
- **Panel gán role trong /admin** → menu "🔐 Phân quyền nhân viên" (chỉ admin thấy):
  gán/thu hồi theo email. Nhân viên phải đăng nhập Google tại /account 1 lần trước.
- **Test**: mô phỏng JWT trong SQL editor (`set_config('request.jwt.claims',...)` +
  `set local role authenticated` + CTE `update...returning`, tất cả trong transaction
  rollback) — khách no-role bị chặn sạch; content sửa tour được nhưng mù bookings/
  suppliers/comms; accountant đọc 4 đơn nhưng không ghi được. Verify production:
  chủ shop vẫn vào /admin, panel hiện đúng 1 admin.

### 0e. 🔐 SỰ CỐ BẢO MẬT (cần chủ shop hoàn tất xử lý)
- Commit RBAC vô tình kéo file `resendapi.txt` (API key Resend chủ shop lưu trong thư mục
  repo) lên GitHub PUBLIC trong ~2 phút. Đã force-push gỡ khỏi toàn bộ lịch sử
  (`d38c0ea` → `8771095`) + thêm `.gitignore` (`resendapi*.txt`, `.tmp-*.txt`).
- **KEY PHẢI COI LÀ LỘ** → chủ shop cần: xóa key cũ trong Resend → tạo key mới → cập nhật
  Vault: `select vault.update_secret((select id from vault.secrets where name='resend_api_key'), 'KEY_MỚI');`
  Trong lúc chưa thay: email tạm ngừng, booking KHÔNG ảnh hưởng (function bỏ qua êm).
- Bài học: file secret KHÔNG để trong thư mục repo; kiểm tra `git status` trước `git add -A`.

### 0f. Commit đợt này (Vercel auto-deploy)
`7dda4c5` footer/nav loại tour · `5d395f8` fix tour detail + SEO + 404 · `a99cccd`/`cfe2208`/
`7c4def0` docs · `8292c70` email xác nhận đơn · `1950db5` success screen · `8fdcb11` cron
nhắc cọc + e-voucher · `b9b4191` merge rbac-design · `8771095` RBAC 1–3 (force-push sạch
secret) · `9dc6b63` docs.

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

1. **🔴 KHẨN — Chủ shop thay API key Resend** (bị lộ trong sự cố 0e): xóa key cũ trên
   resend.com/api-keys → tạo key mới → cập nhật Vault (câu SQL ở mục 0e). Chưa thay thì
   email xác nhận/nhắc cọc/e-voucher không gửi được (booking vẫn bình thường).
2. **Chủ shop cung cấp**: tên pháp nhân + MST + số GP lữ hành quốc tế → chèn footer. Nếu chưa có GP thì bỏ dòng claim ở footer.
3. **Chủ shop duyệt** các con số trong `chinh-sach-hoan-huy.html` (mức hoàn 50% khi hủy 3–6 ngày, đổi lịch miễn phí 1 lần… là bản nháp theo chuẩn ngành, khớp 3 mức `cancel_policy` trong CMS).
4. **MoMo/VNPay thật**: cần đăng ký merchant (MoMo Business / VNPay-QR) — làm khi có GP kinh doanh; kèm theo là webhook tự cập nhật payment_status (P0 còn lại duy nhất).
5. **RBAC nhịp 2**: gỡ fallback app_metadata admin trong `has_role_or_legacy` sau khi hệ thống chạy ổn vài tuần; gộp role nếu team nhỏ.
6. **P2/P3 (đã hoãn)**: GA4 + Meta Pixel, quyền ghi cho /operations, cân bằng danh mục tour (9/20 là Buôn Ma Thuột), nút Zalo float, xin review thật từ khách cũ, OG động cho trang tour.

## 5. Hạ tầng & cách vận hành (cho phiên sau)

- Site tĩnh HTML thuần trên Vercel, domain baggio.website (registrar + DNS đều Vercel); rewrite URL trong `vercel.json` (`/booking`, `/admin`, `/chinh-sach`…).
- DB: Supabase project `lfnlezfphwjtdunyungi`; tour ACTIVE hiện qua RLS; bookings: anon INSERT được, SELECT chỉ chủ đơn (JWT email) hoặc staff theo role.
- **Phân quyền**: bảng `staff_roles` (6 role) + `has_role()`; gán role qua /admin → "Phân quyền nhân viên". RLS là lớp bảo mật thật, guard client chỉ là UX.
- **Email**: Resend, from `booking@baggio.website`, key trong Supabase Vault (`resend_api_key`); 3 luồng: xác nhận đơn (trigger), nhắc cọc + e-voucher (pg_cron `baggio-deposit-reminders`, `baggio-evouchers`). Giới hạn 2 email/lượt (Resend free 2 req/s). Debug: `net._http_response`.
- Supabase CLI có sẵn tại `C:\Users\GlobalDMC\AppData\Local\supabase-cli\supabase.exe` nhưng **PAT đã revoke** — chạy SQL qua Dashboard SQL Editor (Chrome extension: bơm SQL bằng `monaco.editor.getModels()[0].setValue(...)`, KHÔNG gõ phím vào editor).
- Đặt cọc = 30% tổng tour; QR chuyển khoản vẽ qua `qr.sepay.vn` (TCB 4042828666 / TRAN HUNG VI).
- Đơn test trong DB (giữ theo ý chủ shop): TEST-PM-02, TEST-ROT-03, TEST-EMAIL-01, TEST-VOUCHER-01.

## 6. Chương trình đăng tour hàng loạt (day tour cho khách nước ngoài)

Mục tiêu chủ shop: tăng nhanh số tour bán được. Cách làm đã chốt (memory `tour-import-workflow`):
dữ liệu tour → Claude soạn bản nháp song ngữ VI/EN đầy đủ (highlights, lịch trình, includes/
excludes, mô tả, SEO meta) → chạy lên Supabase. **Quy trình mặc định là DRAFT→duyệt→ACTIVE**,
NHƯNG chủ shop đã chọn đăng thẳng ACTIVE theo TỪNG batch (hỏi rõ qua AskUserQuestion mỗi lần —
KHÔNG tự suy ra được phép ACTIVE cho batch sau).

### 6a. 4 batch đã chạy production (mỗi tour day_tour, duration_days=1)
| Batch | Slug | destination / region | File | Commit |
|---|---|---|---|---|
| TP.HCM | 10021→10030 | 'TP. Hồ Chí Minh' / south | `supabase/tours-hcmc-10.sql` | (đợt trước) |
| Hà Nội | 10031→10040 | 'Hà Nội' / north | `supabase/tours-hanoi-10.sql` | (đợt trước) |
| Đà Nẵng | 10041→10050 | 'Đà Nẵng' / central | `supabase/tours-danang-10.sql` | `eb943d5` |
| Nha Trang | 10051→10060 | 'Nha Trang' / central | `supabase/tours-nha-trang-10.sql` | `add5409` |
| Phú Quốc | 10061→10070 | 'Phú Quốc' / south | `supabase/tours-phu-quoc-10.sql` | `b8d99b1` |
| Sa Pa | 10071→10080 | 'Sa Pa' / north | `supabase/tours-sa-pa-10.sql` | `46a086c` |
| Hạ Long | 10081→10090 | 'Hạ Long' / north | `supabase/tours-ha-long-10.sql` | `cea1234` |

- Mỗi file **idempotent** (`WHERE NOT EXISTS` theo slug), chạy lặp không trùng.
- ⚠️ **Giá base_price là AI ƯỚC TÍNH thị trường 2026 + ảnh Unsplash placeholder** → chủ shop
  cần **rà giá thật + thay ảnh** trong CMS cho cả 70 tour này (việc còn treo).
- ⚠️ **Chỉ đưa tour chạy HÀNG NGÀY** vào batch (khớp auto-schedule). Tour theo lịch cố định
  (vd chợ phiên Bắc Hà chỉ Chủ Nhật) KHÔNG đưa vào — nếu cần phải thêm tay + lịch riêng.
- Khi soạn: tránh dấu `'` trong chuỗi (tên "H'Mông"→"Mông"/"Hmong") và dấu `"` lồng trong
  jsonb; validate `json.loads` mọi literal `'...'::jsonb` trước khi giao.

### 6b. Lịch khởi hành hàng ngày — tự nối vĩnh viễn
- Function `public.extend_day_tour_schedules()`: mọi tour ACTIVE có `duration_days=1` luôn được
  phủ đủ 60 ngày lịch tới (NOT EXISTS chống trùng, `total_slots=max_pax`, day tour →
  `return_date=depart_date`, `status='OPEN'`). Tour nhiều ngày KHÔNG đụng (lịch tay trong CMS).
- pg_cron `baggio-extend-day-tour-schedules` chạy 00:05 VN mỗi đêm (`'5 17 * * *'` UTC) —
  file `supabase/tours-schedules-cron.sql`. Mỗi file batch cũng gọi function này ở cuối để có
  lịch ngay không phải chờ cron. Day tour mới đăng sau này TỰ CÓ lịch sau 1 đêm.

### 6c. Phiên 2026-07-14 (chi tiết)
- **Batch Đà Nẵng** (10041→10050): file đã soạn từ trước, phiên này chủ shop chọn ACTIVE →
  chạy prod OK (mỗi tour 60 lịch), verify public đủ 10/10 + commit `eb943d5`.
- **Batch Nha Trang** (10051→10060): soạn mới 10 tour (4 đảo Hòn Mun, VinWonders, city tour +
  tắm bùn, Bình Hưng, Điệp Sơn, lặn Hòn Mun, Yang Bay, sông Cái, Dốc Lết, food tour đêm) →
  ACTIVE → verify public đủ 10/10 → commit `add5409`.
- **🔧 Fix filter điểm đến (commit `87f45dd`, đã deploy)**: verify batch Nha Trang phát hiện
  dropdown lọc "điểm đến" trong `index.html` dùng **danh sách 63 TỈNH** + `.eq('destination')`
  **exact-match**. Tour lưu destination theo TÊN THÀNH PHỐ khác tên tỉnh → không lọc ra được:
  'Nha Trang' vs tỉnh 'Khánh Hòa' (0 tour), 'TP. Hồ Chí Minh' vs 'Hồ Chí Minh' (0 tour — batch
  HCMC dính từ trước). Hà Nội/Đà Nẵng ok vì trùng tên tỉnh. **Sửa**: thêm `PROVINCE_CITIES`
  (map tỉnh→[thành phố]) trong index.html → lọc tỉnh dùng `.in([tỉnh, ...TP con])` bắt cả tour
  lưu theo tên TP; và thêm tên TP làm option chọn trực tiếp trong dropdown (khách nước ngoài
  tìm "Nha Trang"/"Hội An", không tìm "Khánh Hòa"). Badge card GIỮ tên TP (không đổi destination).
  Verify prod sau deploy: Khánh Hòa→11, Hồ Chí Minh→10, dropdown có option "Nha Trang"/"Hội An".
  - **BẢO TRÌ**: batch tour cho thành phố tên ≠ tên tỉnh (Sa Pa/Lào Cai, Đà Lạt/Lâm Đồng,
    Phú Quốc/Kiên Giang…) → nhớ thêm entry vào `PROVINCE_CITIES` mới lọc theo tỉnh được. Đã có
    sẵn 13 tỉnh: Khánh Hòa, Hồ Chí Minh, Quảng Nam, Thừa Thiên Huế, Lào Cai, Lâm Đồng, Quảng Ninh,
    Kiên Giang, Bình Thuận, Bà Rịa-Vũng Tàu, Bình Định, Đắk Lắk, Cần Thơ.
- Toàn bộ commit phiên này đã push `origin/main` (repo `thanhphathung-web/dulich`) → Vercel deploy.

### 6d. Cách deploy SQL phiên này (khác mục 5 — quan trọng)
- Cách bơm SQL tự động qua Chrome (monaco setValue) phiên này **thất bại**: máy chủ shop có
  **phần mềm quản lý clipboard chạy nền liên tục ghi đè clipboard Windows** (paste ra rác), và
  `navigator.clipboard.readText()` trong page làm **treo renderer + kẹt permission prompt** của
  extension. → Cách chạy được: **chủ shop tự copy file .sql → paste vào Supabase SQL Editor
  (tab mới) → Run**. Lần sau ưu tiên cách này ngay từ đầu.

### 6e. Việc còn treo (chương trình tour)
1. **Chủ shop rà giá thật + thay ảnh placeholder** cho 70 tour AI soạn (7 batch) trong CMS.
2. **sitemap.xml** → cập nhật đủ tới batch Hạ Long: 94 URL (4 tĩnh + 90 tour), khớp DB ACTIVE,
   XML hợp lệ. **LƯU Ý**: file TĨNH, thêm tour mới sau này vẫn phải cập nhật tay (nguồn chuẩn:
   `select slug from tours where status='ACTIVE'`).
3. Batch tiếp theo (nếu có): hỏi lại chủ shop ACTIVE hay DRAFT; nếu thành phố tên ≠ tỉnh thì
   cập nhật `PROVINCE_CITIES` (mục 6c).
