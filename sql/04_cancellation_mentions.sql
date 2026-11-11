-- Stakeholder: Customer Success
-- Multi-select reasons: shares can sum to over 100%.
-- 59 cancellation records; NOT the overall subscription churn rate.
USE cloudflow_portfolio;
WITH reasons AS (
 SELECT subscriptionid, 'Too expensive' AS reason,
        CASE WHEN LOWER(CONCAT_WS(' | ',cancelationreason1,cancelationreason2,cancelationreason3))
             LIKE '%too expensive%' THEN 1 ELSE 0 END AS mentioned
 FROM cancellations
 UNION ALL
 SELECT subscriptionid, 'Lack of features',
        CASE WHEN LOWER(CONCAT_WS(' | ',cancelationreason1,cancelationreason2,cancelationreason3))
             LIKE '%lack of features%' THEN 1 ELSE 0 END
 FROM cancellations
 UNION ALL
 SELECT subscriptionid, 'No longer needed',
        CASE WHEN LOWER(CONCAT_WS(' | ',cancelationreason1,cancelationreason2,cancelationreason3))
             LIKE '%no longer needed%' THEN 1 ELSE 0 END
 FROM cancellations
 UNION ALL
 SELECT subscriptionid, 'Found alternative',
        CASE WHEN LOWER(CONCAT_WS(' | ',cancelationreason1,cancelationreason2,cancelationreason3))
             LIKE '%found alternative%' THEN 1 ELSE 0 END
 FROM cancellations
 UNION ALL
 SELECT subscriptionid, 'Poor customer service',
        CASE WHEN LOWER(CONCAT_WS(' | ',cancelationreason1,cancelationreason2,cancelationreason3))
             LIKE '%poor customer service%' THEN 1 ELSE 0 END
 FROM cancellations
 UNION ALL
 SELECT subscriptionid, 'Temporary cancellation',
        CASE WHEN LOWER(CONCAT_WS(' | ',cancelationreason1,cancelationreason2,cancelationreason3))
             LIKE '%temporary cancellation%' THEN 1 ELSE 0 END
 FROM cancellations
)
SELECT reason,COUNT(DISTINCT CASE WHEN mentioned=1 THEN subscriptionid END) AS records_mentioning,
       ROUND(100.0*COUNT(DISTINCT CASE WHEN mentioned=1 THEN subscriptionid END)
             /(SELECT COUNT(*) FROM cancellations),2) AS pct_of_cancellation_records
FROM reasons GROUP BY reason ORDER BY records_mentioning DESC;
