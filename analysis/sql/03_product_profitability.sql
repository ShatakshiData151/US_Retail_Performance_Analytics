/* 
=================================================================
Question 3: 
Which 10 products have the highest total sales?
show product name, category and total sales
=================================================================
*/
SELECT 
Product_Name,
Category,
ROUND(SUM(Sales),2) AS Total_Sales
FROM superstore.superstore_data
GROUP BY Product_Name, category
ORDER BY Total_Sales DESC
LIMIT 10;

/* 
=================================================================
Question 6: 
Calculate the profit margin(Profit/Sales) for each sub category. 
Rank them from most profitable to least. Flag any margin below 5% 
=================================================================
*/
WITH subcategory_profit AS (
SELECT
Sub_Category,
SUM(Sales) AS Total_Sales,
SUM(Profit) AS Total_Profit,
ROUND((SUM(Profit)/	SUM(Sales)) * 100, 2) AS Profit_Margin
FROM superstore.superstore_data
GROUP BY Sub_Category
)

SELECT Sub_Category,
Total_Sales,
Total_Profit,
Profit_Margin,
RANK() OVER(ORDER BY Profit_Margin DESC)
AS Profit_Rank,

CASE 
WHEN Profit_Margin < 5 THEN 'Below 5%'
ELSE 'Healthy'
END AS Margin_Flag
FROM subcategory_profit;

/* ## To be updated
=================================================================
Question 15: 
=================================================================
*/
