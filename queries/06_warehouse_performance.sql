-- Task 6: Warehouse performance
-- Question: Analyse warehouse efficiency by calculating, for each warehouse: total sales, average profitability, number of sales and average transaction amount. Show all metrics in one row per warehouse.
-- Dialect: Oracle SQL

SELECT W.WAREHOUSE_ID,
       W.NAME AS "Warehouse",
       NVL(SUM(TD.TOTAL_AMOUNT), 0)
           AS "Total Sales (net of returns)",
       NVL(ROUND(AVG(TD.PROFIT_MARGIN), 2), 0)
           AS "Avg Profit Margin %",
       NVL(SUM(CASE WHEN LOWER(T.TRANSACTION_TYPE) = 'իրացում' THEN 1 END), 0)
           AS "Number of Sales",
       NVL(ROUND(AVG(TD.TOTAL_AMOUNT), 2), 0)
           AS "Avg Transaction Amount"
FROM P_WAREHOUSES W
LEFT JOIN P_TRANSACTIONS T
       ON T.WAREHOUSE_ID = W.WAREHOUSE_ID
LEFT JOIN P_TRANSACTIONDETAILS TD
       ON TD.TRANSACTION_ID = T.TRANSACTION_ID
GROUP BY W.WAREHOUSE_ID, W.NAME
ORDER BY 3 DESC;

-- Findings:
--   - The Export Warehouse leads in sales at 300,000 AMD from a single sale, with an average margin of 20%.
--   - The Central Warehouse is second at 167,000 AMD but has the highest average margin (30.06%) and the most sales (4 transactions), which points to more active operations.
--   - Raw Materials Warehouse N2 recorded 136,600 AMD in sales, but its average margin is negative (-14.58%), which shows that returns dominated its transactions. The Cold Storage Warehouse is similar, with an average margin of -4.17%.
--   - Some warehouses (Production Workshop, Wholesale Warehouse, Branch N2) show zero sales. Their goods may have been transferred to other warehouses to be sold there.
