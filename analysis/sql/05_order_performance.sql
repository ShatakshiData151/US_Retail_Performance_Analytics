/* 
=================================================================
Question 5: 
What is the average order value(total sales per order ID
=================================================================
*/
SELECT 
ROUND(AVG(Order_Value), 2) AS Average_Order_Value
FROM
    (SELECT 
    Order_ID, SUM(Sales) AS Order_Value
    FROM
    superstore.superstore_data
    GROUP BY Order_ID) AS Orders

/* 
=================================================================
Question 9: 
Show month-over-month revenue growth for each year. 
include the growth % vs the prior month
=================================================================
*/
WITH monthly_revenue AS(
SELECT
YEAR(Order_Date) AS Order_Year,
MONTH(Order_Date) AS Order_Month,
DATE_FORMAT(Order_Date, '%Y-%m-01') AS Month_Start,
ROUND(SUM(Sales), 2) AS Revenue
FROM superstore.superstore_data
GROUP BY Order_Year, Order_Month, Month_Start
),
monthly_comparison AS(
SELECT
Order_Year,
Order_Month,
Month_Start,
Revenue,
LAG(Revenue) OVER(
		PARTITION BY Order_Year
        ORDER BY Order_Month
		)AS Previous_Month_Revenue 
FROM monthly_revenue
)
SELECT
Order_Year,
Order_Month,
Month_Start,
Revenue,
Previous_Month_Revenue,
ROUND((Revenue - Previous_Month_Revenue)/Previous_Month_Revenue*100, 2)
AS Growth_Percentage
FROM monthly_comparison
ORDER BY Order_Year, Order_Month
