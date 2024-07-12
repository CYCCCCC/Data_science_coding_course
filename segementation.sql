
select sum(if((mobile = 1) & (web != 1)), 1, 0) / count(*) as mobile_only,
       sum(if((mobile != 1) & (web = 1)), 1, 0) / count(*) as web_only,
       sum(if((mobile = 1) & (web = 1)), 1, 0) / count(*) as both
from (
    select a.user_id, mobile, web
    from (
        select distinct user_id, 1 as mobile
        from mobile
    ) a
    outer join
    (
        select distinct user_id, 1 as web
        from web
    ) b on a.user_id = b.user_id
) a


