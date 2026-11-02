-- Task 7: High-margin, high-value transactions
-- Question: Find transactions with a profit margin above 30% and a total amount above 50,000 AMD.
-- Dialect: Oracle SQL

SELECT *
FROM P_TRANSACTIONDETAILS
WHERE TOTAL_AMOUNT  > 50000
  AND PROFIT_MARGIN > 30
ORDER BY TOTAL_AMOUNT DESC;

-- Findings:
--   - Only 3 transactions are above 50,000 AMD with a margin above 30%, and all three have the same margin of 33.33%.
--   - Transaction 11 has the highest amount (150,000 AMD) and the highest profit (50,000 AMD). Transaction 4 is second (75,000 AMD, 25,000 AMD profit), and transaction 3 is third (54,000 AMD, 18,000 AMD profit).
