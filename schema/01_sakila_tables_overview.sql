-- ============================================================
-- FILE: 01_sakila_tables_overview.sql
-- PROJECT: SQL Business Data Analysis (Sakila)
-- PURPOSE: Structural overview of core Sakila tables
-- ============================================================

USE sakila;

-- ------------------------------------------------------------
-- 1. List All Tables
-- ------------------------------------------------------------

SHOW TABLES;


-- ------------------------------------------------------------
-- 2. Describe Core Transaction Tables
-- ------------------------------------------------------------

DESCRIBE customer;
DESCRIBE rental;
DESCRIBE payment;


-- ------------------------------------------------------------
-- 3. Describe Film & Inventory Structure
-- ------------------------------------------------------------

DESCRIBE film;
DESCRIBE inventory;
DESCRIBE film_category;
DESCRIBE category;


-- ------------------------------------------------------------
-- 4. Describe Store & Staff Structure
-- ------------------------------------------------------------

DESCRIBE store;
DESCRIBE staff;

