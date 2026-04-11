# 🍽️ Restaurant Sales Analysis — SQL

![SQL](https://img.shields.io/badge/SQL-MySQL-4479A1?style=flat-square&logo=mysql&logoColor=white)
![Status](https://img.shields.io/badge/Status-Completed-2ea44f?style=flat-square)
![Domain](https://img.shields.io/badge/Domain-Business%20Analytics-orange?style=flat-square)
![License](https://img.shields.io/badge/License-MIT-blue?style=flat-square)

> Transforming raw restaurant transaction data into actionable business intelligence using SQL — covering revenue trends, customer behavior, product performance, and operational insights.

---

## 📌 Table of Contents

- [Project Overview](#-project-overview)
- [Business Problem](#-business-problem)
- [Dataset Information](#-dataset-information)
- [Tech Stack](#-tech-stack)
- [Project Structure](#-project-structure)
- [Key SQL Analysis](#-key-sql-analysis)
- [Key Business Insights](#-key-business-insights)
- [Business Recommendations](#-business-recommendations)
- [How to Run](#-how-to-run)
- [Project Outcome](#-project-outcome)
- [Connect](#-connect)

---

## 📖 Project Overview

This project performs an end-to-end SQL-based analysis of a restaurant's sales data. Starting from raw transactional records, the analysis identifies revenue drivers, uncovers customer purchasing patterns, highlights peak business hours, and surfaces strategic opportunities for growth.

The goal is to demonstrate how structured SQL queries — spanning data cleaning, aggregations, window functions, and time-series analysis — can solve real business problems and enable data-driven decision-making.

---

## 🎯 Business Problem

The restaurant management team needed clarity on:

| Question | Analysis Type |
|---|---|
| Which food items generate maximum revenue? | Product & Revenue Analysis |
| Who are the most valuable customers? | Customer Behavior Analysis |
| When do peak sales periods occur? | Time-Based Sales Analysis |
| Which payment methods are preferred? | Payment Method Analysis |
| Where are the opportunities to grow revenue? | Strategic Gap Analysis |

---

## 📂 Dataset Information

The dataset contains transactional records from the restaurant's order management system.

| Column | Description |
|---|---|
| `order_id` | Unique identifier for each transaction |
| `order_date` | Date and time of the order |
| `food_item` | Name of the ordered item |
| `category` | Menu category (Main Course, Beverages, Desserts, etc.) |
| `quantity` | Number of units ordered |
| `price` | Price per unit (INR) |
| `payment_method` | Mode of payment (Cash, UPI, Card, etc.) |
| `customer_name` | Name of the customer |

---

## 🛠️ Tech Stack

| Tool | Purpose |
|---|---|
| **MySQL** | Core query engine for all analysis |
| **SQL (DDL/DML/DQL)** | Data cleaning, transformation, and querying |
| **Window Functions** | Ranking, running totals, period comparisons |
| **Aggregate Functions** | Revenue summaries, customer segmentation |

---

## 📈 Key SQL Analysis

### ✅ 1. Data Cleaning
- Removed duplicate `order_id` entries
- Handled `NULL` values in critical columns (`price`, `quantity`)
- Standardized date formats and category labels

### ✅ 2. Revenue Analysis
```sql
SELECT 
    category,
    SUM(quantity * price) AS total_revenue,
    ROUND(SUM(quantity * price) * 100.0 / SUM(SUM(quantity * price)) OVER (), 2) AS revenue_share_pct
FROM restaurant_sales
GROUP BY category
ORDER BY total_revenue DESC;
```

### ✅ 3. Product Performance Analysis
```sql
SELECT 
    food_item,
    SUM(quantity) AS total_units_sold,
    SUM(quantity * price) AS total_revenue,
    RANK() OVER (ORDER BY SUM(quantity * price) DESC) AS revenue_rank
FROM restaurant_sales
GROUP BY food_item;
```

### ✅ 4. Customer Analysis
```sql
SELECT 
    customer_name,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity * price) AS lifetime_value,
    ROUND(SUM(quantity * price) / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM restaurant_sales
GROUP BY customer_name
ORDER BY lifetime_value DESC
LIMIT 10;
```

### ✅ 5. Payment Method Analysis
```sql
SELECT 
    payment_method,
    COUNT(*) AS transaction_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM restaurant_sales), 2) AS usage_pct
FROM restaurant_sales
GROUP BY payment_method
ORDER BY transaction_count DESC;
```

### ✅ 6. Time-Based Sales Analysis
```sql
SELECT 
    DAYNAME(order_date) AS day_of_week,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity * price) AS daily_revenue
FROM restaurant_sales
GROUP BY DAYNAME(order_date), DAYOFWEEK(order_date)
ORDER BY DAYOFWEEK(order_date);
```

### ✅ 7. Average Order Value
```sql
SELECT 
    ROUND(SUM(quantity * price) / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM restaurant_sales;
```

---

## 📊 Key Business Insights

- **Revenue Concentration** — A small number of food items contribute disproportionately to total revenue (Pareto Effect in action).
- **Category Leader** — Main course items dominate sales across both volume and revenue metrics.
- **Digital Payments** — UPI and card-based transactions are preferred over cash by a significant margin.
- **Peak Days** — Sales spike on specific weekdays, indicating clear demand patterns.
- **Customer Loyalty** — A small group of repeat customers contributes a large share of overall revenue (classic 80/20 distribution).
- **Underperforming Items** — Several menu items consistently register low order volume, pointing to rationalization opportunities.

---

## 💡 Business Recommendations

| # | Recommendation | Expected Impact |
|---|---|---|
| 1 | Increase inventory and visibility for top-selling items | Reduce stockouts, boost revenue |
| 2 | Bundle slow-moving items with bestsellers as combo meals | Increase average order value |
| 3 | Launch a loyalty/rewards program targeting repeat customers | Improve customer retention |
| 4 | Optimize staffing and kitchen resources during peak days | Reduce wait times, improve margins |
| 5 | Streamline or replace consistently underperforming menu items | Reduce operational complexity |
| 6 | Incentivize digital payments (cashback, discounts) | Lower cash-handling costs |

---

## ▶️ How to Run

1. **Clone the repository**
```bash
   git clone https://github.com/jayeshmachha/restaurant-sales-analysis.git
   cd restaurant-sales-analysis
```

2. **Set up the database**
```sql
   CREATE DATABASE restaurant_db;
   USE restaurant_db;
```

3. **Import the dataset**
```bash
   mysql -u root -p restaurant_db < dataset/restaurant_sales.csv
```

4. **Run the SQL scripts in order**
01_data_cleaning.sql → 02_revenue_analysis.sql → ... → 07_avg_order_value.sql

---

## 🚀 Project Outcome

This project demonstrates how SQL alone — without any external BI tools — can extract strategic value from raw transactional data. By applying data cleaning, aggregations, window functions, and business logic directly in MySQL, the analysis produces insights that are immediately actionable for restaurant operations, menu strategy, and customer engagement.

---

## 🔗 Connect

**Jayesh Machha**  
B.Tech AI & Data Science | Dr. Babasaheb Ambedkar Technological University

[![GitHub](https://img.shields.io/badge/GitHub-jayeshmachha-181717?style=flat-square&logo=github)](https://github.com/jayeshmachha)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Jayesh%20Machha-0A66C2?style=flat-square&logo=linkedin)](https://linkedin.com/in/jayesh-machha-166aa42b3)

---

*If you found this project useful, consider giving it a ⭐ on GitHub!*
