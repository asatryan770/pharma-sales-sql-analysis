-- Task 1: Total sales by warehouse
-- Question: Show the total sales amount for each warehouse. If a warehouse has no sales, show 0.
-- Dialect: Oracle SQL

SELECT W.WAREHOUSE_ID,
       W.NAME                        AS "Warehouse",
       NVL(SUM(TD.TOTAL_AMOUNT), 0)  AS "Total Sales"
FROM P_WAREHOUSES W
LEFT JOIN P_TRANSACTIONS T
       ON T.WAREHOUSE_ID = W.WAREHOUSE_ID
      -- Filter in the ON clause (not WHERE) so warehouses
      -- with no sales stay in the result and show 0
      AND T.TRANSACTION_TYPE = 'Իրացում'   -- 'Sale'
LEFT JOIN P_TRANSACTIONDETAILS TD
       ON TD.TRANSACTION_ID = T.TRANSACTION_ID
GROUP BY W.WAREHOUSE_ID, W.NAME
ORDER BY 3 DESC;

-- Findings:
--   - Sales were made in 8 of the 10 warehouses, and the Export Warehouse recorded the highest sales volume.
--   - Branch N2 has a sale transaction, but its sale details are missing, so its total is 0. The goods may have been transferred to another warehouse and sold from there.
