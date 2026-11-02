-- Task 5: Top 3 most profitable products
-- Question: Find the 3 most profitable products, taking into account quantity sold and profit. Show product name, type, total quantity sold, total profit and average profitability.
-- Dialect: Oracle SQL

SELECT P.PRODUCT_ID,
       P.NAME            AS "Product",
       P.PRODUCT_TYPE    AS "Product Type",
       SUM(TD.QUANTITY)  AS "Total Quantity",
       SUM(TD.PROFIT)    AS "Total Profit",
       ROUND(SUM(TD.PROFIT) / NULLIF(SUM(TD.QUANTITY), 0), 2)
                         AS "Avg Profit per Unit",
       ROUND(AVG(TD.PROFIT_MARGIN), 2)
                         AS "Avg Profit Margin %"
FROM P_PRODUCTS P
LEFT JOIN P_TRANSACTIONDETAILS TD
       ON TD.PRODUCT_ID = P.PRODUCT_ID
GROUP BY P.PRODUCT_ID, P.NAME, P.PRODUCT_TYPE
ORDER BY 5 DESC, 4 DESC
FETCH FIRST 3 ROWS ONLY;

-- Findings:
--   - Heart Medication is the most profitable product, driven by the highest sales volume and total profit.
--   - Insulin 100ml sells far fewer units but delivers the highest profit per unit and the highest profit margin.
--   - Ceftriaxone Antibiotic sold more units than Insulin 100ml but earned less total profit.
--   - Overall, a product's profitability depends not only on sales volume but also on profit per unit and profit margin.
