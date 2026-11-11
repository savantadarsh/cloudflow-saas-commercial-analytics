-- Optional indexes: run ONCE AFTER loading the normalised CSVs.
USE cloudflow_portfolio;
CREATE INDEX idx_orders_customer ON subscriptions(customerid);
CREATE INDEX idx_orders_month ON subscriptions(orderdate, productid);
CREATE INDEX idx_payments_journey ON payments(subscriptionid, movementdate, statusmovementid);
CREATE INDEX idx_frontend_user ON frontend(userid, eventtimestamp);
