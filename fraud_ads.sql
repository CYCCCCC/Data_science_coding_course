
--solution 1: only for the condition of today and yerterday

select advertiser_id
from (
    select advertiser_id, date,
           max(date) as today,
           min(date) over(partition by advertiser_id) as min_date
    from frauds
) a
where min_dt = date(today, '-1 day')
and date = today;


--solution 2: more general solution

select advertiser_id
from (
    select advertiser_id, date,
           max(date) as today,
           lag(date, 1) over(partition by advertiser_id order by date) as pre_dt,
           min(date) over(partition by advertiser_id) as min_dt
    from frauds
) a
where min_dt = date(today, '-1 day')
and date = today;


--solution 3

-- select distinct advertiser_id
-- from frauds
-- where advertiser_id not in (select distinct advertiser_id
--                             from frauds
--                             where date < date_sub(max(date), interval 1 day))
-- and advertiser_id in (select distinct advertiser_id
--                       from frauds
--                       where date = date_sub(max(date), interval 1 day))
-- and advertiser_id in (select distinct advertiser_id
--                       from frauds
--                       where date = max(date));

