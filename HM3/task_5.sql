drop table if exists lkovacevic.daily_event_activity;
create table lkovacevic.daily_event_activity
(
    event_date String CODEC(ZSTD(1)),
    event_name LowCardinality(String),
    geo_country LowCardinality(String),
    platform LowCardinality(String),
    count AggregateFunction(sum,UInt64) CODEC(ZSTD(1)),
    user_count AggregateFunction(count,UInt64) CODEC(ZSTD(1))
)
ENGINE = AggregatingMergeTree()
PARTITION BY event_date
order by (event_date,event_name,platform,geo_country)
SETTINGS index_granularity=8192;

select * from system.columns where table='daily_event_activity';

INSERT INTO lkovacevic.daily_event_activity (event_date,event_name, geo_country,platform, count, user_count)
SELECT
    multiIf(d.event_date='','<all>',d.event_date) as event_date,
    multiIf(d.event_name='','<all>',d.event_name) as event_name,
    multiIf(d.geo_country='','<all>',d.geo_country) as geo_country,
    multiIf(d.platform='','<all>',d.platform) as platform,
    sumState(d.count) as count,
    countState(distinct d.user_pseudo_id) as user_count
from aggregations.daily_user_activity d
where d.event_date between '20230101' and '20230131'
group by cube(d.event_date, d.platform, d.geo_country, d.event_name);

INSERT INTO lkovacevic.daily_event_activity (event_date,event_name, geo_country,platform, count, user_count)
SELECT
    multiIf(d.event_date='','<all>',d.event_date) as event_date,
    multiIf(d.event_name='','<all>',d.event_name) as event_name,
    multiIf(d.geo_country='','<all>',d.geo_country) as geo_country,
    multiIf(d.platform='','<all>',d.platform) as platform,
    sumState(d.count) as count,
    countState(distinct d.user_pseudo_id) as user_count
from aggregations.daily_user_activity d
where d.event_date between '20230201' and '20230228'
group by cube (d.event_date, d.platform, d.geo_country, d.event_name);

INSERT INTO lkovacevic.daily_event_activity (event_date,event_name, geo_country,platform, count, user_count)
SELECT
    multiIf(d.event_date='','<all>',d.event_date) as event_date,
    multiIf(d.event_name='','<all>',d.event_name) as event_name,
    multiIf(d.geo_country='','<all>',d.geo_country) as geo_country,
    multiIf(d.platform='','<all>',d.platform) as platform,
    sumState(d.count) as count,
    countState(distinct d.user_pseudo_id) as user_count
from aggregations.daily_user_activity d
where d.event_date between '20230301' and '20230331'
group by cube (d.event_date, d.platform, d.geo_country, d.event_name);

INSERT INTO lkovacevic.daily_event_activity (event_date,event_name, geo_country,platform, count, user_count)
SELECT
    multiIf(d.event_date='','<all>',d.event_date) as event_date,
    multiIf(d.event_name='','<all>',d.event_name) as event_name,
    multiIf(d.geo_country='','<all>',d.geo_country) as geo_country,
    multiIf(d.platform='','<all>',d.platform) as platform,
    sumState(d.count) as count,
    countState(distinct d.user_pseudo_id) as user_count
from aggregations.daily_user_activity d
where d.event_date between '20230401' and '20230430'
group by cube (d.event_date, d.platform, d.geo_country, d.event_name);

INSERT INTO lkovacevic.daily_event_activity (event_date,event_name, geo_country,platform, count, user_count)
SELECT
    multiIf(d.event_date='','<all>',d.event_date) as event_date,
    multiIf(d.event_name='','<all>',d.event_name) as event_name,
    multiIf(d.geo_country='','<all>',d.geo_country) as geo_country,
    multiIf(d.platform='','<all>',d.platform) as platform,
    sum(d.count) as count,
    count(distinct d.user_pseudo_id) as user_count
from aggregations.daily_user_activity d
where d.event_date between '20230501' and '20230531'
group by cube (d.event_date, d.platform, d.geo_country, d.event_name);

INSERT INTO lkovacevic.daily_event_activity (event_date,event_name, geo_country,platform, count, user_count)
SELECT
    multiIf(d.event_date='','<all>',d.event_date) as event_date,
    multiIf(d.event_name='','<all>',d.event_name) as event_name,
    multiIf(d.geo_country='','<all>',d.geo_country) as geo_country,
    multiIf(d.platform='','<all>',d.platform) as platform,
    sum(d.count) as count,
    count(distinct d.user_pseudo_id) as user_count
from aggregations.daily_user_activity d
where d.event_date between '20230601' and '20230630'
group by cube (d.event_date, d.platform, d.geo_country, d.event_name);

-- MONTH
drop table if exists lkovacevic.monthly_event_activity;
create table lkovacevic.monthly_event_activity
(
    event_date String CODEC(ZSTD(1)),
    event_name LowCardinality(String),
    geo_country LowCardinality(String),
    platform LowCardinality(String),
    count AggregateFunction(sum,UInt64) CODEC(ZSTD(1)),
    user_count AggregateFunction(count,UInt64) CODEC(ZSTD(1))
)
ENGINE = AggregatingMergeTree()
PARTITION BY event_date
order by (event_date,event_name,platform,geo_country)
SETTINGS index_granularity=8192;

INSERT INTO lkovacevic.monthly_event_activity (event_date,event_name, geo_country,platform, count, user_count)
SELECT
    multiIf(formatDateTime(toStartOfMonth(toDate(d.event_date)),'%Y%m%d')='','<all>',formatDateTime(toStartOfMonth(toDate(d.event_date)),'%Y%m%d')) as event_date,
    multiIf(d.event_name='','<all>',d.event_name) as event_name,
    multiIf(d.geo_country='','<all>',d.geo_country) as geo_country,
    multiIf(d.platform='','<all>',d.platform) as platform,
    sumState(d.count) as count,
    countState(distinct d.user_pseudo_id) as user_count
from aggregations.monthly_user_activity d
where formatDateTime(toStartOfMonth(toDate(event_date)),'%Y%m%d')='20230101'
group by cube(formatDateTime(toStartOfMonth(toDate(d.event_date)),'%Y%m%d'), d.platform, d.geo_country, d.event_name);

INSERT INTO lkovacevic.monthly_event_activity (event_date,event_name, geo_country,platform, count, user_count)
SELECT
    multiIf(formatDateTime(toStartOfMonth(toDate(event_date)),'%Y%m%d')='','<all>',formatDateTime(toStartOfMonth(toDate(event_date)),'%Y%m%d')) as event_date,
    multiIf(d.event_name='','<all>',d.event_name) as event_name,
    multiIf(d.geo_country='','<all>',d.geo_country) as geo_country,
    multiIf(d.platform='','<all>',d.platform) as platform,
    sumState(d.count) as count,
    countState(distinct d.user_pseudo_id) as user_count
from aggregations.monthly_user_activity d
where formatDateTime(toStartOfMonth(toDate(event_date)),'%Y%m%d')='20230201'
group by cube(formatDateTime(toStartOfMonth(toDate(event_date)),'%Y%m%d'), d.platform, d.geo_country, d.event_name);

INSERT INTO lkovacevic.monthly_event_activity (event_date,event_name, geo_country,platform, count, user_count)
SELECT
    multiIf(formatDateTime(toStartOfMonth(toDate(event_date)),'%Y%m%d')='','<all>',formatDateTime(toStartOfMonth(toDate(event_date)),'%Y%m%d')) as event_date,
    multiIf(d.event_name='','<all>',d.event_name) as event_name,
    multiIf(d.geo_country='','<all>',d.geo_country) as geo_country,
    multiIf(d.platform='','<all>',d.platform) as platform,
    sumState(d.count) as count,
    countState(distinct d.user_pseudo_id) as user_count
from aggregations.monthly_user_activity d
where formatDateTime(toStartOfMonth(toDate(event_date)),'%Y%m%d')='20230301'
group by cube(formatDateTime(toStartOfMonth(toDate(event_date)),'%Y%m%d'), d.platform, d.geo_country, d.event_name);

INSERT INTO lkovacevic.monthly_event_activity (event_date,event_name, geo_country,platform, count, user_count)
SELECT
    multiIf(formatDateTime(toStartOfMonth(toDate(event_date)),'%Y%m%d')='','<all>',formatDateTime(toStartOfMonth(toDate(event_date)),'%Y%m%d')) as event_date,
    multiIf(d.event_name='','<all>',d.event_name) as event_name,
    multiIf(d.geo_country='','<all>',d.geo_country) as geo_country,
    multiIf(d.platform='','<all>',d.platform) as platform,
    sumState(d.count) as count,
    countState(distinct d.user_pseudo_id) as user_count
from aggregations.monthly_user_activity d
where formatDateTime(toStartOfMonth(toDate(event_date)),'%Y%m%d')='20230401'
group by cube(formatDateTime(toStartOfMonth(toDate(event_date)),'%Y%m%d'), d.platform, d.geo_country, d.event_name);

INSERT INTO lkovacevic.monthly_event_activity (event_date,event_name, geo_country,platform, count, user_count)
SELECT
    multiIf(formatDateTime(toStartOfMonth(toDate(event_date)),'%Y%m%d')='','<all>',formatDateTime(toStartOfMonth(toDate(event_date)),'%Y%m%d')) as event_date,
    multiIf(d.event_name='','<all>',d.event_name) as event_name,
    multiIf(d.geo_country='','<all>',d.geo_country) as geo_country,
    multiIf(d.platform='','<all>',d.platform) as platform,
    sumState(d.count) as count,
    countState(distinct d.user_pseudo_id) as user_count
from aggregations.monthly_user_activity d
where formatDateTime(toStartOfMonth(toDate(event_date)),'%Y%m%d')='20230501'
group by cube(formatDateTime(toStartOfMonth(toDate(event_date)),'%Y%m%d'), d.platform, d.geo_country, d.event_name);

INSERT INTO lkovacevic.monthly_event_activity (event_date,event_name, geo_country,platform, count, user_count)
SELECT
    multiIf(formatDateTime(toStartOfMonth(toDate(event_date)),'%Y%m%d')='','<all>',formatDateTime(toStartOfMonth(toDate(event_date)),'%Y%m%d')) as event_date,
    multiIf(d.event_name='','<all>',d.event_name) as event_name,
    multiIf(d.geo_country='','<all>',d.geo_country) as geo_country,
    multiIf(d.platform='','<all>',d.platform) as platform,
    sumState(d.count) as count,
    countState(distinct d.user_pseudo_id) as user_count
from aggregations.monthly_user_activity d
where formatDateTime(toStartOfMonth(toDate(event_date)),'%Y%m%d')='20230601'
group by cube(formatDateTime(toStartOfMonth(toDate(event_date)),'%Y%m%d'), d.platform, d.geo_country, d.event_name);

select event_date,event_name,geo_country,platform,sumMerge(count),countMerge(user_count)
from lkovacevic.monthly_event_activity
group by cube(event_date, platform, geo_country, event_name) limit 50;