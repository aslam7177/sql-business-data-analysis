-- ============================================================
-- FILE: 08_time_analysis.sql
-- PROJECT: SQL Business Data Analysis (Sakila)
-- PURPOSE: Time-Based Revenue and Operational Trend Analysis
-- ============================================================


-- ============================================================
-- SECTION A: Yearly Revenue Trend
-- ============================================================


-- 1. Revenue by Year
-- ------------------------------------------------------------

SELECT 
    YEAR(payment_date) AS revenue_year,
    ROUND(SUM(amount), 2) AS total_revenue
FROM payment
GROUP BY revenue_year
ORDER BY revenue_year;


-- ============================================================
-- SECTION B: Monthly Revenue Trend
-- ============================================================


-- 2. Revenue by Month
-- ------------------------------------------------------------

SELECT 
    DATE_FORMAT(payment_date, '%Y-%m') AS revenue_month,
    ROUND(SUM(amount), 2) AS total_revenue
FROM payment
GROUP BY revenue_month
ORDER BY revenue_month;


-- ============================================================
-- SECTION C: Revenue by Day of Week
-- ============================================================


-- 3. Revenue by Day of Week
-- ------------------------------------------------------------

SELECT 
    DAYNAME(payment_date) AS day_of_week,
    ROUND(SUM(amount), 2) AS total_revenue
FROM payment
GROUP BY day_of_week
ORDER BY FIELD(day_of_week,
'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday');


-- ============================================================
-- SECTION D: Revenue by Hour of Day
-- ============================================================


-- 4. Revenue by Hour
-- ------------------------------------------------------------

SELECT 
    HOUR(payment_date) AS hour_of_day,
    ROUND(SUM(amount), 2) AS total_revenue
FROM payment
GROUP BY hour_of_day
ORDER BY hour_of_day;


-- ============================================================
-- SECTION E: Rental Activity by Month
-- ============================================================


-- 5. Total Rentals by Month
-- ------------------------------------------------------------

SELECT 
    DATE_FORMAT(rental_date, '%Y-%m') AS rental_month,
    COUNT(*) AS total_rentals
FROM rental
GROUP BY rental_month
ORDER BY rental_month;


-- ============================================================
-- SECTION F: Peak Business Hours (Top 5 Hours)
-- ============================================================


-- 6. Top 5 Revenue Generating Hours
-- ------------------------------------------------------------

SELECT 
    HOUR(payment_date) AS hour_of_day,
    ROUND(SUM(amount), 2) AS total_revenue
FROM payment
GROUP BY hour_of_day
ORDER BY total_revenue DESC
LIMIT 5;


-- 7. Monthly Revenue Growth Rate
-- ------------------------------------------------------------

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
    LAG(total_revenue) OVER (ORDER BY revenue_month) AS previous_month,
    ROUND(
        (total_revenue - LAG(total_revenue) OVER (ORDER BY revenue_month)) 
        / LAG(total_revenue) OVER (ORDER BY revenue_month) * 100,
        2
    ) AS growth_percentage
FROM monthly_revenue;


-- 7. Revenue by Month Name (Seasonality View)
-- ------------------------------------------------------------

SELECT 
    MONTHNAME(payment_date) AS month_name,
    ROUND(SUM(amount), 2) AS total_revenue
FROM payment
GROUP BY month_name
ORDER BY FIELD(month_name,
'January','February','March','April','May','June',
'July','August','September','October','November','December');


