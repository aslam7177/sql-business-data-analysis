-- ============================================================
-- FILE: 02_sakila_relationships.sql
-- PROJECT: SQL Business Data Analysis (Sakila)
-- PURPOSE: Document Core Table Relationships & Business Flow
-- ============================================================



-- ============================================================
-- SECTION A: Customer Transaction Flow
-- ============================================================

-- Customer → Rental → Payment

-- A customer makes a rental
-- rental.customer_id → customer.customer_id

-- Each rental generates a payment
-- payment.rental_id → rental.rental_id

-- Staff processes the payment
-- payment.staff_id → staff.staff_id



-- ============================================================
-- SECTION B: Film Inventory Flow
-- ============================================================

-- Film → Inventory → Rental

-- A film exists in the catalog
-- film.film_id

-- Physical copies are stored in inventory
-- inventory.film_id → film.film_id

-- Each rental is tied to a specific inventory item
-- rental.inventory_id → inventory.inventory_id



-- ============================================================
-- SECTION C: Store Structure
-- ============================================================

-- Store → Staff → Payment

-- Each store has staff members
-- staff.store_id → store.store_id

-- Payments are processed by staff at stores
-- payment.staff_id → staff.staff_id



-- ============================================================
-- SECTION D: Film Classification
-- ============================================================

-- Film → Film_Category → Category

-- film_category.film_id → film.film_id
-- film_category.category_id → category.category_id

