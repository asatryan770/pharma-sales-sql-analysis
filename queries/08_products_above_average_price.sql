-- Task 8: Products priced above the average
-- Question: Find products whose selling price is higher than the average selling price of all products.
-- Dialect: Oracle SQL

SELECT DISTINCT
       P.PRODUCT_ID,
       P.NAME            AS "Product",
       TD.SELLING_PRICE  AS "Selling Price"
FROM P_PRODUCTS P
JOIN P_TRANSACTIONDETAILS TD
  ON TD.PRODUCT_ID = P.PRODUCT_ID
WHERE TD.SELLING_PRICE >
      (SELECT AVG(SELLING_PRICE) FROM P_TRANSACTIONDETAILS)
ORDER BY 3 DESC;

-- Findings:
--   - Only 4 products are priced above the average selling price.
--   - Insulin 100ml has the highest price (3,000 AMD), followed by Ceftriaxone Antibiotic (2,000 AMD) and Amoxil Antibiotic (1,800 AMD). Heart Medication (1,000 AMD) is also above the average.
