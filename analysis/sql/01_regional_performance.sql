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
Questionn 10:
Which states have a "Profit inversion" - meaning their 
sales rank is significantly higher than their profit Rank 
=================================================================
*/
WITH state_performance AS (
    SELECT 
        State,
        SUM(Sales) AS Total_Sales,
        SUM(Profit) AS Total_Profit
    FROM superstore.superstore_data
    GROUP BY State
)

SELECT
    State,
    Total_Sales,
    Total_Profit,
    RANK() OVER (
        ORDER BY Total_Sales DESC
    ) AS Sales_Rank,
    RANK() OVER (
        ORDER BY Total_Profit DESC
    ) AS Profit_Rank
FROM state_performance
ORDER BY State;




