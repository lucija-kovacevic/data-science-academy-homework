with RankedPlayers as (
    select
        e.geo_country,
        p.name as player_name,
        count(*) as cnt,
        rank() over (partition by  e.geo_country order by  count(*) desc) as rn
    from
        bq.events e
        left join sports.player p on e.id = p.id
    where
        e.event_name = 'follow_player'
        and e.event_date between '20230101' and '20230331'
    group by
        e.geo_country, p.name
)
select geo_country,player_name as player
from RankedPlayers
where rn = 1;
