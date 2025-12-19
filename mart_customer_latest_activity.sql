-- ============================================================
-- MART: Customer Latest Activity
-- Purpose:
--   Create a 1-row-per-customer snapshot of the most recent event.
--   Useful for engagement, churn-risk, and customer health reporting.
-- ============================================================

CREATE OR REPLACE TABLE `analytics-warehouse-481620.mart.mart_customer_latest_activity` AS
WITH ranked_events AS (
  SELECT
    customer_id,
    event_type,
    event_timestamp,

    -- Rank events per customer by most recent timestamp
    ROW_NUMBER() OVER (
      PARTITION BY customer_id
      ORDER BY event_timestamp DESC
    ) AS rn
  FROM `analytics-warehouse-481620.staging.stg_events`
  WHERE customer_id IS NOT NULL
)

SELECT
  customer_id,
  event_type AS last_event_type,
  event_timestamp AS last_event_time
FROM ranked_events
WHERE rn = 1;
