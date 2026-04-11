🍽️ Restaurant Sales Analysis — SQL
Show Image
Show Image
Show Image
Show Image

Transforming raw restaurant transaction data into actionable business intelligence using SQL — covering revenue trends, customer behavior, product performance, and operational insights.


📌 Table of Contents

Project Overview
Business Problem
Dataset Information
Tech Stack
Project Structure
Key SQL Analysis
Key Business Insights
Business Recommendations
How to Run
Project Outcome
Connect


📖 Project Overview
This project performs an end-to-end SQL-based analysis of a restaurant's sales data. Starting from raw transactional records, the analysis identifies revenue drivers, uncovers customer purchasing patterns, highlights peak business hours, and surfaces strategic opportunities for growth.
The goal is to demonstrate how structured SQL queries — spanning data cleaning, aggregations, window functions, and time-series analysis — can solve real business problems and enable data-driven decision-making.

🎯 Business Problem
The restaurant management team needed clarity on:
QuestionAnalysis TypeWhich food items generate maximum revenue?Product & Revenue AnalysisWho are the most valuable customers?Customer Behavior AnalysisWhen do peak sales periods occur?Time-Based Sales AnalysisWhich payment methods are preferred?Payment Method AnalysisWhere are the opportunities to grow revenue?Strategic Gap Analysis

📂 Dataset Information
The dataset contains transactional records from the restaurant's order management system.
ColumnDescriptionorder_idUnique identifier for each transactionorder_dateDate and time of the orderfood_itemName of the ordered itemcategoryMenu category (Main Course, Beverages, Desserts, etc.)quantityNumber of units orderedpricePrice per unit (INR)payment_methodMode of payment (Cash, UPI, Card, etc.)customer_nameName of the customer

🛠️ Tech Stack
ToolPurposeMySQLCore query engine for all analysisSQL (DDL/DML/DQL)Data cleaning, transformation, and queryingWindow FunctionsRanking, running totals, period comparisonsAggregate FunctionsRevenue summaries, customer segmentation

📁 Project Structure
restaurant-sales-analysis/
│
├── dataset/
│   └── restaurant_sales.csv          # Raw dataset
│
├── sql/
│   ├── 01_data_cleaning.sql          # Null handling, deduplication, formatting
│   ├── 02_revenue_analysis.sql       # Total & category-level revenue breakdown
│   ├── 03_product_performance.sql    # Top/bottom selling items, contribution %
│   ├── 04_customer_analysis.sql      # Loyal customers, AOV, frequency analysis
│   ├── 05_payment_analysis.sql       # Payment method distribution
│   ├── 06_time_based_analysis.sql    # Daily, weekly, monthly sales trends
│   └── 07_avg_order_value.sql        # AOV calculation across segments
│
├── insights/
│   └── business_insights.md         # Key findings and strategic recommendations
│
└── README.md

📈 Key SQL Analysis
✅ 1. Data Cleaning

Removed duplicate order_id entries
Handled NULL values in critical columns (price, quantity)
Standardized date formats and category labels

✅ 2. Revenue Analysis
sqlSELECT 
    category,
    SUM(quantity * price) AS total_revenue,
    ROUND(SUM(quantity * price) * 100.0 / SUM(SUM(quantity * price)) OVER (), 2) AS revenue_share_pct
FROM restaurant_sales
GROUP BY category
ORDER BY total_revenue DESC;
✅ 3. Product Performance Analysis
sqlSELECT 
    food_item,
    SUM(quantity) AS total_units_sold,
    SUM(quantity * price) AS total_revenue,
    RANK() OVER (ORDER BY SUM(quantity * price) DESC) AS revenue_rank
FROM restaurant_sales
GROUP BY food_item;
✅ 4. Customer Analysis
sqlSELECT 
    customer_name,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity * price) AS lifetime_value,
    ROUND(SUM(quantity * price) / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM restaurant_sales
GROUP BY customer_name
ORDER BY lifetime_value DESC
LIMIT 10;
✅ 5. Payment Method Analysis
sqlSELECT 
    payment_method,
    COUNT(*) AS transaction_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM restaurant_sales), 2) AS usage_pct
FROM restaurant_sales
GROUP BY payment_method
ORDER BY transaction_count DESC;
✅ 6. Time-Based Sales Analysis
sqlSELECT 
    DAYNAME(order_date) AS day_of_week,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity * price) AS daily_revenue
FROM restaurant_sales
GROUP BY DAYNAME(order_date), DAYOFWEEK(order_date)
ORDER BY DAYOFWEEK(order_date);
✅ 7. Average Order Value
sqlSELECT 
    ROUND(SUM(quantity * price) / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM restaurant_sales;

📊 Key Business Insights

Revenue Concentration — A small number of food items contribute disproportionately to total revenue (Pareto Effect in action).
Category Leader — Main course items dominate sales across both volume and revenue metrics.
Digital Payments — UPI and card-based transactions are preferred over cash by a significant margin.
Peak Days — Sales spike on specific weekdays, indicating clear demand patterns.
Customer Loyalty — A small group of repeat customers contributes a large share of overall revenue (classic 80/20 distribution).
Underperforming Items — Several menu items consistently register low order volume, pointing to rationalization opportunities.


💡 Business Recommendations
#RecommendationExpected Impact1Increase inventory and visibility for top-selling itemsReduce stockouts, boost revenue2Bundle slow-moving items with bestsellers as combo mealsIncrease average order value3Launch a loyalty/rewards program targeting repeat customersImprove customer retention4Optimize staffing and kitchen resources during peak daysReduce wait times, improve margins5Streamline or replace consistently underperforming menu itemsReduce operational complexity6Incentivize digital payments (cashback, discounts)Lower cash-handling costs

▶️ How to Run

Clone the repository

bash   git clone https://github.com/jayeshmachha/restaurant-sales-analysis.git
   cd restaurant-sales-analysis

Set up the database

sql   CREATE DATABASE restaurant_db;
   USE restaurant_db;

Import the dataset

bash   mysql -u root -p restaurant_db < dataset/restaurant_sales.csv

Run the SQL scripts in order

   01_data_cleaning.sql → 02_revenue_analysis.sql → ... → 07_avg_order_value.sql

🚀 Project Outcome
This project demonstrates how SQL alone — without any external BI tools — can extract strategic value from raw transactional data. By applying data cleaning, aggregations, window functions, and business logic directly in MySQL, the analysis produces insights that are immediately actionable for restaurant operations, menu strategy, and customer engagement.

🔗 Connect
Jayesh Machha
B.Tech AI & Data Science | Dr. Babasaheb Ambedkar Technological University
Show Image
Show Image
