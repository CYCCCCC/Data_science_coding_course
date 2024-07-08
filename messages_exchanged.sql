
select user_pairA,
       user_pairB,
       count(*) as total_exchanges,
       sum(if(direction = 1, 1, 0)) as sent_by_user_A,
       sum(if(direction = 2, 1, 0)) as sent_by_user_B
from (
    select sender_id as user_pairA, receiver_id as sent_by_user_B,
           1 as direction
    from total_messages
    union all
    select receiver_id as user_pairA, sender_id as sent_by_user_B,
           2 as direction
    from total_messages 
) a
group by user_pairA, user_pairB
order by count(*) desc
limit 1
