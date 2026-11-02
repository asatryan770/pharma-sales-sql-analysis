-- Task 12: Low-demand products
-- Question: Analyse low-demand products by calculating each product's total quantity sold, total profit and share of total profit (%). Sort from least to most sold; for equal quantities, sort by profit share in ascending order.
-- Dialect: Oracle SQL

SELECT P.PRODUCT_ID,
       P.NAME            AS "Product",
       P.PRODUCT_GROUP   AS "Product Group",
       SUM(TD.QUANTITY)  AS TOTAL_QUANTITY,
       SUM(TD.PROFIT)    AS TOTAL_PROFIT,
       ROUND(SUM(TD.PROFIT)
             / NULLIF(SUM(SUM(TD.PROFIT)) OVER (), 0) * 100, 2)
                         AS PROFIT_SHARE_PCT
FROM P_PRODUCTS P
LEFT JOIN P_TRANSACTIONDETAILS TD
       ON TD.PRODUCT_ID = P.PRODUCT_ID
GROUP BY P.PRODUCT_ID, P.NAME, P.PRODUCT_GROUP
ORDER BY TOTAL_QUANTITY ASC, PROFIT_SHARE_PCT ASC;

-- Findings:
--   - Sterile Bandage has zero total quantity and profit, because the return fully cancelled the original sale.
--   - The next lowest by quantity are Amoxil Antibiotic (25 units), Paracetamol 200mg (40 units) and Insulin 100ml (50 units). Insulin 100ml stands out, however: it brings in 23.23% of total profit despite its relatively low volume.
