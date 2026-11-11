-- CloudFlow | Published-findings reconciliation (MySQL 8)
-- Run AFTER importing the nine prepared CSV tables into cloudflow_portfolio.
-- These SELECTs compare key definitions against snapshot figures in the README.
-- They are NOT evidence of a successful live database execution until run.
USE cloudflow_portfolio;

WITH yearly AS (
    SELECT YEAR(orderdate) AS order_year, SUM(revenue) AS actual_value
    FROM subscriptions
    WHERE YEAR(orderdate) IN (2022, 2023)
    GROUP BY YEAR(orderdate)
)
SELECT CONCAT('Order value ', order_year) AS metric,
       actual_value, 
       CASE WHEN order_year = 2022 THEN 4152600 ELSE 4597700 END AS published_value,
       actual_value - CASE WHEN order_year = 2022 THEN 4152600 ELSE 4597700 END AS difference
FROM yearly ORDER BY order_year;

WITH reached AS (
    SELECT subscriptionid,
           MAX(statusid = 1) AS opened,
           MAX(statusid = 5) AS complete
    FROM payments GROUP BY subscriptionid
)
SELECT 'Payment widget opened' AS metric, SUM(opened) AS actual_count,
       403 AS published_count, SUM(opened) - 403 AS difference FROM reached
UNION ALL
SELECT 'Payment Complete' AS metric, SUM(complete),
       78, SUM(complete) - 78 FROM reached;

WITH candidates AS (
    SELECT customerid
    FROM subscriptions
    WHERE active = 1
    GROUP BY customerid
    HAVING COUNT(DISTINCT productid) = 1 AND MAX(numberofusers) >= 5000
)
SELECT 'Expansion-screen accounts' AS metric,
       COUNT(*) AS actual_count, 164 AS published_count,
       COUNT(*) - 164 AS difference
FROM candidates;

SELECT 'Cancellation records' AS metric, COUNT(*) AS actual_count,
       59 AS published_count, COUNT(*) - 59 AS difference
FROM cancellations;
