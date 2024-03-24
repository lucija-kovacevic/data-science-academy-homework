drop table if exists lkovacevic.daily_event_openings;
CREATE TABLE lkovacevic.daily_event_openings (
    `event_date` String,
    `event_id` String,
    `count` AggregateFunction(count)
)
ENGINE = AggregatingMergeTree()
ORDER BY (event_id, event_date)
SETTINGS index_granularity = 8192;

drop view if exists lkovacevic.mv_daily_event_openings;
CREATE MATERIALIZED VIEW lkovacevic.mv_daily_event_openings
TO lkovacevic.daily_event_openings AS
SELECT
    event_date,
    id as event_id,
    countState() AS count
FROM bq.events
where event_name='open_event'
GROUP BY event_date, event_id;

INSERT INTO lkovacevic.daily_event_openings
SELECT
    event_date,
    id as event_id,
    countState() as count
FROM bq.events
where event_name='open_event'
GROUP BY event_date, event_id;

