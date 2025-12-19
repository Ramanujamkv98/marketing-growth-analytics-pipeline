
CREATE OR REPLACE TABLE `analytics-warehouse-481620.mart.mart_true_funnel_all_steps` AS
WITH base AS (

  SELECT
    customer_id,
    event_type,
    event_timestamp
  FROM `analytics-warehouse-481620.staging.stg_events`
  WHERE customer_id IS NOT NULL
    AND event_type IN ('visit','page_view','email_open','click','purchase')
),

step_times AS (
  SELECT
    customer_id,
    MIN(IF(event_type='visit',      event_timestamp, NULL)) AS visit_time,
    MIN(IF(event_type='page_view',  event_timestamp, NULL)) AS page_view_time,
    MIN(IF(event_type='email_open', event_timestamp, NULL)) AS email_open_time,
    MIN(IF(event_type='click',      event_timestamp, NULL)) AS click_time,
    MIN(IF(event_type='purchase',   event_timestamp, NULL)) AS purchase_time
  FROM base
  GROUP BY customer_id
),

sequential_flags AS (
  SELECT
    customer_id,
    visit_time,
    page_view_time,
    email_open_time,
    click_time,
    purchase_time,

    1 AS visited,

    IF(page_view_time IS NOT NULL
       AND page_view_time > visit_time, 1, 0) AS viewed_page,

    IF(email_open_time IS NOT NULL
       AND page_view_time IS NOT NULL
       AND email_open_time > page_view_time, 1, 0) AS opened_email,

    IF(click_time IS NOT NULL
       AND email_open_time IS NOT NULL
       AND click_time > email_open_time, 1, 0) AS clicked,

    IF(purchase_time IS NOT NULL
       AND click_time IS NOT NULL
       AND purchase_time > click_time, 1, 0) AS purchased
  FROM step_times
  WHERE visit_time IS NOT NULL
)

SELECT * FROM sequential_flags;
CREATE OR REPLACE TABLE `analytics-warehouse-481620.mart.mart_funnel_counts_all_steps` AS
SELECT 'visit' AS step, COUNT(*) AS customers
FROM `analytics-warehouse-481620.mart.mart_true_funnel_all_steps`

UNION ALL
SELECT 'page_view', COUNT(*)
FROM `analytics-warehouse-481620.mart.mart_true_funnel_all_steps`
WHERE viewed_page = 1

UNION ALL
SELECT 'email_open', COUNT(*)
FROM `analytics-warehouse-481620.mart.mart_true_funnel_all_steps`
WHERE opened_email = 1

UNION ALL
SELECT 'click', COUNT(*)
FROM `analytics-warehouse-481620.mart.mart_true_funnel_all_steps`
WHERE clicked = 1

UNION ALL
SELECT 'purchase', COUNT(*)
FROM `analytics-warehouse-481620.mart.mart_true_funnel_all_steps`
WHERE purchased = 1;
