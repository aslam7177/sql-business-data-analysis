
# SQL Business Data Analysis – Sakila Database

## Project Overview

This project presents a comprehensive business analytics study performed on the MySQL Sakila sample database. The objective was to simulate real-world data analysis tasks typically handled by data analysts and business intelligence professionals.

The analysis covers revenue performance, customer behavior, film performance, store efficiency, operational metrics, and time-based trends using structured SQL queries ranging from foundational aggregations to advanced window-function analytics.

This repository demonstrates strong command over SQL, relational modeling, and business interpretation of data.

---

## Business Objectives

The project was designed to answer key business questions:

* How is revenue generated and distributed?
* Which customers and films drive profitability?
* How do stores compare in performance?
* What operational inefficiencies exist?
* Are there revenue concentration risks?
* How does revenue evolve over time?

---

## Repository Structure


sql-business-data-analysis/
│
├── schema/
│   ├── 01_sakila_tables_overview.sql
│   ├── 02_sakila_relationships.sql
│   ├── 03_sakila_data_dictionary.sql
│   ├── 04_sakila_indexes_constraints.sql
│   ├── sakila-schema.png
│   └── sakila-structure-MySQL.png
│
├── scripts/
│   ├── 01_database_exploration.sql
│   ├── 02_revenue_analysis.sql
│   ├── 03_revenue_performance.sql
│   ├── 04_customer_analysis.sql
│   ├── 05_customer_performance.sql
│   ├── 06_film_analysis.sql
│   ├── 07_film_performance.sql
│   ├── 08_time_analysis.sql
│   ├── 09_time_performance.sql
│   ├── 10_store_analysis.sql
│   ├── 11_store_performance.sql
│   └── 12_operational_efficiency.sql
│
├── insights/
│   ├── 01_revenue_insights.md
│   ├── 02_customer_insights.md
│   ├── 03_film_insights.md
│   ├── 04_store_insights.md
│   ├── 05_time_insights.md
│   └── 06_operational_insights.md
│
└── README.md


---

## Technical Skills Demonstrated

* Advanced SQL querying
* Complex joins across multiple tables
* Aggregate functions
* Subqueries
* Common Table Expressions (CTEs)
* Window functions (RANK, cumulative sums, moving averages)
* Revenue contribution percentage calculations
* Pareto analysis
* Customer segmentation using CASE logic
* Time-series analysis using DATE_FORMAT
* Operational efficiency measurement using DATEDIFF
* Business-driven data interpretation

---

## Analysis Modules

### 1. Database Exploration

Initial schema exploration, table structure review, metadata validation, and row-level sanity checks.

### 2. Revenue Analytics

* Total revenue
* Revenue by store
* Revenue by category
* Monthly trends
* Revenue contribution percentage
* Cumulative revenue analysis
* Revenue ranking

### 3. Customer Analytics

* Customer lifetime value
* Revenue ranking
* Segmentation (High / Medium / Low)
* Recency analysis
* Frequency behavior

### 4. Film Performance

* Rental frequency
* Revenue contribution
* Film ranking
* Category dominance
* Pareto concentration behavior

### 5. Time-Based Analysis

* Monthly revenue trends
* Moving averages
* Growth analysis
* Time-based ranking

### 6. Store Performance

* Store revenue comparison
* Revenue share percentage
* Cumulative store contribution

### 7. Operational Efficiency

* Rental duration analysis
* Late return percentage
* Inventory utilization
* Payment delay measurement

---

## Key Business Findings

* Revenue follows a transaction-driven model with stable pricing behavior.
* A minority of customers contribute disproportionately to total revenue.
* Film demand shows strong category concentration.
* Revenue patterns are stable and suitable for forecasting.
* Operational inefficiencies exist in late returns and rental duration variance.
* Store-level performance differences indicate optimization opportunities.

---

## Installation & Setup

### 1. Install MySQL

Download MySQL Community Edition from:
[https://dev.mysql.com/downloads/](https://dev.mysql.com/downloads/)

### 2. Download Sakila Database

Official Sakila sample database:
[https://dev.mysql.com/doc/index-other.html](https://dev.mysql.com/doc/index-other.html)

Import using:


SOURCE path_to_sakila-schema.sql;
SOURCE path_to_sakila-data.sql;


### 3. Clone This Repository


git clone https://github.com/aslam7177/sql-business-data-analysis.git


Run scripts in MySQL in sequence.

---

## Why This Project Matters

This project is structured like a real enterprise analytics repository:

* Modular SQL scripts
* Separated advanced and foundational logic
* Business interpretation documentation
* Schema documentation
* Professional folder structure
* No duplicated queries
* Analytical narrative

It demonstrates the ability to move beyond writing queries into delivering actionable business intelligence.

---

## Author

Aslam
SQL | Data Analytics | Business Intelligence

---

## License

MIT License

---
