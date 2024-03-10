create table lkovacevic.daily_event_activity
(
    event_date String,
    event_name String,
    geo_country String,
    platform String,
    count Int32,
    user_count Int32
)
ENGINE=MergeTree
PARTITION BY event_date
order by (platform,geo_country)
SETTINGS index_granularity=8192;

INSERT INTO daily_event_activity (event_date,event_name, geo_country,platform, count, user_count)
SELECT
    d.event_date,
    coalesce(d.event_name,'<all>') as event_name,
    coalesce(d.geo_country,'<all>') as geo_country,
    coalesce(d.platfrom,'<all>') as platform,
    sum(d.count) as count,
    count(distinct d.user_pseudo_id) as user_count
from lkovacevic.daily_user_activity d
where d.event_date between '20230101' and '20230131'
group by rollup (d.event_date, d.platfrom, d.geo_country, d.event_name)
order by d.platfrom;

INSERT INTO daily_event_activity (event_date,event_name, geo_country,platform, count, user_count)
SELECT
    d.event_date,
    coalesce(d.event_name,'<all>') as event_name,
    coalesce(d.geo_country,'<all>') as geo_country,
    coalesce(d.platfrom,'<all>') as platform,
    sum(d.count) as count,
    count(distinct d.user_pseudo_id) as user_count
from lkovacevic.daily_user_activity d
where d.event_date between '20230201' and '20230228'
group by rollup (d.event_date, d.platfrom, d.geo_country, d.event_name)
order by d.platfrom;

INSERT INTO daily_event_activity (event_date,event_name, geo_country,platform, count, user_count)
SELECT
    d.event_date,
    coalesce(d.event_name,'<all>') as event_name,
    coalesce(d.geo_country,'<all>') as geo_country,
    coalesce(d.platfrom,'<all>') as platform,
    sum(d.count) as count,
    count(distinct d.user_pseudo_id) as user_count
from lkovacevic.daily_user_activity d
where d.event_date between '20230301' and '20230331'
group by rollup (d.event_date, d.platfrom, d.geo_country, d.event_name)
order by d.platfrom;

INSERT INTO daily_event_activity (event_date,event_name, geo_country,platform, count, user_count)
SELECT
    d.event_date,
    coalesce(d.event_name,'<all>') as event_name,
    coalesce(d.geo_country,'<all>') as geo_country,
    coalesce(d.platfrom,'<all>') as platform,
    sum(d.count) as count,
    count(distinct d.user_pseudo_id) as user_count
from lkovacevic.daily_user_activity d
where d.event_date between '20230401' and '20230430'
group by rollup (d.event_date, d.platfrom, d.geo_country, d.event_name)
order by d.platfrom;

INSERT INTO daily_event_activity (event_date,event_name, geo_country,platform, count, user_count)
SELECT
    d.event_date,
    coalesce(d.event_name,'<all>') as event_name,
    coalesce(d.geo_country,'<all>') as geo_country,
    coalesce(d.platfrom,'<all>') as platform,
    sum(d.count) as count,
    count(distinct d.user_pseudo_id) as user_count
from lkovacevic.daily_user_activity d
where d.event_date between '20230501' and '20230531'
group by rollup (d.event_date, d.platfrom, d.geo_country, d.event_name)
order by d.platfrom;

INSERT INTO daily_event_activity (event_date,event_name, geo_country,platform, count, user_count)
SELECT
    d.event_date,
    coalesce(d.event_name,'<all>') as event_name,
    coalesce(d.geo_country,'<all>') as geo_country,
    coalesce(d.platfrom,'<all>') as platform,
    sum(d.count) as count,
    count(distinct d.user_pseudo_id) as user_count
from lkovacevic.daily_user_activity d
where d.event_date between '20230601' and '20230630'
group by rollup (d.event_date, d.platfrom, d.geo_country, d.event_name)
order by d.platfrom;

update daily_event_activity
set platform = '<all>', geo_country = '<all>', event_name = '<all>'
where platform is null or geo_country is null or event_name is null;

create table lkovacevic.monthly_event_activity
(
    event_date String,
    event_name String,
    geo_country String,
    platform String,
    count Int32,
    user_count Int32
)
ENGINE=MergeTree
PARTITION BY event_date
order by (platform,geo_country)
SETTINGS index_granularity=8192;

INSERT INTO monthly_event_activity (event_date,event_name, geo_country,platform, count, user_count)
SELECT
    formatDateTime(toStartOfMonth(e.event_date)) as month,
    coalesce(d.event_name,'<all>') as event_name,
    coalesce(d.geo_country,'<all>') as geo_country,
    coalesce(d.platfrom,'<all>') as platform,
    sum(d.count) as count,
    count(distinct d.user_pseudo_id) as user_count
from lkovacevic.monthly_user_activity d
where month='20230101'
group by rollup (month, d.platfrom, d.geo_country, d.event_name)
order by d.platfrom;

INSERT INTO monthly_event_activity (event_date,event_name, geo_country,platform, count, user_count)
SELECT
    formatDateTime(toStartOfMonth(e.event_date)) as month,
    coalesce(d.event_name,'<all>') as event_name,
    coalesce(d.geo_country,'<all>') as geo_country,
    coalesce(d.platfrom,'<all>') as platform,
    sum(d.count) as count,
    count(distinct d.user_pseudo_id) as user_count
from lkovacevic.monthly_user_activity d
where month='20230201'
group by rollup (month, d.platfrom, d.geo_country, d.event_name)
order by d.platfrom;


INSERT INTO monthly_event_activity (event_date,event_name, geo_country,platform, count, user_count)
SELECT
    formatDateTime(toStartOfMonth(e.event_date)) as month,
    coalesce(d.event_name,'<all>') as event_name,
    coalesce(d.geo_country,'<all>') as geo_country,
    coalesce(d.platfrom,'<all>') as platform,
    sum(d.count) as count,
    count(distinct d.user_pseudo_id) as user_count
from lkovacevic.monthly_user_activity d
where month='20230301'
group by rollup (month, d.platfrom, d.geo_country, d.event_name)
order by d.platfrom;

INSERT INTO monthly_event_activity (event_date,event_name, geo_country,platform, count, user_count)
SELECT
    formatDateTime(toStartOfMonth(e.event_date)) as month,
    coalesce(d.event_name,'<all>') as event_name,
    coalesce(d.geo_country,'<all>') as geo_country,
    coalesce(d.platfrom,'<all>') as platform,
    sum(d.count) as count,
    count(distinct d.user_pseudo_id) as user_count
from lkovacevic.monthly_user_activity d
where month='20230401'
group by rollup (month, d.platfrom, d.geo_country, d.event_name)
order by d.platfrom;

INSERT INTO monthly_event_activity (event_date,event_name, geo_country,platform, count, user_count)
SELECT
    formatDateTime(toStartOfMonth(e.event_date)) as month,
    coalesce(d.event_name,'<all>') as event_name,
    coalesce(d.geo_country,'<all>') as geo_country,
    coalesce(d.platfrom,'<all>') as platform,
    sum(d.count) as count,
    count(distinct d.user_pseudo_id) as user_count
from lkovacevic.monthly_user_activity d
where month='20230501'
group by rollup (month, d.platfrom, d.geo_country, d.event_name)
order by d.platfrom;

INSERT INTO monthly_event_activity (event_date,event_name, geo_country,platform, count, user_count)
SELECT
    formatDateTime(toStartOfMonth(e.event_date)) as month,
    coalesce(d.event_name,'<all>') as event_name,
    coalesce(d.geo_country,'<all>') as geo_country,
    coalesce(d.platfrom,'<all>') as platform,
    sum(d.count) as count,
    count(distinct d.user_pseudo_id) as user_count
from lkovacevic.monthly_user_activity d
where month='20230601'
group by rollup (month, d.platfrom, d.geo_country, d.event_name)
order by d.platfrom;

update monthly_event_activity
set platform = '<all>', geo_country = '<all>', event_name = '<all>'
where platform is null or geo_country is null or event_name is null;