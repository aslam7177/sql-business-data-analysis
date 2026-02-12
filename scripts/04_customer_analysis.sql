-- ============================================================
-- FILE: 04_customer_analysis.sql
-- PROJECT: SQL Business Data Analysis (Sakila)
-- PURPOSE: Core Customer KPIs and Value Metrics
-- ============================================================


-- ============================================================
-- SECTION A: Customer Overview
-- ============================================================


-- 1. Total Registered Customers
-- ------------------------------------------------------------

SELECT COUNT(*) AS total_customers
FROM customer;


-- 2. Active Customers (Customers with at least one payment)
-- ------------------------------------------------------------

SELECT COUNT(DISTINCT customer_id) AS active_customers
FROM payment;


-- 3. Inactive Customers (No Payments Made)
-- ------------------------------------------------------------

SELECT COUNT(*) AS inactive_customers
FROM customer
WHERE customer_id NOT IN (
    SELECT DISTINCT customer_id FROM payment
);


-- ============================================================
-- SECTION B: Core Customer Value Metrics
-- ============================================================


-- 4. Customer Lifetime Value
-- ------------------------------------------------------------

SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    ROUND(SUM(p.amount), 2) AS lifetime_value
FROM payment p
JOIN customer c ON p.customer_id = c.customer_id
GROUP BY c.customer_id, customer_name
ORDER BY lifetime_value DESC;


-- 5. Top 10 Customers by Lifetime Value
-- ------------------------------------------------------------

SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    ROUND(SUM(p.amount), 2) AS lifetime_value
FROM payment p
JOIN customer c ON p.customer_id = c.customer_id
GROUP BY c.customer_id, customer_name
ORDER BY lifetime_value DESC
LIMIT 10;


-- 6. Average Revenue per Customer
-- ------------------------------------------------------------

SELECT 
    ROUND(AVG(customer_total), 2) AS avg_revenue_per_customer
FROM (
    SELECT 
        customer_id,
        SUM(amount) AS customer_total
    FROM payment
    GROUP BY customer_id
) t;

