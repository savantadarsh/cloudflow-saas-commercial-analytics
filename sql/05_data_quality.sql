-- Source QA for reproducibility. Counts should match outputs/data_quality_checks.csv.
USE cloudflow_portfolio;
SELECT 'duplicate customer dimension keys' AS issue,
       COALESCE(SUM(n-1),0) AS affected_rows
FROM (SELECT customerid,COUNT(*) AS n FROM customers GROUP BY customerid HAVING COUNT(*)>1) d
UNION ALL
SELECT 'unmatched payment subscription FK',COUNT(*)
FROM payments p LEFT JOIN subscriptions s USING(subscriptionid) WHERE s.subscriptionid IS NULL
UNION ALL
SELECT 'cancellation before order date',COUNT(*)
FROM cancellations c JOIN subscriptions s USING(subscriptionid) WHERE c.canceldate<s.orderdate
UNION ALL
SELECT 'inactive subscription without cancellation',COUNT(*)
FROM subscriptions s LEFT JOIN cancellations c USING(subscriptionid)
WHERE s.active=0 AND c.subscriptionid IS NULL;

WITH latest AS (
 SELECT subscriptionid,statusid,
        ROW_NUMBER() OVER(PARTITION BY subscriptionid
          ORDER BY movementdate DESC,statusmovementid DESC) AS rn
 FROM payments
)
SELECT COUNT(*) AS latest_payment_status_mismatches
FROM latest l JOIN subscriptions s USING(subscriptionid)
WHERE l.rn=1 AND l.statusid<>s.currentstatus;
