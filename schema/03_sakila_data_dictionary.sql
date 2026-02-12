-- ============================================================
-- FILE: 03_sakila_data_dictionary.sql
-- PROJECT: SQL Business Data Analysis (Sakila)
-- PURPOSE: Business-Level Data Dictionary for Core Tables
-- ============================================================



-- ============================================================
-- 1. CUSTOMER
-- ============================================================

-- Description:
-- Stores customer personal and account information.

-- Key Columns:
-- customer_id      : Primary key (unique customer identifier)
-- first_name       : Customer first name
-- last_name        : Customer last name
-- email            : Customer email address
-- store_id         : Store where customer is registered
-- active           : Indicates if customer account is active



-- ============================================================
-- 2. FILM
-- ============================================================

-- Description:
-- Contains film catalog information.

-- Key Columns:
-- film_id          : Primary key
-- title            : Film title
-- rental_duration  : Allowed rental period (in days)
-- rental_rate      : Rental price
-- replacement_cost : Cost to replace film



-- ============================================================
-- 3. RENTAL
-- ============================================================

-- Description:
-- Records each rental transaction.

-- Key Columns:
-- rental_id        : Primary key
-- rental_date      : Date film was rented
-- return_date      : Date film was returned
-- inventory_id     : Specific copy rented
-- customer_id      : Customer who rented



-- ============================================================
-- 4. PAYMENT
-- ============================================================

-- Description:
-- Stores payment transactions for rentals.

-- Key Columns:
-- payment_id       : Primary key
-- customer_id      : Paying customer
-- staff_id         : Staff who processed payment
-- rental_id        : Rental reference
-- amount           : Payment amount
-- payment_date     : Date payment was made



-- ============================================================
-- 5. STORE
-- ============================================================

-- Description:
-- Represents physical rental stores.

-- Key Columns:
-- store_id         : Primary key
-- manager_staff_id : Store manager
-- address_id       : Store location



-- ============================================================
-- 6. INVENTORY
-- ============================================================

-- Description:
-- Represents physical film copies available for rental.

-- Key Columns:
-- inventory_id     : Primary key
-- film_id          : Film reference
-- store_id         : Store where copy is located



-- ============================================================
-- 7. CATEGORY
-- ============================================================

-- Description:
-- Film genre classification.

-- Key Columns:
-- category_id      : Primary key
-- name             : Category name

