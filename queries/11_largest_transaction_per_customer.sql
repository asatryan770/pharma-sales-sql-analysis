-- Task 11: Largest transaction per customer
-- Question: Find each customer's largest transaction (by total amount) and its date.
-- Dialect: Oracle SQL

SELECT CUSTOMER_ID,
       NAME AS "Customer",
       TOTAL_AMOUNT AS "Largest Transaction",
       TRANSACTION_DATE
FROM (
    SELECT C.CUSTOMER_ID,
           C.NAME,
           NVL(TD.TOTAL_AMOUNT, 0) AS TOTAL_AMOUNT,
           T.TRANSACTION_DATE,
           RANK() OVER (PARTITION BY C.CUSTOMER_ID
                        ORDER BY NVL(TD.TOTAL_AMOUNT, 0) DESC) AS RNK
    FROM P_CUSTOMERS C
    LEFT JOIN P_TRANSACTIONS T
           ON T.CUSTOMER_ID = C.CUSTOMER_ID
    LEFT JOIN P_TRANSACTIONDETAILS TD
           ON TD.TRANSACTION_ID = T.TRANSACTION_ID
)
WHERE RNK = 1
ORDER BY TOTAL_AMOUNT DESC;

-- Findings:
--   - The largest single transaction was made by Exporting Company (300,000 AMD), far above any other customer. Armenia Pharm LLC is second (150,000 AMD), followed by Health for All LLC (120,000 AMD).
--   - All other customers' largest transactions are below 100,000 AMD. New Pharmacy made two transactions: one with a negative amount and one with no amount recorded.
--   - All of the largest transactions took place in January.
