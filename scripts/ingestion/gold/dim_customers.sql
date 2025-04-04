drop VIEW if exists gold.dim_customers;

create view gold.dim_customers as

select 
ROW_NUMBER() over (order by cst_id) as customer_key,
ci.cst_id as customer_id,
ci.cst_key as customer_number,
ci.cst_firstname as first_name,
ci.cst_lastname as last_name,
ci.cst_marital_status as marital_status,
la.cntry as country,
CASE
	when ci.cst_gndr != 'n/a' then ci.cst_gndr --this is the master source
	else COALESCE(ca.gen, 'n/a')
END as gender,
ca.bdate as birth_date0,
ci.cst_create_date

from silver.crm_cust_info ci
left join silver.erp_cust_az12 ca 
on ci.cst_key = ca.cid
left join silver.erp_loc_a101 la
on ci.cst_key = la.cid;