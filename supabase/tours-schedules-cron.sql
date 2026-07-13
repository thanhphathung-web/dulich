-- ═══════════════════════════════════════════════════════════════
-- TỰ ĐỘNG NỐI LỊCH KHỞI HÀNH cho DAY TOUR (pg_cron)
-- Chạy trong Supabase → SQL Editor. Idempotent — chạy lại không sao.
--
-- Quy tắc: mọi tour ACTIVE có duration_days = 1 (day tour, hiện là
-- 10 tour TP.HCM slug 10021→10030) luôn có lịch khởi hành HÀNG NGÀY
-- phủ đủ 60 ngày tới. Cron chạy mỗi đêm 00:05 giờ VN, mỗi lần chỉ
-- đắp thêm ngày còn thiếu (NOT EXISTS) nên không bao giờ tạo trùng.
--
-- Tour NHIỀU ngày (2N1Đ trở lên) KHÔNG bị đụng tới — lịch của chúng
-- do người quản trị tạo tay trong CMS như trước.
-- total_slots lịch mới = max_pax của tour tại thời điểm tạo.
-- ═══════════════════════════════════════════════════════════════

create extension if not exists pg_cron;

create or replace function public.extend_day_tour_schedules()
returns void
language plpgsql
security definer
set search_path = public
as $fn$
begin
  insert into public.tour_schedules
    (tour_id, depart_date, return_date, total_slots, available_slots, status)
  select
    t.id,
    d::date,
    d::date,                    -- day tour: ngày về = ngày đi
    t.max_pax,
    t.max_pax,
    'OPEN'
  from public.tours t
  cross join generate_series(current_date + 1, current_date + 60, interval '1 day') d
  where t.status = 'ACTIVE'
    and t.duration_days = 1
    and t.max_pax is not null and t.max_pax > 0
    and not exists (
      select 1 from public.tour_schedules s
      where s.tour_id = t.id and s.depart_date = d::date
    );
end $fn$;

-- ── Lịch chạy (gỡ job cũ nếu có rồi tạo lại) ───────────────────
do $sched$
begin
  begin perform cron.unschedule('baggio-extend-day-tour-schedules'); exception when others then null; end;
end $sched$;

-- 17:05 UTC = 00:05 giờ VN hàng ngày
select cron.schedule('baggio-extend-day-tour-schedules', '5 17 * * *',
                     'select public.extend_day_tour_schedules()');

-- ── Chạy ngay 1 lần để đắp lịch tới hạn hôm nay ────────────────
select public.extend_day_tour_schedules();

-- ── Kiểm tra ───────────────────────────────────────────────────
select jobname, schedule, active from cron.job where jobname like 'baggio-%' order by jobname;

select t.slug, count(*) as so_lich_sap_toi, max(s.depart_date) as ngay_cuoi
from public.tours t
join public.tour_schedules s on s.tour_id = t.id
where t.duration_days = 1 and t.status = 'ACTIVE' and s.depart_date > current_date
group by t.slug
order by t.slug;
