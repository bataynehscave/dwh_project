insert into silver.crm_prd_info

select
prd_id,
replace(substring(prd_key from 1 for 5 ), '-', '_') as cat_id,
replace(substring(prd_key from 7) , '-', '_') as prd_key,
prd_nm,
COALESCE(prd_cost, 0) as prd_cost,
Case Upper(Trim(prd_line))
 When 'M' then 'Mountain'
 When 'R' then 'Road'
 When 'S' then 'Other Sales'
 When 'T' then 'Touring'
 Else 'n/a'
end as prd_line,
cast (prd_start_dt as Date) as prd_start_dt,
cast(Lead(prd_start_dt) Over
(Partition by prd_key order by prd_start_dt) - 1 as Date)
as prd_end_dt

from bronze.crm_prd_info;