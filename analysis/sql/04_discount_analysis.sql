/* 
=================================================================
Question 4: 
Find all the orders where discount where greater than 30% 
but the profit was negative, how many such orders exists? 
=================================================================
*/
SELECT 
COUNT(Product_Name) AS Total_loss_making_products
FROM superstore.superstore_data
WHERE Discount > 0.30
AND Profit < 0

/* ## To be updated
=================================================================
Question 14: 
=================================================================
*/
