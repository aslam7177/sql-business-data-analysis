-- ============================================================
-- FILE: 01_database_exploration.sql
-- PROJECT: SQL Business Data Analysis (Sakila)
-- PURPOSE: Setup environment and explore core database metrics
-- ============================================================


-- ============================================================
-- 0. Environment Setup
-- ============================================================

SHOW DATABASES;

USE sakila;

SELECT DATABASE() AS current_database;


-- ============================================================
-- 1. List All Tables in the Database
-- ============================================================

SHOW TABLES;


-- ============================================================
-- 2. Total Number of Customers
-- ============================================================

SELECT COUNT(*) AS total_customers
FROM customer;


-- ============================================================
-- 3. Total Number of Films
-- ============================================================

SELECT COUNT(*) AS total_films
FROM film;


-- ============================================================
-- 4. Total Number of Rentals
-- ============================================================

SELECT COUNT(*) AS total_rentals
FROM rental;


-- ============================================================
-- 5. Total Revenue Generated
-- ============================================================

SELECT SUM(amount) AS total_revenue
FROM payment;


-- ============================================================
-- 6. Business Activity Date Range
-- ============================================================

SELECT 
    MIN(payment_date) AS first_transaction_date,
    MAX(payment_date) AS last_transaction_date
FROM payment;


-- ============================================================
-- 7. Total Number of Stores
-- ============================================================

SELECT COUNT(*) AS total_stores
FROM store;


-- ============================================================
-- 8. Total Number of Staff Members
-- ============================================================

SELECT COUNT(*) AS total_staff
FROM staff;


-- ============================================================
-- 9. Total Film Categories
-- ============================================================

SELECT COUNT(*) AS total_categories
FROM category;


-- ============================================================
-- 10. Rentals by Store
-- ============================================================

SELECT 
    s.store_id,
    COUNT(r.rental_id) AS total_rentals
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN store s ON i.store_id = s.store_id
GROUP BY s.store_id
ORDER BY total_rentals DESC;


