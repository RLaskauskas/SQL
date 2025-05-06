-- https://docs.google.com/spreadsheets/d/16S47K2JvAhJY0HvRKhgNycrNWzEcZ4Gq-KuVYBIW4WM/edit?gid=0#gid=0
-- You should provide weekly subscriptions data that shows how many subscribers started their
--subscription in a particular week and how many remain active in the following 6 weeks.
--Your end result should show weekly retention cohorts for each week of data available in the
-- dataset and their retention from week 0 to week 6. Assume that you are doing this analysis on 2021-02-07.

WITH cohort_data AS (
SELECT
DATE_TRUNC(subscription_start, WEEK) AS cohort_week,
user_pseudo_id,
subscription_end,
DATE('2021-02-07') as LastDay
FROM
``
)

SELECT
cohort_week,
COUNT(DISTINCT user_pseudo_id) AS week_0,
COUNT(DISTINCT CASE WHEN (subscription_end IS NULL OR DATE_TRUNC(subscription_end, WEEK) > cohort_week) AND DATE_ADD(cohort_week, INTERVAL 1 WEEK) < LastDay THEN user_pseudo_id END) AS week_1,
COUNT(DISTINCT CASE WHEN (subscription_end IS NULL OR DATE_TRUNC(subscription_end, WEEK) > DATE_ADD(cohort_week, INTERVAL 1 WEEK)) AND DATE_ADD(cohort_week, INTERVAL 2 WEEK) < LastDay THEN user_pseudo_id END) AS week_2,
COUNT(DISTINCT CASE WHEN (subscription_end IS NULL OR DATE_TRUNC(subscription_end, WEEK) > DATE_ADD(cohort_week, INTERVAL 2 WEEK)) AND DATE_ADD(cohort_week, INTERVAL 3 WEEK) < LastDay THEN user_pseudo_id END) AS week_3,
COUNT(DISTINCT CASE WHEN (subscription_end IS NULL OR DATE_TRUNC(subscription_end, WEEK) > DATE_ADD(cohort_week, INTERVAL 3 WEEK)) AND DATE_ADD(cohort_week, INTERVAL 4 WEEK) < LastDay THEN user_pseudo_id END) AS week_4,
COUNT(DISTINCT CASE WHEN (subscription_end IS NULL OR DATE_TRUNC(subscription_end, WEEK) > DATE_ADD(cohort_week, INTERVAL 4 WEEK)) AND DATE_ADD(cohort_week, INTERVAL 5 WEEK) < LastDay THEN user_pseudo_id END) AS week_5,
COUNT(DISTINCT CASE WHEN (subscription_end IS NULL OR DATE_TRUNC(subscription_end, WEEK) > DATE_ADD(cohort_week, INTERVAL 5 WEEK)) AND DATE_ADD(cohort_week, INTERVAL 6 WEEK) < LastDay THEN user_pseudo_id END) AS week_6
FROM
cohort_data
GROUP BY
cohort_week
