-- ============================================================
-- FILE: 03_revenue_performance.sql
-- PROJECT: SQL Business Data Analysis (Sakila)
-- PURPOSE: Advanced Revenue Performance & Growth Analysis
-- ============================================================


-- ============================================================
-- 1. Monthly Revenue with Growth Percentage
-- ============================================================

WITH monthly_revenue AS (
    SELECT 
        DATE_FORMAT(payment_date, '%Y-%m') AS revenue_month,
        SUM(amount) AS total_revenue
    FROM payment
    GROUP BY revenue_month
)

SELECT 
    revenue_month,
    total_revenue,
    LAG(total_revenue) OVER (ORDER BY revenue_month) AS previous_month_revenue,
    ROUND(
        (total_revenue - LAG(total_revenue) OVER (ORDER BY revenue_month)) 
        / LAG(total_revenue) OVER (ORDER BY revenue_month) * 100,
        2
    ) AS growth_percentage
FROM monthly_revenue;



-- ============================================================
-- 2. Cumulative Revenue Over Time
-- ============================================================

SELECT 
    DATE_FORMAT(payment_date, '%Y-%m') AS revenue_month,
    SUM(amount) AS monthly_revenue,
    SUM(SUM(amount)) OVER (ORDER BY DATE_FORMAT(payment_date, '%Y-%m')) 
        AS cumulative_revenue
FROM payment
GROUP BY revenue_month
ORDER BY revenue_month;


-- ============================================================
-- 3. Revenue Share by Store (% Contribution)
-- ============================================================

SELECT 
    s.store_id,
    ROUND(SUM(p.amount), 2) AS store_revenue,
    ROUND(
        SUM(p.amount) / (SELECT SUM(amount) FROM payment) * 100,
        2
    ) AS revenue_percentage
FROM payment p
JOIN staff st ON p.staff_id = st.staff_id
JOIN store s ON st.store_id = s.store_id
GROUP BY s.store_id
ORDER BY store_revenue DESC;



-- ============================================================
-- 4. Customer Revenue Ranking
-- ============================================================

SELECT 
    customer_id,
    SUM(amount) AS total_spent,
    RANK() OVER (ORDER BY SUM(amount) DESC) AS revenue_rank
FROM payment
GROUP BY customer_id;

