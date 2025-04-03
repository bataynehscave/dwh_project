insert into silver.erp_cust_az12
select


case 
	when cid like 'NAS%' then substring(cid from 4)
	else cid
end as cid,
case
	when bdate < cast('1920-1-1' as date) or bdate + 365*5 > NOW() then NULL
	else bdate
end as bdate,
case
	when UPPER(TRIM(gen)) in ('MALE', 'M') then 'Male'
	when UPPER(TRIM(gen)) in ('FEMALE', 'F') then 'Female'
	else 'n/a'
end as gen

from bronze.erp_cust_az12


