select count(distinct user_pseudo_id)
from bq.events
where event_name='drawer_action' and platform='IOS'
and item_name='Buzzer Feed';

