drop table if exists lkovacevic.daily_entity_follows;

CREATE TABLE lkovacevic.daily_entity_follows (
    `event_date` String,
    `entity` LowCardinality(String),
    `name` LowCardinality(String),
    `count` AggregateFunction(count)
)
ENGINE = AggregatingMergeTree()
ORDER BY (entity, name, event_date)
SETTINGS index_granularity = 8192;

drop view if exists lkovacevic.mv_daily_entity_follows;
CREATE MATERIALIZED VIEW lkovacevic.mv_daily_entity_follows
TO lkovacevic.daily_entity_follows AS
SELECT
    event_date,
    substr(event_name,8,20) as entity,
    multiIf(event_name='follow_league',dictGet('lkovacevic.uniquetournament_dictionary','name',id),
        event_name='follow_team',dictGet('lkovacevic.team_dictionary','name',id),
            dictGet('lkovacevic.player_dictionary','name',id)) as name,
    countState() AS count
FROM bq.events t
      where event_name in ('follow_league','follow_team','follow_player')
GROUP BY event_date, entity, name;

INSERT INTO lkovacevic.daily_entity_follows
SELECT
    event_date,
    substr(event_name,8,20) as entity,
    multiIf(event_name='follow_league',dictGet('lkovacevic.uniquetournament_dictionary','name',id),
        event_name='follow_team',dictGet('lkovacevic.team_dictionary','name',id),
            dictGet('lkovacevic.player_dictionary','name',id)) as name,
    countState() AS count
FROM bq.events
where event_name in ('follow_player','follow_team','follow_league')
GROUP BY event_date, entity, name;

-- provjera
select event_date,entity,name,countMerge(count) as count from lkovacevic.daily_entity_follows
group by event_date, entity, name limit 10;

