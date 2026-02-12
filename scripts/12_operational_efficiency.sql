-- ============================================================
-- FILE: 12_operational_efficiency.sql
-- PROJECT: SQL Business Data Analysis (Sakila)
-- PURPOSE: Operational Efficiency & Rental Behavior Analysis
-- ============================================================


-- ============================================================
-- 1. Average Actual Rental Duration (in days)
-- ------------------------------------------------------------

SELECT 
    ROUND(AVG(DATEDIFF(return_date, rental_date)), 2) 
    AS avg_actual_rental_days
FROM rental
WHERE return_date IS NOT NULL;


-- 2. Total Late Returns
-- ------------------------------------------------------------

SELECT 
    COUNT(*) AS late_returns
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE DATEDIFF(r.return_date, r.rental_date) > f.rental_duration;


-- 3. Late Return Percentage
-- ------------------------------------------------------------

SELECT 
    ROUND(
        SUM(
            CASE 
                WHEN DATEDIFF(r.return_date, r.rental_date) > f.rental_duration 
                THEN 1 
                ELSE 0 
            END
        ) / COUNT(*) * 100,
        2
    ) AS late_return_percentage
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE r.return_date IS NOT NULL;



-- ============================================================
-- SECTION B: Inventory Utilization
-- ============================================================


-- 4. Inventory Utilization (Number of Rentals per Inventory Item)
-- ------------------------------------------------------------

SELECT 
    inventory_id,
    COUNT(rental_id) AS total_rentals
FROM rental
GROUP BY inventory_id
ORDER BY total_rentals DESC;


-- 5. Most Frequently Rented Films
-- ------------------------------------------------------------

SELECT 
    f.title,
    COUNT(r.rental_id) AS total_rentals
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY total_rentals DESC
LIMIT 10;


-- ============================================================
-- SECTION C: Rental Processing Efficiency
-- ============================================================


-- 6. Average Time Between Rental and Payment (in days)
-- ------------------------------------------------------------

SELECT 
    ROUND(AVG(DATEDIFF(p.payment_date, r.rental_date)), 2) 
    AS avg_days_to_payment
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id;


-- 7. Average Rentals per Film
-- ------------------------------------------------------------

SELECT 
    ROUND(COUNT(r.rental_id) / COUNT(DISTINCT f.film_id), 2)
    AS avg_rentals_per_film
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id;





