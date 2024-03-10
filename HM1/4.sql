select s.name,count(*)
from sports.event e
left join sports.sport s on e.sport_id = toInt32(s.id)
where e.id in (
                select b.id from bq.events b
                          where toDate(b.event_date)<='2023-01-31'
                                and b.event_name='open_event')
group by s.name;