-- ============================================================
-- FILE: 10_store_analysis.sql
-- PROJECT: SQL Business Data Analysis (Sakila)
-- PURPOSE: Core Store-Level Performance & Operational KPIs
-- ============================================================


-- ============================================================
-- SECTION A: Store Overview
-- ============================================================


-- 1. Total Number of Stores
-- ------------------------------------------------------------

SELECT 
    COUNT(*) AS total_stores
FROM store;


-- 2. Store Location Details
-- ------------------------------------------------------------

SELECT 
    s.store_id,
    c.city,
    co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city c ON a.city_id = c.city_id
JOIN country co ON c.country_id = co.country_id;


-- ============================================================
-- SECTION B: Store Revenue Performance
-- ============================================================


-- 3. Revenue per Store
-- ------------------------------------------------------------

SELECT 
    s.store_id,
    ROUND(SUM(p.amount), 2) AS total_revenue
FROM payment p
JOIN staff st ON p.staff_id = st.staff_id
JOIN store s ON st.store_id = s.store_id
GROUP BY s.store_id
ORDER BY total_revenue DESC;


-- 4. Average Payment Value per Store
-- ------------------------------------------------------------

SELECT 
    s.store_id,
    ROUND(AVG(p.amount), 2) AS avg_payment_value
FROM payment p
JOIN staff st ON p.staff_id = st.staff_id
JOIN store s ON st.store_id = s.store_id
GROUP BY s.store_id
ORDER BY avg_payment_value DESC;


-- ============================================================
-- SECTION C: Store Operational Metrics
-- ============================================================


-- 5. Total Rentals per Store
-- ------------------------------------------------------------

SELECT 
    s.store_id,
    COUNT(r.rental_id) AS total_rentals
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN store s ON i.store_id = s.store_id
GROUP BY s.store_id
ORDER BY total_rentals DESC;


-- 6. Total Customers per Store
-- ------------------------------------------------------------

SELECT 
    store_id,
    COUNT(customer_id) AS total_customers
FROM customer
GROUP BY store_id
ORDER BY total_customers DESC;


-- 7. Revenue per Rental (Store Efficiency)
-- ------------------------------------------------------------

SELECT 
    s.store_id,
    ROUND(SUM(p.amount) / COUNT(DISTINCT r.rental_id), 2) 
        AS revenue_per_rental
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN store s ON i.store_id = s.store_id
GROUP BY s.store_id
ORDER BY revenue_per_rental DESC;


-- 8. Revenue per Customer (Store Monetization)
-- ------------------------------------------------------------

SELECT 
    s.store_id,
    ROUND(SUM(p.amount) / COUNT(DISTINCT p.customer_id), 2) 
        AS revenue_per_customer
FROM payment p
JOIN staff st ON p.staff_id = st.staff_id
JOIN store s ON st.store_id = s.store_id
GROUP BY s.store_id
ORDER BY revenue_per_customer DESC;

