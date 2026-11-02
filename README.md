# Pharmaceutical Sales Analysis with SQL

SQL analysis of a pharmaceutical distributor's sales database: warehouses, products, customers, sales and returns. The project answers 12 business questions on revenue, profitability, returns, customer segments and monthly trends, and summarises the findings for each one. Written in Oracle SQL.

## Key findings

- One return (500 sterile bandages) reduced total profit by 10%: returns are the biggest single risk to profitability.
- Insulin 100ml brings in 23% of total profit from only 50 units sold, so per-unit margin matters as much as volume.
- Wholesale customers drive the most revenue and profit; retail is the smallest segment.
- Sales follow a clear seasonal pattern: January is the strongest month every year, and February turns negative.

## Data model

| Table | Columns |
|---|---|
| `P_PRODUCTS` | PRODUCT_ID, NAME, PRODUCT_GROUP, PRODUCT_TYPE |
| `P_CUSTOMERS` | CUSTOMER_ID, NAME, PARTNER_GROUP |
| `P_WAREHOUSES` | WAREHOUSE_ID, NAME |
| `P_TRANSACTIONS` | TRANSACTION_ID, TRANSACTION_DATE, TRANSACTION_TYPE, CUSTOMER_ID, WAREHOUSE_ID, COMMENTS |
| `P_TRANSACTIONDETAILS` | TRANSACTION_ID, PRODUCT_ID, QUANTITY, SELLING_PRICE, TOTAL_AMOUNT, PROFIT, PROFIT_MARGIN |

Values in the database are in Armenian. The ones used in the queries:

| Value | Meaning |
|---|---|
| `Իրացում` | Sale |
| `Վերադարձ` | Return |
| `Մանրածախ` | Retail |
| `Մեծածախ` | Wholesale |

Amounts are in Armenian dram (AMD).

## Questions and queries

| # | Business question | Query |
|---|---|---|
| 1 | Show the total sales amount for each warehouse. If a warehouse has no sales, show 0. | [01_total_sales_by_warehouse.sql](queries/01_total_sales_by_warehouse.sql) |
| 2 | Find the products whose selling price is above 1,000 AMD. | [02_products_priced_above_1000.sql](queries/02_products_priced_above_1000.sql) |
| 3 | Calculate total sales and profit for each customer group, sorted by total sales in descending order. | [03_sales_and_profit_by_customer_group.sql](queries/03_sales_and_profit_by_customer_group.sql) |
| 4 | Analyse the reasons for returns and their impact on revenue and profit, and identify which products and customers have the most returns. | [04_returns_analysis.sql](queries/04_returns_analysis.sql) |
| 5 | Find the 3 most profitable products, taking into account quantity sold and profit. Show product name, type, total quantity sold, total profit and average profitability. | [05_top3_most_profitable_products.sql](queries/05_top3_most_profitable_products.sql) |
| 6 | Analyse warehouse efficiency by calculating, for each warehouse: total sales, average profitability, number of sales and average transaction amount. Show all metrics in one row per warehouse. | [06_warehouse_performance.sql](queries/06_warehouse_performance.sql) |
| 7 | Find transactions with a profit margin above 30% and a total amount above 50,000 AMD. | [07_high_margin_large_transactions.sql](queries/07_high_margin_large_transactions.sql) |
| 8 | Find products whose selling price is higher than the average selling price of all products. | [08_products_above_average_price.sql](queries/08_products_above_average_price.sql) |
| 9 | Calculate total sales and profit for customers in the Retail and Wholesale groups, and show their average sales margin. | [09_retail_vs_wholesale.sql](queries/09_retail_vs_wholesale.sql) |
| 10 | Show total sales and total profit for each month (year + month), ordered by date. | [10_monthly_sales_trend.sql](queries/10_monthly_sales_trend.sql) |
| 11 | Find each customer's largest transaction (by total amount) and its date. | [11_largest_transaction_per_customer.sql](queries/11_largest_transaction_per_customer.sql) |
| 12 | Analyse low-demand products by calculating each product's total quantity sold, total profit and share of total profit (%). Sort from least to most sold; for equal quantities, sort by profit share in ascending order. | [12_low_demand_products.sql](queries/12_low_demand_products.sql) |

## Findings by question

### 1. Total sales by warehouse

- Sales were made in 8 of the 10 warehouses, and the Export Warehouse recorded the highest sales volume.
- Branch N2 has a sale transaction, but its sale details are missing, so its total is 0. The goods may have been transferred to another warehouse and sold from there.

### 2. Products priced above 1,000 AMD

- Only 3 of the 10 products are priced above 1,000 AMD, and all of them are antibiotics or hormonal drugs.

### 3. Sales and profit by customer group

- Wholesale customers generate the highest turnover and profit, followed by Export and Medical Institutions. Retail customers have the lowest figures.

### 4. Returns analysis

- 5 returns were recorded. Only one, from a medical institution, was caused by an expired product. The rest came from retail and wholesale customers: one was due to a wrong order, and the others were most likely because the goods did not sell.
- The largest impact on total profit and revenue came from retail customer New Pharmacy, which returned all 500 units of sterile bandages. This cut total profit by 10.02% and revenue by 7.97% (returns are excluded from the total revenue and profit used as the base for these percentages).
- The second largest return, much smaller in impact, came from Medical Center N1 because of an expired product (Vitamin C). It reduced total profit by 2% and revenue by 1.86%.
- The remaining returns had a relatively small impact of up to 1.2%.

### 5. Top 3 most profitable products

- Heart Medication is the most profitable product, driven by the highest sales volume and total profit.
- Insulin 100ml sells far fewer units but delivers the highest profit per unit and the highest profit margin.
- Ceftriaxone Antibiotic sold more units than Insulin 100ml but earned less total profit.
- Overall, a product's profitability depends not only on sales volume but also on profit per unit and profit margin.

### 6. Warehouse performance

- The Export Warehouse leads in sales at 300,000 AMD from a single sale, with an average margin of 20%.
- The Central Warehouse is second at 167,000 AMD but has the highest average margin (30.06%) and the most sales (4 transactions), which points to more active operations.
- Raw Materials Warehouse N2 recorded 136,600 AMD in sales, but its average margin is negative (-14.58%), which shows that returns dominated its transactions. The Cold Storage Warehouse is similar, with an average margin of -4.17%.
- Some warehouses (Production Workshop, Wholesale Warehouse, Branch N2) show zero sales. Their goods may have been transferred to other warehouses to be sold there.

### 7. High-margin, high-value transactions

- Only 3 transactions are above 50,000 AMD with a margin above 30%, and all three have the same margin of 33.33%.
- Transaction 11 has the highest amount (150,000 AMD) and the highest profit (50,000 AMD). Transaction 4 is second (75,000 AMD, 25,000 AMD profit), and transaction 3 is third (54,000 AMD, 18,000 AMD profit).

### 8. Products priced above the average

- Only 4 products are priced above the average selling price.
- Insulin 100ml has the highest price (3,000 AMD), followed by Ceftriaxone Antibiotic (2,000 AMD) and Amoxil Antibiotic (1,800 AMD). Heart Medication (1,000 AMD) is also above the average.

### 9. Retail vs wholesale customers

- Armen Pharm LLC has the highest sales and profit (150,000 AMD and 50,000 AMD). Health Doctor LLC is second with 120,000 AMD in sales.
- New Pharmacy shows negative sales and profit, most likely because of a return or a cancelled sale.
- Overall, wholesale customers generate higher sales volumes, while margins vary from customer to customer.

### 10. Monthly sales trend

- January 2024 has the highest sales and profit (720,000 AMD and 180,000 AMD).
- February 2024, 2025 and 2026 all show negative sales and profit. In every year, January sales and profit are far higher than February's.

### 11. Largest transaction per customer

- The largest single transaction was made by Exporting Company (300,000 AMD), far above any other customer. Armenia Pharm LLC is second (150,000 AMD), followed by Health for All LLC (120,000 AMD).
- All other customers' largest transactions are below 100,000 AMD. New Pharmacy made two transactions: one with a negative amount and one with no amount recorded.
- All of the largest transactions took place in January.

### 12. Low-demand products

- Sterile Bandage has zero total quantity and profit, because the return fully cancelled the original sale.
- The next lowest by quantity are Amoxil Antibiotic (25 units), Paracetamol 200mg (40 units) and Insulin 100ml (50 units). Insulin 100ml stands out, however: it brings in 23.23% of total profit despite its relatively low volume.

## SQL techniques used

- Multi-table JOINs (INNER and LEFT, with filters placed correctly in the ON clause)
- Aggregation with GROUP BY, NVL and NULLIF
- Window functions: SUM() OVER (PARTITION BY ...), RANK(), nested SUM(SUM()) OVER ()
- CTEs (WITH) and subqueries
- Date handling: TRUNC and TO_CHAR for monthly trends
- Top-N queries with FETCH FIRST
