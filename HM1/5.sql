select s.id,count(*) number_of_openings
from sports.event s
right join bq.events e on s.id = e.id
where s.tournament_id in (select t.id from sports.tournament t where t.name='HNL')
and e.event_name='open_event' and toDate(s.startdate)<='2023-05-28' and toDate(s.startdate)>='2022-07-15'
group by s.id
order by number_of_openings desc
limit 1;

select * from sports.event s
where s.tournament_id in (select t.id from sports.tournament t where t.name='HNL')
;

select *
from bq.events e
    left join sports.event s on s.id = e.id
    where e.event_name='open_event' and s.tournament_id in (select t.id from sports.tournament t where t.name='HNL')
limit 5;

select * from sports.tournament
where name='HNL';

select s.startdate,s.season_id,s.tournament_id,count(*)
from sports.event s
    where s.tournament_id in (select t.id from sports.tournament t where t.name='HNL') and
    toDate(s.startdate)<='2023-05-28' and toDate(s.startdate)>='2022-07-15'
group by s.season_id, s.tournament_id,s.startdate
order by s.startdate desc
;