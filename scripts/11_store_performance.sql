-- ============================================================
-- FILE: 11_store_performance.sql
-- PROJECT: SQL Business Data Analysis (Sakila)
-- PURPOSE: Advanced Store-Level Performance & Growth Analytics
-- ============================================================


-- ============================================================
-- SECTION A: Store Revenue Ranking
-- ============================================================


-- 1. Rank Stores by Total Revenue
-- ------------------------------------------------------------

SELECT 
    s.store_id,
    SUM(p.amount) AS total_revenue,
    DENSE_RANK() OVER (ORDER BY SUM(p.amount) DESC) AS revenue_rank
FROM payment p
JOIN staff st ON p.staff_id = st.staff_id
JOIN store s ON st.store_id = s.store_id
GROUP BY s.store_id;


-- ============================================================
-- SECTION B: Store Revenue Contribution %
-- ============================================================


-- 2. Revenue Contribution Percentage per Store
-- ------------------------------------------------------------

SELECT 
    s.store_id,
    SUM(p.amount) AS total_revenue,
    ROUND(
        SUM(p.amount) / SUM(SUM(p.amount)) OVER () * 100,
        2
    ) AS revenue_percentage
FROM payment p
JOIN staff st ON p.staff_id = st.staff_id
JOIN store s ON st.store_id = s.store_id
GROUP BY s.store_id
ORDER BY total_revenue DESC;


-- ============================================================
-- SECTION C: Cumulative Revenue Share (Pareto)
-- ============================================================


-- 3. Cumulative Revenue Percentage by Store
-- ------------------------------------------------------------

WITH store_revenue AS (
    SELECT 
        s.store_id,
        SUM(p.amount) AS total_revenue
    FROM payment p
    JOIN staff st ON p.staff_id = st.staff_id
    JOIN store s ON st.store_id = s.store_id
    GROUP BY s.store_id
)

SELECT 
    store_id,
    total_revenue,
    SUM(total_revenue) OVER (ORDER BY total_revenue DESC) AS cumulative_revenue,
    ROUND(
        SUM(total_revenue) OVER (ORDER BY total_revenue DESC)
        / SUM(total_revenue) OVER () * 100,
        2
    ) AS cumulative_percentage
FROM store_revenue;


-- ============================================================
-- SECTION D: Monthly Store Revenue Growth
-- ============================================================


-- 4. Month-over-Month Revenue Growth per Store
-- ------------------------------------------------------------

WITH monthly_store_revenue AS (
    SELECT 
        s.store_id,
        DATE_FORMAT(p.payment_date, '%Y-%m') AS revenue_month,
        SUM(p.amount) AS monthly_revenue
    FROM payment p
    JOIN staff st ON p.staff_id = st.staff_id
    JOIN store s ON st.store_id = s.store_id
    GROUP BY s.store_id, revenue_month
)

SELECT 
    store_id,
    revenue_month,
    monthly_revenue,
    ROUND(
        (monthly_revenue - LAG(monthly_revenue) 
            OVER (PARTITION BY store_id ORDER BY revenue_month))
        /
        LAG(monthly_revenue) 
            OVER (PARTITION BY store_id ORDER BY revenue_month)
        * 100,
    2) AS growth_percentage
FROM monthly_store_revenue
ORDER BY store_id, revenue_month;



