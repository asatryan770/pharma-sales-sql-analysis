-- Task 2: Products priced above 1,000 AMD
-- Question: Find the products whose selling price is above 1,000 AMD.
-- Dialect: Oracle SQL

SELECT DISTINCT
       P.PRODUCT_ID,
       P.NAME            AS "Product",
       P.PRODUCT_GROUP   AS "Product Group",
       TD.SELLING_PRICE  AS "Selling Price"
FROM P_PRODUCTS P
JOIN P_TRANSACTIONDETAILS TD
  ON TD.PRODUCT_ID = P.PRODUCT_ID
WHERE TD.SELLING_PRICE > 1000
ORDER BY 4 DESC;

-- Findings:
--   - Only 3 of the 10 products are priced above 1,000 AMD, and all of them are antibiotics or hormonal drugs.
