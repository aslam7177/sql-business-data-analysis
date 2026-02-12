-- ============================================================
-- FILE: 06_film_analysis.sql
-- PROJECT: SQL Business Data Analysis (Sakila)
-- PURPOSE: Core Film & Product Performance Analysis
-- ============================================================


-- ============================================================
-- SECTION A: Film Inventory Overview
-- ============================================================


-- 1. Total Number of Films
-- ------------------------------------------------------------

SELECT COUNT(*) AS total_films
FROM film;



-- 2. Total Inventory Copies Available
-- ------------------------------------------------------------

SELECT COUNT(*) AS total_inventory_units
FROM inventory;



-- ============================================================
-- SECTION B: Film Rental Performance
-- ============================================================


-- 3. Total Rentals per Film
-- ------------------------------------------------------------

SELECT 
    f.film_id,
    f.title,
    COUNT(r.rental_id) AS total_rentals
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.film_id, f.title
ORDER BY total_rentals DESC;



-- 4. Top 10 Most Rented Films
-- ------------------------------------------------------------

SELECT 
    f.film_id,
    f.title,
    COUNT(r.rental_id) AS total_rentals
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.film_id, f.title
ORDER BY total_rentals DESC
LIMIT 10;



-- ============================================================
-- SECTION C: Film Revenue Performance
-- ============================================================


-- 5. Revenue per Film
-- ------------------------------------------------------------

SELECT 
    f.film_id,
    f.title,
    ROUND(SUM(p.amount), 2) AS total_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.film_id, f.title
ORDER BY total_revenue DESC;



-- 6. Top 10 Films by Revenue
-- ------------------------------------------------------------

SELECT 
    f.film_id,
    f.title,
    ROUND(SUM(p.amount), 2) AS total_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.film_id, f.title
ORDER BY total_revenue DESC
LIMIT 10;


-- 7. Average Revenue per Film
-- ------------------------------------------------------------

SELECT 
    ROUND(AVG(film_revenue), 2) AS avg_revenue_per_film
FROM (
    SELECT 
        f.film_id,
        SUM(p.amount) AS film_revenue
    FROM payment p
    JOIN rental r ON p.rental_id = r.rental_id
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    GROUP BY f.film_id
) t;


-- 8. Film Rental Rate vs Total Revenue
-- ------------------------------------------------------------

SELECT 
    f.film_id,
    f.title,
    f.rental_rate,
    ROUND(SUM(p.amount), 2) AS total_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.film_id, f.title, f.rental_rate
ORDER BY total_revenue DESC;



