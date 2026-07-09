# Thiết kế phân quyền nhân viên (RBAC) — Baggio Travel

> Bản thiết kế, cập nhật 2026-07-09. Các lựa chọn dưới đây là **mặc định khuyến nghị** — dễ chỉnh theo cơ cấu nhân sự thật.

## Giả định (chốt để tiến hành; nói nếu muốn đổi)
1. **6 role chức năng** (xem §2). Nếu team nhỏ 1–2 người kiêm nhiều việc → có thể gộp còn 3.
2. **Cơ chế bảng `staff_roles` + `has_role()`** (không dùng Access Token Hook — xem §4).
3. **Xem số liệu tiền** (giá vốn NCC, margin, doanh thu): chỉ `admin`, `manager`, `accountant`.

## 1. Hiện trạng
- 1 role duy nhất: `auth.users.raw_app_meta_data->>'role' = 'admin'`, gán tay bằng SQL.
- RLS mọi bảng check phẳng `(...app_metadata...->>'role')='admin'`.
- Trang nội bộ KHÔNG gating ở client — biên giới bảo mật chỉ là RLS + JWT.

## 2. Bộ vai trò

| Role | Ai | Mục đích |
|---|---|---|
| `admin` | Chủ | Toàn quyền + gán role |
| `manager` | Quản lý | Gần như admin, trừ gán role |
| `sales` | Tư vấn viên | Bookings + CRM (`/comms`), xem tour |
| `ops` | Điều phối | Lịch tour, phân HDV, nhà cung cấp |
| `accountant` | Kế toán | Báo cáo, doanh thu, giao dịch NCC |
| `content` | Biên tập | CMS tour + dịch + duyệt review; **không thấy PII khách** |

## 3. Ma trận quyền (R=đọc, W=đọc+ghi, –=cấm)

| Bảng | admin | manager | sales | ops | accountant | content |
|---|---|---|---|---|---|---|
| `tours` | W | W | R | R | R | W |
| `tour_schedules` | W | W | R | W | R | R |
| `bookings` (PII+tiền) | W | W | W | W | R | – |
| `communications`/`comm_reminders` | W | W | W | R | – | – |
| `guides` | W | W | R | W | R | – |
| `suppliers` (giá vốn) | W | W | – | W | R | – |
| `supplier_transactions` | W | W | – | W | W | – |
| `reviews` | W | W | R | – | – | W |
| `users` (hồ sơ khách) | W | W | R | R | R | – |
| `staff_roles` | W | – | – | – | – | – |

Public/anon giữ nguyên: đọc tour ACTIVE, đọc review/guides/schedules, khách tạo booking.

## 4. Cơ chế: bảng `staff_roles` + hàm `has_role()`

**Vì sao KHÔNG dùng Access Token Hook** (dù là pattern "chuẩn" của Supabase):
- Hook cần bật thủ công trong Dashboard → thêm phụ thuộc cấu hình.
- Role nằm trong JWT → đổi role phải **đăng xuất/đăng nhập lại** mới có hiệu lực.

**Cách chọn — đọc role từ bảng qua hàm `SECURITY DEFINER`:**
- Bảng `staff_roles(user_id PK, role, email, added_by, timestamps)` là nguồn sự thật duy nhất.
- Hàm `staff_role()` / `has_role(variadic text[])` — `stable security definer`, đọc `staff_roles` theo `auth.uid()`. RLS gọi `has_role('admin','manager',...)`.
- **Ưu điểm:** không cần Dashboard; **đổi role có hiệu lực NGAY** (không cần re-login); quản lý bằng bảng → làm UI được.
- **Đánh đổi:** mỗi RLS check tra 1 dòng theo PK — không đáng kể với công cụ nội bộ nhỏ (hàm `stable` được cache trong 1 câu lệnh).

Gán role qua RPC `set_staff_role(email, role)` (chỉ `admin` gọi được, `security definer`, tra `auth.users` theo email rồi upsert).

## 5. Gating ở client (UX, không phải bảo mật)
Snippet dùng chung: khi tải trang → `sb.rpc('staff_role')` → nếu role không được phép trang này thì chuyển `/account` + thông báo; ẩn link nav ngoài quyền. **RLS vẫn là lớp thực thi thật.**

Bản đồ trang → role được vào:
- `/admin` `/report`: admin, manager, (report: +accountant)
- `/comms`: admin, manager, sales
- `/operations` `/guides-mgmt` `/suppliers`: admin, manager, ops (+accountant đọc)
- `/cms` `/tour-import` `/translate`: admin, manager, content

## 6. Lộ trình (mỗi phase 1 script idempotent, chạy được qua Supabase CLI)
- **Phase 1 — Nền tảng (KHÔNG phá vỡ gì):** tạo `staff_roles` + `staff_role()`/`has_role()`/`set_staff_role()` + seed admin hiện tại. RLS cũ vẫn nguyên → mọi thứ chạy như cũ. → `supabase/rbac-phase1.sql`
- **Phase 2 — Viết lại RLS** từng bảng theo §3 (thay `='admin'` bằng `has_role(...)`), giữ fallback app_metadata admin 1 nhịp cho an toàn. Test từng bảng.
- **Phase 3 — Client guard + UI gán role** (panel nhỏ trong `/admin`, admin-only, gọi `set_staff_role`).
- **Phase 4 — Test toàn diện:** 1 tài khoản test/role, đối chiếu ma trận.

## 7. Rủi ro & phòng
- **Tự khoá:** luôn giữ ≥1 admin; Phase 1 seed sẵn bạn = admin; Phase 2 giữ fallback app_metadata 1 nhịp.
- **Hàm helper** phải `security definer` + `set search_path=public` (đã có) để tránh injection.
- **Giữ nguyên** policy public read (tours/reviews/guides/schedules) và guest insert booking.
- Nhân viên phải **đăng nhập /account (Google) ít nhất 1 lần** để có mặt trong `auth.users` thì mới gán role được.
