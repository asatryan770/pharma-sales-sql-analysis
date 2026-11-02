-- Task 3: Sales and profit by customer group
-- Question: Calculate total sales and profit for each customer group, sorted by total sales in descending order.
-- Dialect: Oracle SQL

SELECT C.PARTNER_GROUP       AS "Customer Group",
       SUM(TD.TOTAL_AMOUNT)  AS "Total Sales",
       SUM(TD.PROFIT)        AS "Total Profit"
FROM P_CUSTOMERS C
LEFT JOIN P_TRANSACTIONS T
       ON T.CUSTOMER_ID = C.CUSTOMER_ID
LEFT JOIN P_TRANSACTIONDETAILS TD
       ON TD.TRANSACTION_ID = T.TRANSACTION_ID
GROUP BY C.PARTNER_GROUP
ORDER BY 2 DESC;

-- Findings:
--   - Wholesale customers generate the highest turnover and profit, followed by Export and Medical Institutions. Retail customers have the lowest figures.
