-- a)
select toDate(toMonday(toDate(t.event_date))) as week,
       dictGet('lkovacevic.sport_dictionary','name',dictGet('lkovacevic.event_dictionary', 'sport_id',toUInt64(t.event_id))) as sport,
       countMerge(count) as weekly_count,
           dense_rank() OVER (
PARTITION BY week ORDER BY weekly_count desc)
    from lkovacevic.daily_event_openings t
group by week,sport;

-- b)
select toDate(toMonday(toDate(t.event_date))) as week,
       entity,
       name,
       countMerge(count) as weekly_count,
           dense_rank() OVER (
PARTITION BY week ORDER BY weekly_count desc) as rank
    from lkovacevic.daily_entity_follows t
    where toDate(toMonday(toDate(t.event_date)))='2023-01-16'
group by week,entity,name
limit 10;

select event_date,entity,name,countMerge(count) as count from lkovacevic.daily_entity_follows
group by event_date, entity, name limit 1;
