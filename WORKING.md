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

Claude soạn bản nháp song ngữ VI/EN đầy đủ → chạy lên Supabase. Mặc định DRAFT→duyệt→ACTIVE,
nhưng chủ shop chọn ACTIVE thẳng theo TỪNG batch (hỏi qua AskUserQuestion mỗi lần). Chi tiết
vận hành: memory `tour-import-workflow` + `tour-catalog-design-decisions`.

### 6a. 8 batch đã chạy production — 80 tour (2026-07-14 → 07-15)
| Batch | Slug | destination / region | File | Commit |
|---|---|---|---|---|
| TP.HCM | 10021→10030 | 'TP. Hồ Chí Minh' / south | `tours-hcmc-10.sql` | (đợt trước) |
| Hà Nội | 10031→10040 | 'Hà Nội' / north | `tours-hanoi-10.sql` | (đợt trước) |
| Đà Nẵng | 10041→10050 | 'Đà Nẵng' / central | `tours-danang-10.sql` | `eb943d5` |
| Nha Trang | 10051→10060 | 'Nha Trang' / central | `tours-nha-trang-10.sql` | `add5409` |
| Phú Quốc | 10061→10070 | 'Phú Quốc' / south | `tours-phu-quoc-10.sql` | `b8d99b1` |
| Sa Pa | 10071→10080 | 'Sa Pa' / north | `tours-sa-pa-10.sql` | `46a086c` |
| Hạ Long | 10081→10090 | 'Hạ Long' / north | `tours-ha-long-10.sql` | `cea1234` |
| Bền vững | 10091→10100 | THEME eco, 10 điểm khác nhau | `tours-ben-vung-10.sql` | `04da6b7` |

Batch 8 khác 7 batch trước: **CHỦ ĐỀ, không phải 1 TP** — 10 điểm eco trải khắp VN;
gồm **4 tour NHIỀU NGÀY** (Pù Luông/Mai Châu/Hà Giang 3N/Mekong) nên file có INSERT lịch
TAY (`generate_series` mỗi 3 ngày) vì `extend_day_tour_schedules()` chỉ phủ tour 1 ngày.
Verify REST: 10/10 ACTIVE, lịch 60 (tour ngày) / 20 (tour nhiều ngày). 8 điểm mới đã thêm
vào `PROVINCE_DESTS` + `DEST_INTEREST_MAP` (region khớp bucket tỉnh trong `PROVINCES`).

File idempotent (`WHERE NOT EXISTS` theo slug). Filter fix `87f45dd`. Mỗi batch: verify (public
hoặc REST đủ 10/10) → sitemap → commit → push (`origin/main`, repo `thanhphathung-web/dulich`).

### 6b. Lịch tự nối vĩnh viễn
`public.extend_day_tour_schedules()`: mọi tour ACTIVE `duration_days=1` luôn được phủ 60 ngày lịch
tới (NOT EXISTS chống trùng, `total_slots=max_pax`, `return_date=depart_date`, `status='OPEN'`);
tour nhiều ngày không đụng. pg_cron `baggio-extend-day-tour-schedules` chạy 00:05 VN (`'5 17 * * *'`
UTC, `supabase/tours-schedules-cron.sql`); mỗi file batch cũng gọi hàm ở cuối để có lịch ngay.

### 6c. Quyết định thiết kế catalog (ĐỌC TRƯỚC KHI SỬA)
1. **`destination` = TÊN THÀNH PHỐ hướng khách, KHÔNG phải tên tỉnh** ('Nha Trang', 'Hạ Long',
   'Hội An', 'TP. Hồ Chí Minh'…). Badge card hiện thẳng `destination`. Vì khách Tây search tên TP.
2. **Filter tỉnh bắc cầu ở FRONTEND (`PROVINCE_CITIES` trong index.html), KHÔNG normalize DB.**
   Dropdown liệt kê 34 tỉnh (sau sáp nhập 1/7/2025); query `.in([tỉnh, ...TP con])` để chọn tỉnh
   bắt cả tour tên TP, và render tên TP thành option chọn trực tiếp. **⚠ Bảo trì:** batch cho TP
   tên ≠ tỉnh phải thêm entry vào `PROVINCE_CITIES`. Sau sáp nhập, một số TP đổi tỉnh chủ quản:
   Hội An→Đà Nẵng, Phú Quốc→An Giang, Vũng Tàu→Hồ Chí Minh, Quy Nhơn→Gia Lai, Phan Thiết/Mũi Né→
   Lâm Đồng (giữ: Nha Trang→Khánh Hòa, Sa Pa→Lào Cai, Đà Lạt→Lâm Đồng, Hạ Long→Quảng Ninh,
   Buôn Ma Thuột→Đắk Lắk, Mê Kông→Cần Thơ).
   **KHÔNG** sửa bằng cách đổi `destination` sang tên tỉnh.
3. **Batch chỉ nhận tour CHẠY HÀNG NGÀY** (khớp auto-schedule). Tour lịch cố định (chợ Bắc Hà chỉ
   CN) / cruise ngủ đêm → nhập tay + lịch riêng, tránh auto-fill sinh ngày đặt sai.
4. **sitemap.xml TĨNH** — thêm/gỡ tour cập nhật tay từ `select slug from tours where status='ACTIVE'`.
   Trang detail: `/tour?slug=...`.
5. **Soạn file**: tránh dấu `'` trong chuỗi (tên "H'Mông"→"Mông"/"Hmong"), tránh `"` lồng trong
   jsonb; validate `json.loads` mọi literal `'...'::jsonb` trước khi giao.

### 6d. Deploy SQL (khác mục 5)
Bơm tự động qua Chrome (monaco setValue) **thất bại** phiên này: phần mềm clipboard nền ghi đè
clipboard Windows, `navigator.clipboard.readText()` treo renderer. → **Chủ shop tự copy file .sql
→ paste vào Supabase SQL Editor (tab mới) → Run.** Verify không cần browser: REST API với anon key.

### 6e. Việc còn treo (chương trình tour)
1. **Rà giá thật + thay ảnh placeholder cho 70 tour AI soạn** trong CMS (đề xuất: xuất checklist
   → sinh SQL UPDATE hàng loạt).
2. **sitemap.xml**: hiện 104 URL (4 tĩnh + 100 tour), khớp DB ACTIVE — batch sau nhớ cập nhật.
3. Batch sau: hỏi lại ACTIVE/DRAFT; nếu TP tên ≠ tỉnh thì thêm vào `PROVINCE_CITIES` (mục 6c).

## 7. Phiên 2026-10-09 — Trang "Đốt Phong Long" (`/dot-phong-long`)
- File mới `dot-phong-long.html` (1 file, không phụ thuộc Supabase): viết lá sớ (tên, năm sinh → can chi,
  nam 7 vía / nữ 9 vía, chip điều xui + tự viết, điều ước) → nhấn giữ 0,9s để châm lửa → lửa canvas
  (lửa/than/khói/tàn), lá sớ cháy từ dưới lên + chìm vào chậu, lời khấn hiện từng câu (tiếng mõ/chuông
  tự tổng hợp WebAudio, có nút tắt) → đèn trời bay lên → quẻ (lời chúc, số/màu/hướng, gợi ý tour).
- Không gửi dữ liệu đi đâu; localStorage chỉ lưu số lần đốt + bật/tắt âm thanh.
- Đã thêm rewrite `/dot-phong-long` vào `vercel.json` + URL vào `sitemap.xml`.
- Cạm bẫy khi test bằng Chrome tự động: tab chạy nền (`document.hidden=true`) → rAF dừng, ảnh chụp trễ
  vài giây → không chụp được giữa lúc cháy; phải set trạng thái DOM thủ công để soi lá sớ.
- Đã commit + push main (Vercel auto-deploy). Chưa làm: chưa gắn link từ trang chủ (nav/footer); chưa có ảnh OG riêng.

## 8. Phiên 2026-10-10 — Trang `/tu-vi` (Tử vi + Thần số học + Tướng số) + nhật ký
- File mới: `tu-vi.html` (1 file, 3 tab), `tu-vi-log.html` (admin xem log, `/tu-vi-log`, noindex, chỉ role admin),
  `supabase/fortune-logs.sql`. Đã thêm rewrite `vercel.json`, `sitemap.xml`, `robots.txt` (chặn /tu-vi-log),
  nút "🔮 Xem tử vi" ở `/dot-phong-long`.
- Tử vi: đổi dương→âm (thuật toán Hồ Ngọc Đức, đã test Tết 1990/2026), can chi, nạp âm, cung phi + hướng,
  cung hoàng đạo, Cửu diệu theo tuổi mụ, Tam Tai/Kim Lâu/xung-hợp Thái Tuế → chấm sao năm. KHÔNG phải lá số 12 cung.
- Thần số học: Pythagoras (số chủ đạo giữ 11/22/33, biểu đạt, linh hồn, nhân cách, năm cá nhân, biểu đồ ngày sinh).
- Tướng số: khách tự chọn nét mặt/đường chỉ tay (không phân tích ảnh).
- Nhật ký: bảng `fortune_logs` (ĐÃ tạo trên production). Khách chỉ INSERT (anon), admin mới SELECT/DELETE.
  Ghi: view / tab / submit (tên, ngày-giờ sinh, giới, SĐT, kết quả) / cta + IP (trigger lấy từ header). Bắt buộc tích đồng ý.
- Còn 1 dòng test `session_id='test-claude'` trong fortune_logs (xoá trong Table Editor).
- Chưa commit/push. `/dot-phong-long` vẫn ghi "không lưu thông tin" — đúng vì trang đó không gửi gì.

## 9. Phiên 2026-10-13 — Nền hero + ảnh xem trước link (OG)
- `index.html` `#hero` (khoảng dòng 99): nền mới = 3 vệt sáng gradient + lớp chấm mờ, chỉnh nhanh qua biến
  `--hero-glow1/2/3` và `--hero-photo` (đặt `url('...')` nếu muốn nền ảnh). Ảnh hero có bóng đổ + khối vàng.
- Nút "Đăng nhập" (`.nav-login` → `/account`, i18n `nav_login`/`nav_account`) đã commit chung đợt này. Chưa test thật trên web.
- `og-cover.jpg` thay mới: Vịnh Hạ Long 1200×630 + slogan + baggio.website (ảnh cũ là hẻm đèn lồng Nhật, sai chủ đề).
  Tạo bằng Python/PIL từ ảnh Unsplash `photo-1573270689103-d7a4e42b609a`. Bản cũ: `og-cover_backup_261013.jpg` (chỉ ở máy).
- Link ảnh trong `index.html` là `og-cover.jpg?v=3`. Muốn đổi ảnh OG lần sau: ghi đè file + tăng `?v=`.
- Cạm bẫy:
  - Zalo/Facebook cache ảnh theo URL → khách thấy ảnh cũ. Zalo: gửi link thêm `?v=N`; Facebook: Sharing Debugger → Scrape Again.
  - Đừng curl link `?v=N` mới TRƯỚC khi Vercel deploy xong — CDN cache luôn ảnh cũ dưới URL đó (đã dính với v=2 → phải nhảy v=3).
  - PIL: vẽ nhiều lớp gradient trên CÙNG một ảnh RGBA thì lớp sau ghi đè lớp trước (alpha 0 xoá hết) → mỗi lớp một ảnh riêng rồi `alpha_composite`.
  - Georgia thiếu dấu ệ/ủ/ạ → dùng Times New Roman hoặc Segoe UI cho chữ tiếng Việt.
- Commit `b4732c6` + commit đổi `?v=3`, đã push main (Vercel auto-deploy, đã kiểm tra ảnh mới lên web).
- Chưa làm: ảnh OG riêng cho `/tu-vi` và `/dot-phong-long` (đang dùng chung ảnh Hạ Long); chưa gắn link `/dot-phong-long` từ trang chủ.
- File backup chỉ ở máy, không commit: `index_backup_261010.html`, `index_backup_261013.html`, `og-cover_backup_261013.jpg`.

## 10. Phiên 2026-10-17 — Tab "🧙 Hỏi thầy" trên `/tu-vi` (chat AI xem bói)
- `tu-vi.html`: tab thứ 4 "Hỏi thầy" (nhãn MỚI). Khách nhập ngày sinh (+ tên, giờ, giới tuỳ chọn) → "Gặp thầy" → khung chat
  với "Thầy Ba Gió". Lá số (can chi, nạp âm, cung phi, sao năm nay, hạn, số chủ đạo...) tính sẵn ở trình duyệt bằng
  `analyzeTuVi`/`analyzeThan` (hàm `buildFacts`) rồi gửi kèm để AI trả lời khớp với các tab khác. Chữ chạy dần (stream).
  Gợi ý câu hỏi sẵn; cuộc chat giữ trong `sessionStorage` (tải lại trang không mất); nút "Đổi người xem". Link thẳng: `/tu-vi?tab=hoi`.
- Edge function mới `supabase/functions/fortune-chat/index.ts` (Deno): gọi Claude (`claude-opus-5-5`, effort low,
  `fallbacks:"default"`), system prompt vai thầy bói + giới hạn (không phán bệnh/ngày chết, không cho số đề, không hù doạ
  bắt cúng, khách tuyệt vọng → khuyên gọi người thân/115). Giới hạn chống phá: 20 câu/giờ/IP, 50 câu/ngày/IP, 500 câu/ngày
  toàn trang (đổi bằng secret `FORTUNE_PER_IP_HOUR`, `FORTUNE_PER_IP_DAY`, `FORTUNE_PER_DAY`). `FORTUNE_MODEL=claude-sonnet-5-5` để rẻ hơn.
- `supabase/fortune-chats.sql`: bảng `fortune_chats` (câu hỏi, câu trả lời, token, IP) — anon không đọc/ghi; chỉ function
  (service role) ghi, admin xem. Đồng thời mở ràng buộc `fortune_logs.tool` thêm `'hoi'`.
- `tu-vi-log.html`: thêm bảng "Câu hỏi gửi Hỏi thầy" + ước tính chi phí token; lọc môn "Hỏi thầy".
- Đã test giao diện bằng bản copy có fetch giả lập (không ghi vào DB thật): desktop + mobile 390px OK.
- Cạm bẫy: test giao diện trên localhost mà không mock fetch sẽ ghi dòng log thật vào `fortune_logs` production.
- Backup chỉ ở máy: `tu-vi_backup_261017.html`, `tu-vi-log_backup_261017.html`.
- Đã triển khai 2026-10-17: chạy SQL (qua Supabase MCP), deploy function `fortune-chat` (v2), chủ shop đã đặt secret
  `ANTHROPIC_API_KEY`. Test thật bằng curl: trả lời đúng giọng, dựa lá số, từ chối số đề/tuổi thọ đúng giới hạn.
  Thời gian ~15–20 giây/câu (AI suy nghĩ trước khi ra chữ). Chi phí đo được ~0,023–0,035 USD/câu (~600–900đ);
  trần 500 câu/ngày ≈ tối đa ~15 USD/ngày.
- Cạm bẫy: `usage.input_tokens` của Claude KHÔNG gồm phần cache → phải cộng `cache_creation_input_tokens` +
  `cache_read_input_tokens` (đã sửa ở v2). Lệnh DELETE qua Supabase MCP bị chặn ("Invalid or expired requestState").
- Còn treo: 2 dòng test `session_id='test-claude'` trong `fortune_chats` (+1 dòng cũ trong `fortune_logs`) — xoá trong Table Editor.
  Muốn rẻ/nhanh hơn: thêm secret `FORTUNE_MODEL=claude-sonnet-5-5`.

## 11. Phiên 2026-10-24 — Xem nốt ruồi trong tab "Tướng số" (`/tu-vi`)
- Thêm nút chuyển "Tướng mặt & tay | Nốt ruồi" trong tab Tướng số. Nốt ruồi: chọn màu/hình dạng (đen bóng-đỏ tươi / nâu nhạt / xám mờ) + chọn nhiều vị trí (35 vị trí: mặt, đầu-cổ, thân, tay, chân) → sao Tài/Tình/Nghiệp + luận từng vị trí + nhắc đi khám da liễu nếu ruồi đổi bất thường.
- Cơ sở: 3 nguyên tắc (vị trí – hình sắc – ẩn/lộ) tổng hợp từ Ma Y Thần Tướng, Liễu Trang Tướng Pháp, Thần Tướng Toàn Biên. Lời giải do AI diễn đạt lại từ kiến thức chung, KHÔNG đối chiếu từng câu với sách gốc.
- Nhật ký: ghi vào tool `tuongso` với `input.sub='notruoi'` (bảng `fortune_logs` có check constraint chỉ 3 giá trị, nên không thêm tool mới → không cần chạy SQL).
- Backup: `tu-vi_backup_261024.html` (không git add). Đã test trên localhost (stub fetch, không ghi log thật).
- Chưa làm: chưa commit/push; `tu-vi-log.html` hiện hiển thị lượt nốt ruồi như "Tướng số" (có danh sách vị trí) — chưa tách riêng.
- (Cùng ngày, bản 2) Nốt ruồi làm chi tiết hơn: mỗi vị trí nhập thêm bên (trái/phải), cỡ, màu; dùng giới tính + ngày sinh (tuỳ chọn) để luận "nam tả nữ hữu" và **vận theo tuổi ta** (bản đồ lưu niên: tai 1–14, trán 15–30, mày 31–34, mắt 35–40, sống mũi 41–44, đầu mũi 48–50, nhân trung 51, miệng 57–60, cằm 61+; các sách xếp hơi khác nhau). Kết quả: nhận định tổng hợp + từng vị trí có Tổng quát/Tài/Tình/Nghiệp/Vận theo tuổi/Lời khuyên. Backup trước khi sửa: `tu-vi_backup_261024b.html`. Chưa commit bản 2.
- (Cùng ngày, bản 3) Tab Tướng số chia 3 nút: **Tướng mặt | Bàn tay | Nốt ruồi**. Tướng mặt: 9 nhóm bộ phận (trán, mày, mắt, mũi, nhân trung, miệng, cằm, tai, gò má, dáng mặt) — mỗi lựa chọn có mô tả cách nhận biết + luận Tổng quát/Tài/Tình/Nghiệp/Lời khuyên, cung vị (thập nhị cung), vận theo tuổi (lưu niên) khi có ngày sinh, và tổng hợp "tam đình" (tiền/trung/hậu vận). Bàn tay: 9 nhóm (hình tay ngũ hành, đường sinh/trí/tâm/vận mệnh/thái dương/hôn nhân, gò Kim tinh, ngón cái). Nhật ký: `input.sub` = `tuongmat` / `bantay` / `notruoi` (vẫn tool `tuongso`). Backup: `tu-vi_backup_261024c.html`. Chưa commit bản 2+3.
