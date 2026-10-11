-- ═══════════════════════════════════════════════════════════════
-- Nhật ký trang Tử vi / Thần số học / Tướng số (/tu-vi)
-- Ghi lại: ai vào xem, bấm tab nào, nhập gì (tên, ngày sinh, giờ sinh,
-- giới tính, SĐT/Zalo nếu để lại) và kết quả hiện ra.
-- Chạy trong Supabase → SQL Editor. Idempotent — chạy lại vô hại.
--
-- Bảo mật:
--   • Khách (anon) CHỈ được INSERT — không đọc được log của ai, kể cả của mình.
--   • Chỉ role admin (staff_roles) được SELECT/DELETE → xem ở trang /tu-vi-log.
--   • Trang /tu-vi có ô đồng ý rõ ràng trước khi gửi tên + ngày sinh.
-- ═══════════════════════════════════════════════════════════════

create table if not exists public.fortune_logs (
  id          bigint generated always as identity primary key,
  created_at  timestamptz not null default now(),
  session_id  text not null check (char_length(session_id) <= 64),   -- 1 trình duyệt = 1 session
  event       text not null check (event in ('view','tab','submit','cta')),
  tool        text check (tool in ('tuvi','thansohoc','tuongso')),
  name        text check (char_length(name) <= 120),
  birth_date  text check (char_length(birth_date) <= 20),             -- yyyy-mm-dd (dương lịch)
  birth_time  text check (char_length(birth_time) <= 20),
  gender      text check (char_length(gender) <= 10),
  contact     text check (char_length(contact) <= 120),                -- SĐT/Zalo (tự nguyện)
  input       jsonb check (pg_column_size(input)  <= 6000),            -- toàn bộ dữ liệu khách nhập
  result      jsonb check (pg_column_size(result) <= 6000),            -- tóm tắt kết quả đã hiện
  page        text check (char_length(page) <= 300),
  referrer    text check (char_length(referrer) <= 300),
  user_agent  text check (char_length(user_agent) <= 400),
  lang        text check (char_length(lang) <= 20),
  screen      text check (char_length(screen) <= 20),
  ip          text
);

create index if not exists idx_fortune_logs_created  on public.fortune_logs(created_at desc);
create index if not exists idx_fortune_logs_session  on public.fortune_logs(session_id);
create index if not exists idx_fortune_logs_event    on public.fortune_logs(event, tool);

-- IP lấy từ header của proxy (server tự gán → khách không giả được)
create or replace function public.fortune_logs_stamp()
returns trigger language plpgsql security definer set search_path = public as $$
declare h json;
begin
  begin
    h := current_setting('request.headers', true)::json;
  exception when others then h := null;
  end;
  new.ip := nullif(trim(split_part(coalesce(h->>'x-forwarded-for', h->>'cf-connecting-ip', ''), ',', 1)), '');
  if new.user_agent is null then new.user_agent := left(h->>'user-agent', 400); end if;
  return new;
end $$;

drop trigger if exists trg_fortune_logs_stamp on public.fortune_logs;
create trigger trg_fortune_logs_stamp before insert on public.fortune_logs
  for each row execute function public.fortune_logs_stamp();

-- ── RLS ──
alter table public.fortune_logs enable row level security;

drop policy if exists fortune_logs_insert on public.fortune_logs;
create policy fortune_logs_insert on public.fortune_logs
  for insert to anon, authenticated with check (true);

drop policy if exists fortune_logs_select on public.fortune_logs;
create policy fortune_logs_select on public.fortune_logs
  for select to authenticated using (public.has_role('admin'));

drop policy if exists fortune_logs_delete on public.fortune_logs;
create policy fortune_logs_delete on public.fortune_logs
  for delete to authenticated using (public.has_role('admin'));

-- Quyền bảng (RLS vẫn là lớp quyết định)
revoke all on public.fortune_logs from anon, authenticated;
grant insert on public.fortune_logs to anon, authenticated;
grant select, delete on public.fortune_logs to authenticated;
