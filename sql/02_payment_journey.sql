-- Stakeholder: VP Product / Payments
-- Observational 2024 logs; grain is distinct subscriptionid, NOT events.
-- There is no payment_attempt_id, so repeated attempts within a subscription
-- cannot be uniquely reconstructed. Do NOT report causal abandonment.
USE cloudflow_portfolio;

WITH reach AS (
    SELECT subscriptionid,
      MAX(CASE WHEN statusid=1 THEN 1 ELSE 0 END) AS opened,
      MAX(CASE WHEN statusid=2 THEN 1 ELSE 0 END) AS entered,
      MAX(CASE WHEN statusid=3 THEN 1 ELSE 0 END) AS submitted,
      MAX(CASE WHEN statusid=4 THEN 1 ELSE 0 END) AS successful,
      MAX(CASE WHEN statusid=5 THEN 1 ELSE 0 END) AS completed
    FROM payments GROUP BY subscriptionid
), stage_totals AS (
    SELECT 1 AS step,'Widget opened' AS stage,SUM(opened) AS reached FROM reach
    UNION ALL SELECT 2,'Payment entered',SUM(entered) FROM reach
    UNION ALL SELECT 3,'Payment submitted',SUM(submitted) FROM reach
    UNION ALL SELECT 4,'Payment success',SUM(successful) FROM reach
    UNION ALL SELECT 5,'Complete',SUM(completed) FROM reach
)
SELECT step,stage,reached,
       ROUND(100.0*reached/NULLIF(FIRST_VALUE(reached) OVER (ORDER BY step),0),2) AS pct_of_opened,
       ROUND(100.0*reached/NULLIF(LAG(reached) OVER(ORDER BY step),0),2) AS pct_of_previous
FROM stage_totals ORDER BY step;

-- The final log state is NOT the maximum numeric state.
WITH latest AS (
    SELECT p.subscriptionid,p.statusid,p.movementdate,
           ROW_NUMBER() OVER(PARTITION BY p.subscriptionid
             ORDER BY p.movementdate DESC,p.statusmovementid DESC) AS rn
    FROM payments p
)
SELECT s.currentstatus AS source_currentstatus,
       l.statusid AS latest_logged_status,
       COUNT(*) AS subscription_count
FROM subscriptions s JOIN latest l ON s.subscriptionid=l.subscriptionid
WHERE l.rn=1
GROUP BY s.currentstatus,l.statusid
ORDER BY subscription_count DESC;

-- First-to-last event duration for completed subscriptions only.
-- A proxy for log span, NOT individual user time-on-task.
WITH spans AS (
 SELECT subscriptionid, MIN(movementdate) AS first_event,
        MAX(movementdate) AS last_event,
        MAX(CASE WHEN statusid=5 THEN 1 ELSE 0 END) AS completed
 FROM payments GROUP BY subscriptionid
)
SELECT COUNT(*) AS completed_subscriptions,
       ROUND(AVG(TIMESTAMPDIFF(MINUTE,first_event,last_event)),2) AS avg_log_span_minutes,
       MIN(TIMESTAMPDIFF(MINUTE,first_event,last_event)) AS min_log_span_minutes,
       MAX(TIMESTAMPDIFF(MINUTE,first_event,last_event)) AS max_log_span_minutes
FROM spans WHERE completed=1;
