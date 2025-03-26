-- Case Study: Amazon Data Analytics

-- Background:
-- Amazon, a global e-commerce giant, collects a vast amount of data from its operations, 
-- including customer orders, employee information, product returns, and customer details. 
-- Effective data analytics on this dataset can provide valuable insights to improve customer satisfaction, 
-- optimize operations, and increase sales.

-- Problem Statement:
-- Amazon aims to leverage its extensive dataset to achieve the following business objectives through data analytics:
-- Order Performance Analysis:
-- 1. Analyze the performance of different product categories based on orders:
--    - Determine which categories generate the highest sales.
--    - Identify which categories have the most orders and highest profitability.
-- 2. Identify trends and patterns in order volumes over time:
--    - Analyze monthly order volumes to detect seasonal trends.
-- Customer Behavior Analysis:
-- 1. Segment customers based on their purchase behavior and demographics:
--    - Group customers by age, gender, income, and marital status.
--    - Identify high-value customer segments and their purchasing habits.
-- 2. Identify patterns in customer preferences and purchasing habits:
--    - Determine the most popular products and categories among different customer segments.
--    - Analyze the frequency and timing of purchases.


CREATE DATABASE amazon;
USE amazon;
SELECT * from orders_1;
select * from customers_1;
select * from people;
select * from returns;

-- Task 1: Analyzing Customer Insights
-- 1. Retrieve the list of all customers and their total sales.
select c.customer_Name,sum(o.sales) from customers_1 as c
left join orders_1 as o
on c.Customer_ID=o.Customer_ID group by c.customer_Name order by c.customer_Name desc limit 10;

-- 2. Retrieve the number of unique customers in each market
select  o.Market, count(distinct(c.customer_Name))from orders_1 as o
left join customers_1 as c
on o.Customer_Id=c.Customer_ID group by o.Market;

-- 3. For each segment of customers, find the total number of orders placed.
select o.Segment ,count(o.Order_ID)from orders_1 as o
left join customers_1 as c
on o.Customer_ID=c.Customer_ID group by o.segment;

-- 4. Find the customers who have placed orders totaling more than $5,000.
select c.Customer_Name,sum(o.sales) from customers_1 as c
left join orders_1 as o
on c.Customer_ID=o.Customer_ID group by c.Customer_Name having sum(o.sales)>5000 order by sum(o.sales);

-- 5. Retrieve a list of customers and their orders, showing only those who have placed more than 5 orders.
select c.customer_name , count(o.order_id) from customers_1 as c left join orders_1 as o 
on c.customer_id = o.customer_id group by c.customer_name
having count(order_id)>5 order by count(o.order_id);

-- 6. Identify customers with no recorded sales.
select c.customer_name , o.sales from customers_1 as c left join orders_1 as o
on c.customer_id = o.customer_id where  o.sales is null ;

-- Task 2: Shipping and Profitability Analysis
-- 7. Find the average shipping cost per order.
select avg(shipping_cost) from orders_1 ;

-- 8. List the total profit for each region.
select region,sum(sales) from orders_1 group by region;

-- 9. Retrieve orders with a high shipping cost (above $50) and low profit (below $100).
select order_id,shipping_cost,profit from orders_1 where profit between 50 and 100;

-- 10. Identify the top 5 most profitable products.
select product_name,max(profit) from orders_1 group by product_name order by max(profit) desc limit 5;

-- Task 3: Product and Category Insights
-- 11. Find the total sales per product category.
select category ,sum(sales) from orders_1 group by category;

-- 12. List the top 3 products in terms of total sales in the "Furniture" category.
select product_name,category,sum(sales) from orders_1 where category = 'Furniture' 
group by product_name having  sum(sales) order by category desc limit 3;

-- 13. Identify products that have been sold more than 100 times but have a total profit of less than $500.;
 select Product_Name, count( Product_Name),sum(Profit) from orders_1 
 group by Product_Name having sum(Profit)<500 and count( Product_Name)<100;
 
 -- 14. Retrieve the list of products that have never been sold.
select Product_Name,sum(Sales) from orders_1 
group by Product_Name  having sum(Sales)<100;

-- 15. Retrieve the number of returned orders for each region.
select o.region,count(r.returned) from orders_1 as o
left join returns as r
on o.order_id=r.order_id group by o.region;

-- 16. Identify the markets with the highest return rate.
select r.market,count(r.order_id)/count(o.order_id)*100 from orders_1 as o
left join returns as r
on o.order_id=r.order_id group by r.market order by count(r.order_id) desc limit 1 ;





 
 











