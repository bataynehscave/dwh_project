drop view if exists gold.dim_products;

create view
    gold.dim_products as
select
    row_number() over (
        order by
            pn.prd_key,
            pn.prd_start_dt
    ) as product_key,
    pn.prd_id as product_id,
    pn.prd_key as product_number,
    pn.prd_nm as product_name,
    pn.cat_id as category_id,
    pn.prd_line as product_line,
    ec.cat as category,
    ec.subcat as subcategory,
    ec.maintenance,
    pn.prd_start_dt as start_date,
    pn.prd_end_dt
from
    silver.crm_prd_info pn
    left join silver.erp_px_cat_g1v2 ec on ec.id = pn.cat_id
where
    pn.prd_end_dt is null;