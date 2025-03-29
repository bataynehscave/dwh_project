select 
	cst_id,
	cst_key,
	TRIM(cst_firstname) as cst_firstname,
	TRIM(cst_lastname) as cst_lastname,
	case
		when UPPER(TRIM(cst_marital_status)) = 'S' then 'Single'
		when UPPER(TRIM(cst_marital_status)) = 'M' then 'Married'
		ELSE 'n/a'
	end as cst_marital_status,
	case
		when UPPER(TRIM(cst_gndr)) = 'F' then 'Female'
		when UPPER(TRIM(cst_gndr)) = 'M' then 'Male'
		ELSE 'n/a'
	end as cst_gndr,
	cst_create_date

from

	(select  *,
	row_number()
	over (PARTITION BY cst_id order by cst_create_date) as last_flag
	from bronze.crm_cust_info
	where cst_id is not null)

where last_flag = 1;
;

