create table lkovacevic.daily_user_activity
(
    event_date String,
    event_name String,
    user_pseudo_id String,
    geo_country String,
    platfrom String,
    count Int32
)
ENGINE=MergeTree
PARTITION BY event_date
order by (platfrom,user_pseudo_id)
SETTINGS index_granularity=8192;

INSERT INTO lkovacevic.daily_user_activity
SELECT e.event_date, e.event_name,e.user_pseudo_id,e.geo_country,e.platform,count(*) as count
from bq.events e
where e.event_date between '20230101' and '20230131'
group by e.event_date, e.event_name, e.user_pseudo_id, e.geo_country, e.platform;


INSERT INTO lkovacevic.daily_user_activity
SELECT e.event_date,e.event_name,e.user_pseudo_id,e.geo_country,e.platform,count(*) as count
from bq.events e
where e.event_date between '20230201' and '20230228'
group by e.event_date, e.event_name, e.user_pseudo_id, e.geo_country, e.platform;


INSERT INTO lkovacevic.daily_user_activity
SELECT e.event_date,e.event_name,e.user_pseudo_id,e.geo_country,e.platform,count(*) as count
from bq.events e
where e.event_date between '20230301' and '20230331'
group by e.event_date, e.event_name, e.user_pseudo_id, e.geo_country, e.platform;

INSERT INTO lkovacevic.daily_user_activity
SELECT e.event_date,e.event_name,e.user_pseudo_id,e.geo_country,e.platform,count(*) as count
from bq.events e
where e.event_date between '20230401' and '20230430'
group by e.event_date, e.event_name, e.user_pseudo_id, e.geo_country, e.platform;

INSERT INTO lkovacevic.daily_user_activity
SELECT e.event_date,e.event_name,e.user_pseudo_id,e.geo_country,e.platform,count(*) as count
from bq.events e
where e.event_date between '20230501' and '20230531'
group by e.event_date, e.event_name, e.user_pseudo_id, e.geo_country, e.platform;

INSERT INTO lkovacevic.daily_user_activity
SELECT e.event_date,e.event_name,e.user_pseudo_id,e.geo_country,e.platform,count(*) as count
from bq.events e
where e.event_date between '20230601' and '20230630'
group by e.event_date, e.event_name, e.user_pseudo_id, e.geo_country, e.platform;

create table lkovacevic.monthly_user_activity
(
    event_date String,
    event_name String,
    user_pseudo_id String,
    geo_country String,
    platfrom String,
    count Int32
)
ENGINE=MergeTree
PARTITION BY event_date
order by (platfrom,user_pseudo_id)
SETTINGS index_granularity=8192;

INSERT INTO lkovacevic.daily_user_activity
SELECT formatDateTime(toStartOfMonth(e.event_date)) as month,e.event_name,e.user_pseudo_id,e.geo_country,e.platform,count(*) as count
from bq.events e
where month='20230101'
group by month, e.event_name, e.user_pseudo_id, e.geo_country, e.platform;

INSERT INTO lkovacevic.daily_user_activity
SELECT formatDateTime(toStartOfMonth(e.event_date)) as month,e.event_name,e.user_pseudo_id,e.geo_country,e.platform,count(*) as count
from bq.events e
where month='20230201'
group by month, e.event_name, e.user_pseudo_id, e.geo_country, e.platform;

INSERT INTO lkovacevic.daily_user_activity
SELECT formatDateTime(toStartOfMonth(e.event_date)) as month,e.event_name,e.user_pseudo_id,e.geo_country,e.platform,count(*) as count
from bq.events e
where month='20230301'
group by month, e.event_name, e.user_pseudo_id, e.geo_country, e.platform;

INSERT INTO lkovacevic.daily_user_activity
SELECT formatDateTime(toStartOfMonth(e.event_date)) as month,e.event_name,e.user_pseudo_id,e.geo_country,e.platform,count(*) as count
from bq.events e
where month='20230401'
group by month, e.event_name, e.user_pseudo_id, e.geo_country, e.platform;

INSERT INTO lkovacevic.daily_user_activity
SELECT formatDateTime(toStartOfMonth(e.event_date)) as month,e.event_name,e.user_pseudo_id,e.geo_country,e.platform,count(*) as count
from bq.events e
where month='20230501'
group by month, e.event_name, e.user_pseudo_id, e.geo_country, e.platform;

INSERT INTO lkovacevic.daily_user_activity
SELECT formatDateTime(toStartOfMonth(e.event_date)) as month,e.event_name,e.user_pseudo_id,e.geo_country,e.platform,count(*) as count
from bq.events e
where month='20230601'
group by month, e.event_name, e.user_pseudo_id, e.geo_country, e.platform;