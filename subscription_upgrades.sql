
select count(upgraders),
       count(downgraders)
from (
    select user_id, 
           max(if(tier_no > tier_pre, 1, 0)) as upgraders,
           max(if(tier_no < tire_pre, 1, 0)) as downgraders
    from (
        select user_id, tier_no,
               lag(tier_no, 1) over(partition by user_id order by date) as tier_pre
        from (
            select *,
                   case when subscription_tier = 'Free' then 1
                        when subscription_tier = 'Starter' then 2
                        when subscription_tier = 'Standard' then 3
                        else 4 end as tier_no
            from subscription_tiers
        )
    )
    group by user_id
);

