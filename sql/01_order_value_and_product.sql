-- Stakeholder: Head of Revenue Operations
-- Revenue is RECORDED ORDER VALUE, not MRR or cash receipts.
USE cloudflow_portfolio;

-- 24 distinct month buckets: preserves year-month grouping across 24 observed months.
SELECT
    DATE_FORMAT(orderdate,'%Y-%m') AS order_month,
    COUNT(*) AS subscription_orders,
    COUNT(DISTINCT customerid) AS ordering_customers,
    SUM(revenue) AS recorded_order_value
FROM subscriptions
GROUP BY DATE_FORMAT(orderdate,'%Y-%m')
ORDER BY order_month;

-- Relative and absolute product contributions to YoY movement.
WITH product_year AS (
    SELECT p.productid, p.productname, YEAR(s.orderdate) AS order_year,
           SUM(s.revenue) AS recorded_order_value
    FROM subscriptions s
    JOIN products p ON s.productid=p.productid
    WHERE YEAR(s.orderdate) IN (2022,2023)
    GROUP BY p.productid,p.productname,YEAR(s.orderdate)
), pivoted AS (
    SELECT productid,productname,
           SUM(CASE WHEN order_year=2022 THEN recorded_order_value ELSE 0 END) AS value_2022,
           SUM(CASE WHEN order_year=2023 THEN recorded_order_value ELSE 0 END) AS value_2023
    FROM product_year GROUP BY productid,productname
)
SELECT productname,value_2022,value_2023,(value_2023-value_2022) AS absolute_change,
       ROUND(100.0*(value_2023-value_2022)/NULLIF(value_2022,0),2) AS growth_pct
FROM pivoted
ORDER BY absolute_change DESC;

-- Monthly revenue movement, excluding months with no rows (none missing here).
WITH monthly AS (
   SELECT DATE_FORMAT(orderdate,'%Y-%m') AS ym,SUM(revenue) AS recorded_order_value
   FROM subscriptions GROUP BY DATE_FORMAT(orderdate,'%Y-%m')
)
SELECT ym, recorded_order_value,
       LAG(recorded_order_value) OVER(ORDER BY ym) AS preceding_month_value,
       recorded_order_value-LAG(recorded_order_value) OVER(ORDER BY ym) AS absolute_change,
       ROUND(100*(recorded_order_value/LAG(recorded_order_value) OVER(ORDER BY ym)-1),2) AS mom_pct
FROM monthly ORDER BY ym;
