select event_date from lkovacevic.daily_event_activity
where platfrom='<all>' and event_name='<all>' and geo_country='<all>'
order by count_user
limit 1
;

select event_date from lkovacevic.monthly_event_activity
where platfrom='<all>' and event_name='<all>' and geo_country='<all>'
order by count_user
limit 1
;