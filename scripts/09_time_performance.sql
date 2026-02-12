-- ============================================================
-- FILE: 09_time_performance.sql
-- PROJECT: SQL Business Data Analysis (Sakila)
-- PURPOSE: Advanced Time-Based Revenue Performance Analytics
-- ============================================================


-- ============================================================
-- SECTION A: Monthly Revenue with Running Total
-- ============================================================

SELECT 
    DATE_FORMAT(payment_date, '%Y-%m') AS revenue_month,
    SUM(amount) AS monthly_revenue,
    SUM(SUM(amount)) OVER (
        ORDER BY DATE_FORMAT(payment_date, '%Y-%m')
    ) AS cumulative_revenue
FROM payment
GROUP BY revenue_month
ORDER BY revenue_month;



-- ============================================================
-- SECTION B: Month-over-Month Growth %
-- ============================================================

SELECT 
    revenue_month,
    monthly_revenue,
    ROUND(
        (monthly_revenue - LAG(monthly_revenue) 
            OVER (ORDER BY revenue_month))
        /
        LAG(monthly_revenue) 
            OVER (ORDER BY revenue_month)
        * 100,
    2) AS mom_growth_percentage
FROM (
    SELECT 
        DATE_FORMAT(payment_date, '%Y-%m') AS revenue_month,
        SUM(amount) AS monthly_revenue
    FROM payment
    GROUP BY revenue_month
) t
ORDER BY revenue_month;



-- ============================================================
-- SECTION C: 3-Month Moving Average Revenue
-- ============================================================

SELECT 
    revenue_month,
    monthly_revenue,
    ROUND(
        AVG(monthly_revenue) OVER (
            ORDER BY revenue_month
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ),
    2) AS moving_avg_3_months
FROM (
    SELECT 
        DATE_FORMAT(payment_date, '%Y-%m') AS revenue_month,
        SUM(amount) AS monthly_revenue
    FROM payment
    GROUP BY revenue_month
) t
ORDER BY revenue_month;



-- ============================================================
-- SECTION D: Monthly Revenue Ranking
-- ============================================================

SELECT 
    revenue_month,
    monthly_revenue,
    RANK() OVER (ORDER BY monthly_revenue DESC) AS revenue_rank
FROM (
    SELECT 
        DATE_FORMAT(payment_date, '%Y-%m') AS revenue_month,
        SUM(amount) AS monthly_revenue
    FROM payment
    GROUP BY revenue_month
) t
ORDER BY revenue_rank;

