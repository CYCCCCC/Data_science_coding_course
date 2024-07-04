
select user_id, page, unix_timestamp,
       sum(is_new_session) over(partition by user_id order by unix_timestamp) as session_count
from (
    select user_id, page, unix_timestamp,
           case when time_delta is null or time_delta > 60*30 then 1 else 0 end as is_new_session
    from (
        select user_id, page, unix_timestamp,
               unix_timestamp - lag(unix_timestamp, 1) over(partition by user_id order by unix_timestamp) as time_delta
        from user_session
    )
);

