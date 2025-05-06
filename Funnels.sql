-- https://docs.google.com/spreadsheets/d/1sBnBfNl4RNegNuBefv_EB1iFDZuwxzD-T-PN1PM2aB4/edit?gid=2037317246#gid=2037317246

WITH UniqueUserEvents AS (			
SELECT			
user_pseudo_id			
,country			
,event_name			
,MIN(event_timestamp) AS event_timestamp			
FROM 		
WHERE event_name IN ('page_view', 'view_item', 'add_to_cart', 'begin_checkout', 'purchase')			
GROUP BY			
user_pseudo_id			
,country			
,event_name			
),			
country_counts AS (			
SELECT country,			
COUNT(*) AS row_count			
FROM UniqueUserEvents			
GROUP BY country			
ORDER BY row_count DESC			
LIMIT 3			
)			
SELECT			
uue.event_name,			
uue.country			
FROM UniqueUserEvents uue			
JOIN country_counts cc ON uue.country = cc.country			
ORDER BY uue.user_pseudo_id, uue.event_name;			
