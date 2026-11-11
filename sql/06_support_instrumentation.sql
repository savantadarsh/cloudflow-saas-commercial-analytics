-- Optional supporting investigation; not used as company-wide support KPI.
-- Frontend events cover only 59 of 596 user IDs and span Apr-Jul 2023.
-- Event counts reflect available logs, not all customer activity.
USE cloudflow_portfolio;
SELECT eventid, COUNT(*) AS logged_events, COUNT(DISTINCT userid) AS observed_users
FROM frontend
GROUP BY eventid ORDER BY eventid;

-- Users with ticket events who also have a strictly earlier help/FAQ event.
-- Without session IDs this is observational, not proof that self-service prevented a ticket.
WITH first_ticket AS (
  SELECT userid, MIN(eventtimestamp) AS first_ticket_time
  FROM frontend WHERE eventid=4 GROUP BY userid
), previous_help AS (
  SELECT DISTINCT t.userid
  FROM first_ticket t
  JOIN frontend f ON f.userid=t.userid
    AND f.eventid IN (1,2)
    AND f.eventtimestamp<t.first_ticket_time
)
SELECT COUNT(*) AS observed_ticket_users,
       SUM(CASE WHEN h.userid IS NOT NULL THEN 1 ELSE 0 END) AS ticket_users_with_prior_help
FROM first_ticket t LEFT JOIN previous_help h USING(userid);
