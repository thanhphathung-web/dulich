-- ═══════════════════════════════════════════════════════════════
-- "Hỏi thầy" trên trang /tu-vi — lưu từng câu hỏi + câu trả lời của AI.
-- Chạy trong Supabase → SQL Editor. Idempotent — chạy lại vô hại.
--
-- Bảo mật:
--   • Khách (anon) KHÔNG đọc/ghi trực tiếp bảng này. Chỉ edge function
--     `fortune-chat` (dùng service role) ghi vào, và dùng nó để đếm giới hạn
--     số câu hỏi theo IP / theo ngày (chặn người phá làm tốn tiền API).
--   • Chỉ role admin được SELECT/DELETE → xem ở trang /tu-vi-log.
-- ═══════════════════════════════════════════════════════════════

create table if not exists public.fortune_chats (
  id            bigint generated always as identity primary key,
  created_at    timestamptz not null default now(),
  session_id    text check (char_length(session_id) <= 64),
  ip            text,
  name          text check (char_length(name) <= 120),
  birth_date    text check (char_length(birth_date) <= 20),
  gender        text check (char_length(gender) <= 10),
  turn          int,                                              -- câu thứ mấy trong cuộc trò chuyện
  question      text check (char_length(question) <= 2000),
  answer        text check (char_length(answer) <= 20000),
  status        text not null default 'ok' check (status in ('ok','refusal','error','limited')),
  model         text,
  input_tokens  int,
  output_tokens int,
  user_agent    text check (char_length(user_agent) <= 400)
);

create index if not exists idx_fortune_chats_created on public.fortune_chats(created_at desc);
create index if not exists idx_fortune_chats_ip      on public.fortune_chats(ip, created_at desc);
create index if not exists idx_fortune_chats_session on public.fortune_chats(session_id);

alter table public.fortune_chats enable row level security;

drop policy if exists fortune_chats_select on public.fortune_chats;
create policy fortune_chats_select on public.fortune_chats
  for select to authenticated using (public.has_role('admin'));

drop policy if exists fortune_chats_delete on public.fortune_chats;
create policy fortune_chats_delete on public.fortune_chats
  for delete to authenticated using (public.has_role('admin'));

revoke all on public.fortune_chats from anon, authenticated;
grant select, delete on public.fortune_chats to authenticated;

-- ── fortune_logs: cho phép môn mới 'hoi' (tab Hỏi thầy) ──
alter table public.fortune_logs drop constraint if exists fortune_logs_tool_check;
alter table public.fortune_logs add constraint fortune_logs_tool_check
  check (tool in ('tuvi','thansohoc','tuongso','hoi'));
