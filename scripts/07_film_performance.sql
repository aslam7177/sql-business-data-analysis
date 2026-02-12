-- ============================================================
-- FILE: 07_film_performance.sql
-- PROJECT: SQL Business Data Analysis (Sakila)
-- PURPOSE: Advanced Film & Product Performance Analytics
-- ============================================================


-- ============================================================
-- SECTION A: Film Revenue Ranking
-- ============================================================


-- 1. Rank Films by Total Revenue
-- ------------------------------------------------------------

SELECT 
    f.film_id,
    f.title,
    SUM(p.amount) AS total_revenue,
    DENSE_RANK() OVER (ORDER BY SUM(p.amount) DESC) AS revenue_rank
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.film_id, f.title;


-- ============================================================
-- SECTION B: Revenue Contribution Percentage
-- ============================================================


-- 2. Revenue Contribution % per Film
-- ------------------------------------------------------------

SELECT 
    f.film_id,
    f.title,
    SUM(p.amount) AS total_revenue,
    ROUND(
        SUM(p.amount) / SUM(SUM(p.amount)) OVER () * 100,
        2
    ) AS revenue_percentage
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.film_id, f.title
ORDER BY total_revenue DESC;



-- ============================================================
-- SECTION C: Cumulative Revenue (Pareto Analysis)
-- ============================================================


-- 3. Cumulative Revenue Share by Film
-- ------------------------------------------------------------

WITH film_revenue AS (
    SELECT 
        f.film_id,
        f.title,
        SUM(p.amount) AS total_revenue
    FROM payment p
    JOIN rental r ON p.rental_id = r.rental_id
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    GROUP BY f.film_id, f.title
)

SELECT 
    film_id,
    title,
    total_revenue,
    SUM(total_revenue) OVER (ORDER BY total_revenue DESC) AS cumulative_revenue,
    ROUND(
        SUM(total_revenue) OVER (ORDER BY total_revenue DESC)
        / SUM(total_revenue) OVER () * 100,
        2
    ) AS cumulative_percentage
FROM film_revenue;



-- ============================================================
-- SECTION D: Category Revenue Ranking
-- ============================================================


-- 4. Rank Categories by Revenue
-- ------------------------------------------------------------

SELECT 
    c.name AS category_name,
    SUM(p.amount) AS total_revenue,
    RANK() OVER (ORDER BY SUM(p.amount) DESC) AS category_rank
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film_category fc ON i.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY category_name;


-- 5. Films Contributing to Top 80% of Revenue
-- ------------------------------------------------------------

WITH film_revenue AS (
    SELECT 
        f.film_id,
        f.title,
        SUM(p.amount) AS total_revenue
    FROM payment p
    JOIN rental r ON p.rental_id = r.rental_id
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    GROUP BY f.film_id, f.title
),
revenue_distribution AS (
    SELECT 
        film_id,
        title,
        total_revenue,
        SUM(total_revenue) OVER (ORDER BY total_revenue DESC) 
            / SUM(total_revenue) OVER () * 100 AS cumulative_percentage
    FROM film_revenue
)

SELECT *
FROM revenue_distribution
WHERE cumulative_percentage <= 80;


