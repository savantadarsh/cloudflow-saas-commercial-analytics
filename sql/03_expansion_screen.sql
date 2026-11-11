-- Stakeholder: Customer Success / Revenue Operations
-- This is a list for SALES VALIDATION, NOT a predicted conversion list.
-- 'active' has no as-of date. MAX(numberofusers) is a seats proxy,
-- NOT a deduplicated company-wide seat total.
USE cloudflow_portfolio;

WITH active_account AS (
 SELECT customerid,
        COUNT(DISTINCT subscriptionid) AS active_subscription_rows,
        COUNT(DISTINCT productid) AS active_products,
        MAX(numberofusers) AS largest_subscription_seats,
        SUM(revenue) AS historical_recorded_order_value
 FROM subscriptions
 WHERE active=1
 GROUP BY customerid
)
SELECT customerid,active_subscription_rows,active_products,
       largest_subscription_seats,historical_recorded_order_value
FROM active_account
WHERE active_products=1 AND largest_subscription_seats>=5000
ORDER BY largest_subscription_seats DESC,historical_recorded_order_value DESC;

-- 164 accounts under the screen above (provided source version).
-- Joining to raw customers may create duplicates: customerid is not unique
-- there. Resolve the customer dimension before adding account names.
