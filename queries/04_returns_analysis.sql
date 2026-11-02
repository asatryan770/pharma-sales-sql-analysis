-- Task 4: Returns analysis
-- Question: Analyse the reasons for returns and their impact on revenue and profit, and identify which products and customers have the most returns.
-- Dialect: Oracle SQL

WITH data AS (
    SELECT P.PRODUCT_ID,
           P.NAME AS "Product",
           T.TRANSACTION_TYPE,
           TD.QUANTITY,
           TD.TOTAL_AMOUNT,
           TD.PROFIT,
           -- Share of total profit / revenue. The denominator counts sales
           -- only, so each return is measured against gross sales.
           ROUND(SUM(TD.PROFIT)
                   OVER (PARTITION BY P.PRODUCT_ID, T.TRANSACTION_TYPE)
                 / SUM(CASE WHEN LOWER(T.TRANSACTION_TYPE) = 'իրացում'
                            THEN TD.PROFIT END) OVER ()
                 * 100, 2) AS "% of Total Profit",
           ROUND(SUM(TD.TOTAL_AMOUNT)
                   OVER (PARTITION BY P.PRODUCT_ID, T.TRANSACTION_TYPE)
                 / SUM(CASE WHEN LOWER(T.TRANSACTION_TYPE) = 'իրացում'
                            THEN TD.TOTAL_AMOUNT END) OVER ()
                 * 100, 2) AS "% of Total Revenue",
           C.NAME AS "Customer",
           C.PARTNER_GROUP,
           T.COMMENTS
    FROM P_TRANSACTIONS T
    LEFT JOIN P_TRANSACTIONDETAILS TD ON TD.TRANSACTION_ID = T.TRANSACTION_ID
    LEFT JOIN P_PRODUCTS P            ON P.PRODUCT_ID = TD.PRODUCT_ID
    LEFT JOIN P_CUSTOMERS C           ON C.CUSTOMER_ID = T.CUSTOMER_ID
)
SELECT *
FROM data
WHERE LOWER(TRANSACTION_TYPE) = 'վերադարձ'   -- 'Return'
ORDER BY QUANTITY ASC;

-- Findings:
--   - 5 returns were recorded. Only one, from a medical institution, was caused by an expired product. The rest came from retail and wholesale customers: one was due to a wrong order, and the others were most likely because the goods did not sell.
--   - The largest impact on total profit and revenue came from retail customer New Pharmacy, which returned all 500 units of sterile bandages. This cut total profit by 10.02% and revenue by 7.97% (returns are excluded from the total revenue and profit used as the base for these percentages).
--   - The second largest return, much smaller in impact, came from Medical Center N1 because of an expired product (Vitamin C). It reduced total profit by 2% and revenue by 1.86%.
--   - The remaining returns had a relatively small impact of up to 1.2%.
