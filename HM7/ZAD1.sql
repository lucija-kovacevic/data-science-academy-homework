with pom as (
select a.event_date as event_date, a.event_name,count(distinct a.user_pseudo_id) as num_users
from bq.events a left join sports.event b on a.id=b.id
where a.event_name='open_event' and a.event_date>='20230101' and a.event_date<='20230530'
and a.platform='IOS' and b.sport_id=1 
--and b.sport_id=1 this part can be commented depending on whether the average is
--calculated for for all users that day or only those that opened football event
--nevertheless it doesnt affect time series properties since it just scales it differently
group by a.event_date, a.event_name order by a.event_date),
pom2 as (
    select a.event_date as event_date, a.event_name,a.user_pseudo_id, count(distinct b.id) as avg_events_per_user
from bq.events a left join sports.event b on a.id=b.id
where a.event_name='open_event' and a.event_date>='20230101' and a.event_date<='20230530'
and b.sport_id=1 and a.platform='IOS'
group by a.event_date, a.event_name,a.user_pseudo_id order by a.event_date
),
pom3 as (
    select event_date, sum(avg_events_per_user) as avg_events_per_user
    from pom2
    group by event_date
    )
select a.event_date as ev_date,b.avg_events_per_user/a.num_users as avg_events_per_user
from pom a left join pom3 b on a.event_date=b.event_date
;
