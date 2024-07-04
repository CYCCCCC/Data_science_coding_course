
select year,
       subscribers,
       unsubscribers,
       case when (subscribers-unsubscribers) > (sub_pre-unsub_pre) then 'ABOVE'
            when (subscribers-unsubscribers) = (sub_pre-unsub_pre) then 'SAME'
            when (subscribers-unsubscribers) < (sub_pre-unsub_pre) then 'BELOW'
            else 'NA' end as year_change
from (
    select year, subscribers, unsubscribers,
           lag(subscribers, 1) over(order by year) as sub_pre,
           lag(unsubscribers, 1) over(order by year) as unsub_pre
    from (
         (
            select year(subscription_started) as year,
                   count(*) as subscribers
            from user_churn
            group by year(subscription_started) 
         ) a  
         outer join
         (
            select year(subscription_ended) as year,
                   count(*) as unsubscribers
            from user_churn
            group by year(subscription_ended)
         ) b
         on a.year = b.year
    )
)


