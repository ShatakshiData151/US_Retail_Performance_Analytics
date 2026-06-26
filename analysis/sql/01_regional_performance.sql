/* 
=================================================================
Question 1: 
What is the total sales and profit per region,
sorted by profit descending?

Business Objective:
Identify which region generates the highest sales and profit
=================================================================
*/

SELECT 
Region,
ROUND(SUM(sales),2) AS Total_Sales,
ROUND(SUM(profit),2) AS Total_Profit
FROM superstore.superstore_data
GROUP BY Region
ORDER BY Total_Profit DESC;

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




