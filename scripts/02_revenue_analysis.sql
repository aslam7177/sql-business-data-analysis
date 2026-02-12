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


-- 6. Average Revenue per Rental
-- ------------------------------------------------------------

SELECT 
    ROUND(SUM(p.amount) / COUNT(DISTINCT r.rental_id), 2) 
    AS avg_revenue_per_rental
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id;


-- 7. Monthly Revenue Trend
-- ------------------------------------------------------------

SELECT 
    DATE_FORMAT(payment_date, '%Y-%m') AS revenue_month,
    ROUND(SUM(amount), 2) AS monthly_revenue
FROM payment
GROUP BY revenue_month
ORDER BY revenue_month;


-- 8. Revenue per Customer
-- ------------------------------------------------------------

SELECT 
    customer_id,
    ROUND(SUM(amount), 2) AS total_spent
FROM payment
GROUP BY customer_id
ORDER BY total_spent DESC;


-- 9A. Average Revenue per Customer (Direct Formula)
-- ------------------------------------------------------------

SELECT 
    ROUND(SUM(amount) / COUNT(DISTINCT customer_id), 2)
    AS avg_revenue_per_customer
FROM payment;

-- 9B. Average Revenue per Customer (Using Subquery)
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



-- 10. Revenue by Day of Week
-- ------------------------------------------------------------

SELECT 
    DAYNAME(payment_date) AS day_of_week,
    ROUND(SUM(amount), 2) AS total_revenue
FROM payment
GROUP BY day_of_week
ORDER BY total_revenue DESC;

