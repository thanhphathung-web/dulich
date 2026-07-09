-- ═══════════════════════════════════════════════════════════════
-- Nhật ký liên lạc khách hàng (communications) + Nhắc nhở (comm_reminders)
-- Dùng cho trang /comms (baggio-comms.html).
-- Chạy trong Supabase → SQL Editor. Idempotent — chạy lại nhiều lần vô hại.
--
-- Bảo mật: log liên lạc chứa PII/nội dung trao đổi với khách → NỘI BỘ.
-- RLS chỉ cho admin (app_metadata.role='admin') đọc & ghi.
-- ═══════════════════════════════════════════════════════════════

-- ── BẢNG COMMUNICATIONS (nhật ký liên lạc) ──
create table if not exists public.communications (
  id          uuid primary key default gen_random_uuid(),
  booking_id  uuid references public.bookings(id) on delete cascade,
  channel     text not null default 'note'
                check (channel in ('zalo','call','email','sms','meeting','note')),
  direction   text not null default 'out' check (direction in ('in','out')),
  body        text not null,
  staff_name  text,
  created_at  timestamptz not null default now()
);

-- ── BẢNG COMM_REMINDERS (nhắc nhở liên hệ) ──
create table if not exists public.comm_reminders (
  id           uuid primary key default gen_random_uuid(),
  booking_id   uuid references public.bookings(id) on delete cascade,
  remind_date  date not null,
  channel      text not null default 'zalo'
                 check (channel in ('zalo','call','email','sms','meeting','note')),
  note         text,
  done         boolean not null default false,
  created_at   timestamptz not null default now()
);

-- ── INDEX ──
create index if not exists idx_comms_booking       on public.communications(booking_id);
create index if not exists idx_comms_created        on public.communications(created_at);
create index if not exists idx_comm_rem_booking     on public.comm_reminders(booking_id);
create index if not exists idx_comm_rem_open        on public.comm_reminders(remind_date) where done = false;

-- ── RLS: chỉ admin đọc & ghi ──
alter table public.communications  enable row level security;
alter table public.comm_reminders  enable row level security;

drop policy if exists "communications_admin_all" on public.communications;
create policy "communications_admin_all" on public.communications
  for all to authenticated
  using      ((auth.jwt() -> 'app_metadata' ->> 'role') = 'admin')
  with check ((auth.jwt() -> 'app_metadata' ->> 'role') = 'admin');

drop policy if exists "comm_reminders_admin_all" on public.comm_reminders;
create policy "comm_reminders_admin_all" on public.comm_reminders
  for all to authenticated
  using      ((auth.jwt() -> 'app_metadata' ->> 'role') = 'admin')
  with check ((auth.jwt() -> 'app_metadata' ->> 'role') = 'admin');

-- ── KIỂM TRA ──
select tablename, policyname, cmd, roles
from pg_policies
where schemaname='public' and tablename in ('communications','comm_reminders')
order by tablename, cmd;
