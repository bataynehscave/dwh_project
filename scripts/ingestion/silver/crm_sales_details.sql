raise notice 'Ingesting CRM sales Info into Silver Layer';

Truncate table silver.crm_sales_details;


insert into silver.crm_sales_details

select 
sls_ord_num,
sls_prd_key,
sls_cust_id,
case 
	when sls_order_dt <= 0 or floor(log(sls_order_dt)) < 7 then NULL
	else CAST(cast(sls_order_dt as varchar(8)) as DATE)
end as sls_order_dt,
case 
	when sls_ship_dt <= 0 or floor(log(sls_ship_dt)) < 7 then NULL
	else CAST(cast(sls_ship_dt as varchar(8)) as DATE)
end as sls_ship_dt,	 
case 
	when sls_due_dt <= 0 or floor(log(sls_due_dt)) < 7 then NULL
	else CAST(cast(sls_due_dt as varchar(8)) as DATE)
end as sls_due_dt,

CASE
	WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price)
	THEN sls_quantity * ABS(sls_price)
	ELSE sls_sales
END AS sls_sales, 
sls_quantity,
CASE
	WHEN sls_price IS NULL OR sls_price <= 0
	THEN sls_sales / NULLIF(sls_quantity, 0)
	ELSE sls_price 
END AS sls_price

from bronze.crm_sales_details;
