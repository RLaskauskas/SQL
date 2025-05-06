-- https://docs.google.com/spreadsheets/d/1UsFktavqzwKvQCuBU62fi2Zh0YujUGNAJcrLEIDoPWU/edit?gid=1980647916#gid=1980647916

WITH all_ids as
(SELECT user_pseudo_id,
DATE_TRUNC(PARSE_DATE("%Y%m%d", event_date), WEEK) event_week,
SUM(purchase_revenue_in_usd) purchased_sum
FROM 
GROUP BY 1,2),

start_week AS
(SELECT user_pseudo_id,
DATE_TRUNC(PARSE_DATE("%Y%m%d", MIN(event_date)), WEEK) start_week,
FROM 
GROUP BY 1)

SELECT sw.start_week, COUNT(DISTINCT ai.user_pseudo_id) new_visitors,
SUM(CASE WHEN ai.event_week = sw.start_week then ai.purchased_sum else 0 end) week0sum,
SUM(CASE WHEN ai.event_week = DATE_ADD(sw.start_week, INTERVAL 1 WEEK) then ai.purchased_sum else 0 end) week1sum,
SUM(CASE WHEN ai.event_week = DATE_ADD(sw.start_week, INTERVAL 2 WEEK) then ai.purchased_sum else 0 end) week2sum,
SUM(CASE WHEN ai.event_week = DATE_ADD(sw.start_week, INTERVAL 3 WEEK) then ai.purchased_sum else 0 end) week3sum,
SUM(CASE WHEN ai.event_week = DATE_ADD(sw.start_week, INTERVAL 4 WEEK) then ai.purchased_sum else 0 end) week4sum,
SUM(CASE WHEN ai.event_week = DATE_ADD(sw.start_week, INTERVAL 5 WEEK) then ai.purchased_sum else 0 end) week5sum,
SUM(CASE WHEN ai.event_week = DATE_ADD(sw.start_week, INTERVAL 6 WEEK) then ai.purchased_sum else 0 end) week6sum,
SUM(CASE WHEN ai.event_week = DATE_ADD(sw.start_week, INTERVAL 7 WEEK) then ai.purchased_sum else 0 end) week7sum,
SUM(CASE WHEN ai.event_week = DATE_ADD(sw.start_week, INTERVAL 8 WEEK) then ai.purchased_sum else 0 end) week8sum,
SUM(CASE WHEN ai.event_week = DATE_ADD(sw.start_week, INTERVAL 9 WEEK) then ai.purchased_sum else 0 end) week9sum,
SUM(CASE WHEN ai.event_week = DATE_ADD(sw.start_week, INTERVAL 10 WEEK) then ai.purchased_sum else 0 end) week10sum,
SUM(CASE WHEN ai.event_week = DATE_ADD(sw.start_week, INTERVAL 11 WEEK) then ai.purchased_sum else 0 end) week11sum,
SUM(CASE WHEN ai.event_week = DATE_ADD(sw.start_week, INTERVAL 12 WEEK) then ai.purchased_sum else 0 end) week12sum

FROM all_ids ai
JOIN start_week sw
ON ai.user_pseudo_id = sw.user_pseudo_id
GROUP BY 1
ORDER BY 1
LIMIT 13
