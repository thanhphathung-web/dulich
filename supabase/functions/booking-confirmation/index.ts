// Supabase Edge Function — gửi email xác nhận khi có booking mới
// Trigger: Database Webhook on INSERT vào bảng bookings
// Requires secrets: RESEND_API_KEY, SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY

import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const ZALO_NUMBER = '0906 306 286'
const ZALO_LINK   = 'https://zalo.me/0906306286'
const FROM_EMAIL  = 'booking@baggiotravel.com'
const BRAND_NAME  = 'Baggio Travel'

Deno.serve(async (req) => {
  if (req.method !== 'POST') {
    return new Response('Method not allowed', { status: 405 })
  }

  const payload = await req.json()

  // Chỉ xử lý INSERT
  if (payload.type !== 'INSERT' || !payload.record) {
    return new Response('Ignored', { status: 200 })
  }

  const booking = payload.record

  // Bỏ qua nếu không có email khách
  if (!booking.guest_email) {
    return new Response('No email', { status: 200 })
  }

  // Lấy tên tour từ DB
  const supabase = createClient(
    Deno.env.get('SUPABASE_URL')!,
    Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
  )

  let tourName = 'Tour của bạn'
  if (booking.tour_id) {
    const { data: tour } = await supabase
      .from('tours')
      .select('name_vi')
      .eq('id', booking.tour_id)
      .single()
    if (tour?.name_vi) tourName = tour.name_vi
  }

  const html = buildEmail({
    ref:       booking.booking_ref,
    name:      booking.guest_name,
    email:     booking.guest_email,
    phone:     booking.guest_phone,
    tourName,
    adults:    booking.adult_count  ?? 0,
    children:  booking.child_count  ?? 0,
    infants:   booking.infant_count ?? 0,
    total:     booking.total_price,
    deposit:   booking.deposit_amount,
    note:      booking.special_requests,
  })

  const resendRes = await fetch('https://api.resend.com/emails', {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${Deno.env.get('RESEND_API_KEY')}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      from:    `${BRAND_NAME} <${FROM_EMAIL}>`,
      to:      [booking.guest_email],
      subject: `✅ Xác nhận đặt tour — ${booking.booking_ref}`,
      html,
    }),
  })

  if (!resendRes.ok) {
    const err = await resendRes.text()
    console.error('Resend error:', err)
    return new Response('Email failed', { status: 500 })
  }

  return new Response('OK', { status: 200 })
})

// ─── Email HTML builder ───────────────────────────────────────────────────────

interface BookingData {
  ref: string
  name: string
  email: string
  phone: string
  tourName: string
  adults: number
  children: number
  infants: number
  total: number
  deposit: number
  note?: string | null
}

function fmt(n: number) {
  return new Intl.NumberFormat('vi-VN').format(n) + '₫'
}

function pax(adults: number, children: number, infants: number) {
  const parts = []
  if (adults)   parts.push(`${adults} người lớn`)
  if (children) parts.push(`${children} trẻ em`)
  if (infants)  parts.push(`${infants} em bé`)
  return parts.join(', ')
}

function buildEmail(d: BookingData): string {
  return `<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Xác nhận đặt tour — ${d.ref}</title>
</head>
<body style="margin:0;padding:0;background:#f3efe6;font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;color:#111118">

<table width="100%" cellpadding="0" cellspacing="0" style="background:#f3efe6;padding:32px 16px">
  <tr><td align="center">
  <table width="600" cellpadding="0" cellspacing="0" style="max-width:600px;width:100%">

    <!-- HEADER -->
    <tr><td style="background:#111118;padding:28px 36px;text-align:center">
      <div style="font-family:Georgia,serif;font-size:26px;font-weight:700;color:#fff;letter-spacing:-0.5px">
        Baggio<span style="color:#c5372b">.</span>Travel
      </div>
      <div style="font-size:11px;color:rgba(255,255,255,0.45);letter-spacing:0.15em;text-transform:uppercase;margin-top:4px">
        Xác nhận đặt tour
      </div>
    </td></tr>

    <!-- BOOKING REF BANNER -->
    <tr><td style="background:#c5372b;padding:20px 36px;text-align:center">
      <div style="font-size:11px;color:rgba(255,255,255,0.7);letter-spacing:0.15em;text-transform:uppercase;margin-bottom:6px">Mã đặt tour của bạn</div>
      <div style="font-family:'Courier New',monospace;font-size:28px;font-weight:700;color:#fff;letter-spacing:0.12em">${d.ref}</div>
    </td></tr>

    <!-- BODY -->
    <tr><td style="background:#fff;padding:36px">

      <p style="margin:0 0 24px;font-size:16px;line-height:1.7;color:#111118">
        Xin chào <strong>${d.name}</strong>,<br>
        Chúng tôi đã nhận được yêu cầu đặt tour của bạn. Vui lòng nhắn Zalo kèm mã đặt tour để đội ngũ xác nhận chỗ ngay.
      </p>

      <!-- TOUR INFO -->
      <table width="100%" cellpadding="0" cellspacing="0" style="background:#faf8f3;border:1px solid #e5dfd3;margin-bottom:24px">
        <tr><td style="padding:14px 18px;border-bottom:1px solid #e5dfd3">
          <div style="font-size:10px;color:#7a7268;text-transform:uppercase;letter-spacing:0.1em;margin-bottom:4px">Tour</div>
          <div style="font-family:Georgia,serif;font-size:18px;font-weight:700;color:#111118">${d.tourName}</div>
        </td></tr>
        <tr><td style="padding:14px 18px;border-bottom:1px solid #e5dfd3">
          <div style="font-size:10px;color:#7a7268;text-transform:uppercase;letter-spacing:0.1em;margin-bottom:4px">Hành khách</div>
          <div style="font-size:14px;font-weight:600;color:#111118">${pax(d.adults, d.children, d.infants)}</div>
        </td></tr>
        <tr><td style="padding:14px 18px;border-bottom:1px solid #e5dfd3">
          <div style="display:flex;justify-content:space-between">
            <div>
              <div style="font-size:10px;color:#7a7268;text-transform:uppercase;letter-spacing:0.1em;margin-bottom:4px">Tổng tour</div>
              <div style="font-size:14px;color:#111118">${fmt(d.total)}</div>
            </div>
          </div>
        </td></tr>
        <tr><td style="padding:14px 18px;background:#fff9f9">
          <div style="font-size:10px;color:#c5372b;text-transform:uppercase;letter-spacing:0.1em;margin-bottom:4px">Tiền cọc cần thanh toán (30%)</div>
          <div style="font-family:'Courier New',monospace;font-size:22px;font-weight:700;color:#c5372b">${fmt(d.deposit)}</div>
        </td></tr>
      </table>

      <!-- BANK INFO -->
      <table width="100%" cellpadding="0" cellspacing="0" style="background:#f0faf8;border:2px solid #1a6b5e;margin-bottom:28px">
        <tr><td style="background:#1a6b5e;padding:10px 18px;text-align:center">
          <div style="font-size:10px;color:#fff;letter-spacing:0.12em;text-transform:uppercase;font-weight:600">Thông tin chuyển khoản</div>
        </td></tr>
        <tr><td style="padding:16px 18px">
          <table width="100%" cellpadding="4" cellspacing="0" style="font-size:13px">
            <tr>
              <td style="color:#7a7268;width:140px">Ngân hàng</td>
              <td><strong>Techcombank</strong></td>
            </tr>
            <tr>
              <td style="color:#7a7268">Số tài khoản</td>
              <td><strong style="font-family:'Courier New',monospace;font-size:15px;letter-spacing:0.08em">4042828666</strong></td>
            </tr>
            <tr>
              <td style="color:#7a7268">Chủ tài khoản</td>
              <td><strong>TRAN HUNG VI</strong></td>
            </tr>
            <tr>
              <td style="color:#7a7268">Số tiền cọc</td>
              <td><strong style="color:#c5372b">${fmt(d.deposit)}</strong></td>
            </tr>
            <tr>
              <td style="color:#7a7268">Nội dung CK</td>
              <td><strong style="color:#1a6b5e;font-family:'Courier New',monospace">${d.ref} ${d.name}</strong></td>
            </tr>
          </table>
        </td></tr>
      </table>

      <!-- ZALO CTA -->
      <table width="100%" cellpadding="0" cellspacing="0" style="margin-bottom:28px">
        <tr><td style="background:#e8f1ff;border:1px solid #b3d0ff;padding:20px 18px;text-align:center">
          <div style="font-size:13px;color:#111118;margin-bottom:14px">
            Sau khi chuyển khoản, nhắn mã <strong style="font-family:'Courier New',monospace">${d.ref}</strong><br>
            qua Zalo để đội ngũ xác nhận chỗ cho bạn ngay
          </div>
          <a href="${ZALO_LINK}" style="display:inline-block;background:#0068ff;color:#fff;font-size:15px;font-weight:700;padding:14px 32px;text-decoration:none;border-radius:4px">
            Nhắn Zalo ${ZALO_NUMBER} →
          </a>
        </td></tr>
      </table>

      ${d.note ? `
      <!-- SPECIAL REQUESTS -->
      <table width="100%" cellpadding="0" cellspacing="0" style="margin-bottom:24px">
        <tr><td style="background:#faf8f3;border:1px solid #e5dfd3;padding:14px 18px">
          <div style="font-size:10px;color:#7a7268;text-transform:uppercase;letter-spacing:0.1em;margin-bottom:6px">Yêu cầu đặc biệt</div>
          <div style="font-size:13px;color:#111118;line-height:1.6">${d.note}</div>
        </td></tr>
      </table>
      ` : ''}

      <p style="margin:0;font-size:13px;color:#7a7268;line-height:1.7;border-top:1px solid #e5dfd3;padding-top:20px">
        Nếu có bất kỳ thắc mắc nào, liên hệ ngay qua Zalo hoặc gọi hotline
        <a href="tel:0906306286" style="color:#c5372b;text-decoration:none;font-weight:600">0906 306 286</a>.<br>
        Cảm ơn bạn đã tin tưởng Baggio Travel!
      </p>

    </td></tr>

    <!-- FOOTER -->
    <tr><td style="background:#111118;padding:20px 36px;text-align:center">
      <div style="font-size:11px;color:rgba(255,255,255,0.4);line-height:1.8">
        Baggio Travel · baggiotravel.com<br>
        © 2025 Baggio Travel. All rights reserved.
      </div>
    </td></tr>

  </table>
  </td></tr>
</table>

</body>
</html>`
}
