-- ============================================================
-- FILE: 04_sakila_indexes_constraints.sql
-- PROJECT: SQL Business Data Analysis (Sakila)
-- PURPOSE: Primary Keys, Foreign Keys, and Index Overview
-- ============================================================


-- ============================================================
-- 1. Primary Key Constraints
-- ------------------------------------------------------------

SELECT
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'sakila'
AND CONSTRAINT_NAME = 'PRIMARY'
ORDER BY TABLE_NAME;



-- ============================================================
-- 2. Foreign Key Relationships
-- ------------------------------------------------------------

SELECT
    TABLE_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME,
    CONSTRAINT_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'sakila'
AND REFERENCED_TABLE_NAME IS NOT NULL
ORDER BY TABLE_NAME;



-- ============================================================
-- 3. Index Overview
-- ------------------------------------------------------------

SELECT
    TABLE_NAME,
    INDEX_NAME,
    COLUMN_NAME,
    NON_UNIQUE
FROM information_schema.STATISTICS
WHERE TABLE_SCHEMA = 'sakila'
ORDER BY TABLE_NAME, INDEX_NAME;



-- ============================================================
-- 4. Table Engine & Row Statistics
-- ------------------------------------------------------------

SELECT
    TABLE_NAME,
    ENGINE,
    TABLE_ROWS,
    DATA_LENGTH,
    INDEX_LENGTH
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'sakila'
ORDER BY TABLE_NAME;

