# Deploy — Booking Confirmation Email

## Bước 1 — Lấy Resend API key
1. Vào https://resend.com → Sign up (miễn phí, 3000 email/tháng)
2. Dashboard → API Keys → Create API Key
3. Copy key (dạng `re_xxxxxxxxxxxx`)

## Bước 2 — Thêm secret vào Supabase
Vào https://supabase.com/dashboard → project **lfnlezfphwjtdunyungi** → Edge Functions → Secrets:

| Key | Value |
|-----|-------|
| `RESEND_API_KEY` | `re_xxxxxxxxxxxx` (key vừa copy) |

> `SUPABASE_URL` và `SUPABASE_SERVICE_ROLE_KEY` đã được inject tự động — không cần thêm.

## Bước 3 — Tạo Edge Function
1. Supabase Dashboard → Edge Functions → **New Function**
2. Đặt tên: `booking-confirmation`
3. Xóa code mẫu, paste toàn bộ nội dung file `index.ts` này
4. Click **Deploy**

## Bước 4 — Tạo Database Webhook
Supabase Dashboard → Database → Webhooks → **Create Webhook**:

| Field | Value |
|-------|-------|
| Name | `on-booking-insert` |
| Table | `bookings` |
| Events | ✅ Insert |
| Type | Supabase Edge Functions |
| Function | `booking-confirmation` |

Click **Create webhook** → xong.

## Test
Tạo một booking thử trên website → khách nhận email trong vài giây.

Để test riêng: Supabase Dashboard → Edge Functions → `booking-confirmation` → **Test** → paste payload mẫu:
```json
{
  "type": "INSERT",
  "table": "bookings",
  "record": {
    "booking_ref": "BT-TEST01",
    "guest_name": "Nguyễn Văn A",
    "guest_email": "your@email.com",
    "guest_phone": "0900000000",
    "tour_id": null,
    "adult_count": 2,
    "child_count": 0,
    "infant_count": 0,
    "total_price": 5000000,
    "deposit_amount": 1500000,
    "special_requests": null
  },
  "schema": "public",
  "old_record": null
}
```
