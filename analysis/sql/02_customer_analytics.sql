/*
=================================================================
Questionn 2:
How many unique customers are in each segment
(Consumer, corporate, Home-office)

Business Objective:
Identify the number of unique customers 
across different market segment
=================================================================
*/

SELECT 
Segment
COUNT(DISTINCT(Customer_ID)) AS Unique_Customers
FROM superstore.superstore_data
GROUP BY Segment 
ORDER BY Unique_Customers;

/*
=================================================================
Questionn 7:
For each customer, calculate their total lifetime value(LTV),
number of orders, and average order value. then label them, 
"High Value"(LTV > $5K), "Mid Value"(LTV < $1K-5K), "Low Value"(LTV < $1k)
=================================================================
*/
WITH customer_metrics AS (
SELECT
Customer_ID, Customer_Name,
ROUND(SUM(Sales), 2) AS LTV,
COUNT(DISTINCT Order_ID) AS Total_Orders,
ROUND(SUM(Sales) / COUNT(DISTINCT Order_ID),2) AS Avg_Order_Value
FROM superstore.superstore_data
GROUP BY Customer_ID, Customer_Name
)

SELECT *,
CASE
WHEN LTV > 5000 THEN 'High Value'
WHEN LTV BETWEEN 1000 AND 5000 THEN 'Mid Value'
ELSE 'Low Value'
END AS Customer_Tier
FROM customer_metrics
ORDER BY LTV DESC 

/*
=================================================================
Questionn 8:
Using a window function, calculate each customer's 
cumulative sales over time(Ordered by order date). 
Identify when each customer crossed the $1000 lifetime spend threshold
=================================================================
*/

WITH customer_sales AS(
SELECT
Customer_ID,
Customer_Name,
Order_Date,
SUM(Sales) OVER(PARTITION BY Customer_ID ORDER BY Order_Date ) 
AS Running_Sales
FROM superstore.superstore_data
),
threshold_crossing  AS(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY Customer_ID ORDER BY Order_Date) 
AS rn
FROM customer_sales
WHERE Running_Sales >= 1000
)
SELECT
Customer_ID,
Customer_Name,
Order_Date,
Running_Sales
FROM threshold_crossing
WHERE rn = 1

/*
## To be updated 
=================================================================
Questionn 11:
=================================================================
*/

/*
=================================================================
Questionn 12:
=================================================================
*/

/*
=================================================================
Questionn 13:
=================================================================
*/
