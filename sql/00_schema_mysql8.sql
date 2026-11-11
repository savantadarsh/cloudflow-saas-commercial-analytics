-- CloudFlow | MySQL 8.0+ reproducible schema
-- Load the prepared CSVs included in data/cleaned/ using the
-- MySQL Workbench Table Data Import Wizard
-- with 'first row as column names'; these are nine flat staging tables.
-- No FK constraints are applied: quality checks deliberately surface source defects.
CREATE DATABASE IF NOT EXISTS cloudflow_portfolio;
USE cloudflow_portfolio;

CREATE TABLE IF NOT EXISTS products (
    productid INT, productname VARCHAR(40)
);
CREATE TABLE IF NOT EXISTS customers (
    customerid INT, customername VARCHAR(255)
);
CREATE TABLE IF NOT EXISTS users (
    userid VARCHAR(20), name VARCHAR(100), department VARCHAR(100),
    email VARCHAR(255), customerid INT, adminid VARCHAR(20)
);
CREATE TABLE IF NOT EXISTS subscriptions (
    subscriptionid INT, customerid INT, productid INT, numberofusers INT,
    currentstatus INT, revenue DECIMAL(16,2), orderdate DATETIME,
    expirationdate DATETIME, active TINYINT
);
CREATE TABLE IF NOT EXISTS payments (
    statusmovementid BIGINT, subscriptionid INT, statusid INT,
    movementdate DATETIME
);
CREATE TABLE IF NOT EXISTS cancellations (
    subscriptionid INT, canceldate DATETIME, cancelationreason1 VARCHAR(100),
    cancelationreason2 VARCHAR(100), cancelationreason3 VARCHAR(100)
);
CREATE TABLE IF NOT EXISTS frontend (
    eventlogid BIGINT, userid VARCHAR(20), eventid INT,
    eventtimestamp DATETIME
);
CREATE TABLE IF NOT EXISTS event_definitions (
    eventid INT, description VARCHAR(255), eventtype VARCHAR(100)
);
CREATE TABLE IF NOT EXISTS status_definitions (
    statusid INT, description VARCHAR(100)
);
