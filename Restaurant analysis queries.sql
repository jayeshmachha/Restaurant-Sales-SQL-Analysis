Create database Restaurant_sales_orders;
use Restaurant_sales_orders;

-- Import the data

-- Understand Dataset Structure
select * 
from restaurant_orders limit 10;

describe restaurant_orders;

select * from restaurant_orders
where Order_id is null
or Food_Item is null
or Quantity is null;

-- Create Business Metrics

-- Total Revenue
select round(sum(Quantity * Price), 2) as total_revenue
from restaurant_orders;

-- Total Orders
select count(Order_ID) as total_orders
from restaurant_orders;

-- Total Items Sold
select sum(Quantity) as total_item_sold
from restaurant_orders;


-- Product Analysis

-- Most Sold Food Items
select Food_Item,
sum(Quantity) as total_sold
from restaurant_orders
group by Food_Item
order by total_sold desc;

-- Top Revenue Generating Items
select Food_Item,
round(sum(Quantity * Price), 2) as Revenue
from restaurant_orders
group by Food_Item
order by Revenue desc;


-- Category Performance

-- Revenue by Category
select Category, 
round(sum(Quantity * Price), 2) as Revenue
from restaurant_orders
group by Category
order by Revenue desc;

-- Quantity Sold by Category
select Category, 
sum(Quantity) as quantity_sold
from restaurant_orders
group by Category
order by quantity_sold desc;


-- Customer Analysis

-- Top Spending Customers
select Customer_Name, 
sum(Quantity * Price) as total_spending
from restaurant_orders
group by Customer_Name
order by total_spending
limit 10;

-- Number of Orders per Customer
select Customer_Name, 
count(distinct Order_ID) as total_orders
from restaurant_orders
group by Customer_Name
order by total_orders desc;


-- Payment Analysis

-- Payment Method Usage
select Payment_Method,
count(*) as transactions
from restaurant_orders
group by Payment_Method
order by transactions desc;

-- Revenue by Payment Method
select Payment_Method,
round(sum(quantity * Price), 2) as Revenue_by_method
from restaurant_orders
group by Payment_Method
order by Revenue_by_method desc;


-- Time-Based Analysis

-- Sales by Day
select Order_Weekday,
round(sum(Quantity * Price), 2) as revenue
from restaurant_orders
group by Order_Weekday
order by Order_Weekday asc;

-- Monthly Revenue
select Order_Month,
round(sum(Quantity * Price), 2) as revenue
from restaurant_orders
group by Order_Month
order by Order_Month asc;

-- Peak Order Hours
select Order_Time,
count(Order_Id) as orders
from restaurant_orders
group by Order_Time
order by orders desc;

-- Average Order Value
select round(avg(order_total), 2)
from(
select Order_ID,
sum(Quantity * Price) as order_total
from restaurant_orders
group by Order_ID)t;

-- Top 5 Revenue Items
select Food_Item,
round(sum(Quantity * Price), 2) as revenue,
rank() over (order by sum(Quantity * Price) desc) as ranking
from restaurant_orders
group by Food_Item
limit 5;





