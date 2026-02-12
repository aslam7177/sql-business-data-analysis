-- ============================================================
-- FILE: 02_revenue_analysis.sql
-- PROJECT: SQL Business Data Analysis (Sakila)
-- PURPOSE: Core Revenue KPI Analysis
-- ============================================================


-- ============================================================
-- SECTION A: Core Revenue Metrics
-- ============================================================


-- 1. Total Revenue Generated
-- ------------------------------------------------------------

SELECT 
    SUM(amount) AS total_revenue
FROM payment;


-- 2. Total Number of Payments
-- ------------------------------------------------------------

SELECT 
    COUNT(*) AS total_payments
FROM payment;


-- 3. Average Revenue per Payment
-- ------------------------------------------------------------

SELECT 
    ROUND(AVG(amount), 2) AS avg_revenue_per_payment
FROM payment;


-- 4. Revenue by Store
-- ------------------------------------------------------------

SELECT 
    s.store_id,
    ROUND(SUM(p.amount), 2) AS store_revenue
FROM payment p
JOIN staff st ON p.staff_id = st.staff_id
JOIN store s ON st.store_id = s.store_id
GROUP BY s.store_id
ORDER BY store_revenue DESC;


-- 5. Revenue by Film Category
-- ------------------------------------------------------------

SELECT 
    c.name AS category_name,
    ROUND(SUM(p.amount), 2) AS category_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film_category fc ON i.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY category_name
ORDER BY category_revenue DESC;

