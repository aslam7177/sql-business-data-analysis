-- ============================================================
-- FILE: 05_customer_performance.sql
-- PROJECT: SQL Business Data Analysis (Sakila)
-- PURPOSE: Advanced Customer Analytics & Performance Insights
-- ============================================================


-- ============================================================
-- SECTION A: Customer Revenue Ranking
-- ============================================================


-- 1. Rank Customers by Lifetime Revenue
-- ------------------------------------------------------------

SELECT 
    customer_id,
    SUM(amount) AS lifetime_value,
    RANK() OVER (ORDER BY SUM(amount) DESC) AS revenue_rank
FROM payment
GROUP BY customer_id;



-- ============================================================
-- SECTION B: Customer Revenue Contribution %
-- ============================================================


-- 2. Revenue Contribution Percentage per Customer
-- ------------------------------------------------------------

SELECT 
    customer_id,
    SUM(amount) AS customer_revenue,
    ROUND(
        SUM(amount) / SUM(SUM(amount)) OVER () * 100, 
        2
    ) AS revenue_percentage
FROM payment
GROUP BY customer_id
ORDER BY customer_revenue DESC;



-- ============================================================
-- SECTION C: Customer Segmentation (High / Medium / Low)
-- ============================================================


-- 3. Segment Customers by Revenue Level
-- ------------------------------------------------------------

SELECT 
    customer_id,
    SUM(amount) AS lifetime_value,
    CASE 
        WHEN SUM(amount) >= 150 THEN 'High Value'
        WHEN SUM(amount) >= 100 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM payment
GROUP BY customer_id
ORDER BY lifetime_value DESC;



-- ============================================================
-- SECTION D: Customer Purchase Frequency
-- ============================================================


-- 4. Total Rentals per Customer
-- ------------------------------------------------------------

SELECT 
    customer_id,
    COUNT(*) AS total_payments
FROM payment
GROUP BY customer_id
ORDER BY total_payments DESC;



-- ============================================================
-- SECTION E: Customer Recency Analysis
-- ============================================================


-- 5. Last Purchase Date per Customer
-- ------------------------------------------------------------

SELECT 
    customer_id,
    MAX(payment_date) AS last_purchase_date
FROM payment
GROUP BY customer_id
ORDER BY last_purchase_date DESC;

