-- Task 10: Monthly sales trend
-- Question: Show total sales and total profit for each month (year + month), ordered by date.
-- Dialect: Oracle SQL

SELECT TO_CHAR(TRUNC(T.TRANSACTION_DATE, 'MM'), 'YYYY-MM') AS "Year-Month",
       SUM(TD.TOTAL_AMOUNT) AS "Total Sales",
       SUM(TD.PROFIT)       AS "Total Profit"
FROM P_TRANSACTIONS T
LEFT JOIN P_TRANSACTIONDETAILS TD
       ON TD.TRANSACTION_ID = T.TRANSACTION_ID
GROUP BY TRUNC(T.TRANSACTION_DATE, 'MM')
ORDER BY TRUNC(T.TRANSACTION_DATE, 'MM');

-- Findings:
--   - January 2024 has the highest sales and profit (720,000 AMD and 180,000 AMD).
--   - February 2024, 2025 and 2026 all show negative sales and profit. In every year, January sales and profit are far higher than February's.
