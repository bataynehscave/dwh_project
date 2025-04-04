drop view if exists gold.fact_sales;

create view gold.fact_sales as 
SELECT
sd.sls_ord_num as order_number,
pr.product_number,
pr.product_key,
cu.customer_key,
sd.sls_sales as sales,
sd.sls_quantity as quantity,
sd.sls_price as price,
sd.sls_order_dt as order_date,
sd.sls_ship_dt as ship_date,
sd.sls_due_dt as due_date
FROM silver.crm_sales_details sd
LEFT JOIN gold.dim_products pr
ON sd.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customers cu
ON sd.sls_cust_id = cu.customer_id;
