-- ═══════════════════════════════════════════════════════════════
-- LỊCH KHỞI HÀNH cho 10 tour TP.HCM (slug 10021 → 10030)
-- Day tour khởi hành HÀNG NGÀY: tạo lịch từ ngày mai đến +60 ngày.
-- return_date = depart_date + (duration_days - 1)  → day tour = cùng ngày.
-- total_slots = max_pax của tour. Idempotent: bỏ qua (tour_id, depart_date) đã có.
-- Chạy trong Supabase → SQL Editor.
-- ═══════════════════════════════════════════════════════════════

insert into public.tour_schedules
  (tour_id, depart_date, return_date, total_slots, available_slots, status)
select
  t.id,
  d::date,
  (d::date + (coalesce(t.duration_days,1) - 1))::date,
  t.max_pax,
  t.max_pax,
  'OPEN'
from public.tours t
cross join generate_series(current_date + 1, current_date + 60, interval '1 day') d
where t.destination = 'TP. Hồ Chí Minh'
  and t.slug ~ '-100(2[1-9]|30)$'
  and not exists (
    select 1 from public.tour_schedules s
    where s.tour_id = t.id and s.depart_date = d::date
  );

-- Kiểm tra: mỗi tour phải có 60 lịch OPEN sắp tới
select t.slug, count(*) as so_lich, min(s.depart_date) as ngay_dau, max(s.depart_date) as ngay_cuoi
from public.tours t
join public.tour_schedules s on s.tour_id = t.id
where t.destination = 'TP. Hồ Chí Minh'
group by t.slug
order by t.slug;
