-- Task 9: Retail vs wholesale customers
-- Question: Calculate total sales and profit for customers in the Retail and Wholesale groups, and show their average sales margin.
-- Dialect: Oracle SQL

SELECT C.CUSTOMER_ID,
       C.NAME                 AS "Customer",
       C.PARTNER_GROUP        AS "Customer Group",
       SUM(TD.TOTAL_AMOUNT)   AS "Customer Sales",
       SUM(SUM(TD.TOTAL_AMOUNT)) OVER (PARTITION BY C.PARTNER_GROUP)
                              AS "Group Total Sales",
       SUM(TD.PROFIT)         AS "Customer Profit",
       SUM(SUM(TD.PROFIT)) OVER (PARTITION BY C.PARTNER_GROUP)
                              AS "Group Total Profit",
       ROUND(AVG(TD.PROFIT_MARGIN), 2)
                              AS "Avg Profit Margin %"
FROM P_CUSTOMERS C
LEFT JOIN P_TRANSACTIONS T
       ON T.CUSTOMER_ID = C.CUSTOMER_ID
LEFT JOIN P_TRANSACTIONDETAILS TD
       ON TD.TRANSACTION_ID = T.TRANSACTION_ID
-- 'Retail', 'Wholesale'
WHERE LOWER(C.PARTNER_GROUP) IN ('մանրածախ', 'մեծածախ')
GROUP BY C.CUSTOMER_ID, C.NAME, C.PARTNER_GROUP
ORDER BY 3, 4 DESC;

-- Findings:
--   - Armen Pharm LLC has the highest sales and profit (150,000 AMD and 50,000 AMD). Health Doctor LLC is second with 120,000 AMD in sales.
--   - New Pharmacy shows negative sales and profit, most likely because of a return or a cancelled sale.
--   - Overall, wholesale customers generate higher sales volumes, while margins vary from customer to customer.
