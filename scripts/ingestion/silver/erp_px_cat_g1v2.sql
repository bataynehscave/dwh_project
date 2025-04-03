raise notice 'Ingesting ERP category Info into Silver Layer';

Truncate table silver.erp_px_cat_g1v2;

insert into silver.erp_px_cat_g1v2

select * from bronze.erp_px_cat_g1v2;