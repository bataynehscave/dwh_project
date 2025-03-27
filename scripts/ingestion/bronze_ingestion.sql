DROP PROCEDURE IF EXISTS bronze.load_bronze;

CREATE PROCEDURE bronze.load_bronze()
LANGUAGE plpgsql
AS $$
BEGIN
    -- Truncate and copy data for crm_cust_info
    TRUNCATE TABLE bronze.crm_cust_info;
    COPY bronze.crm_cust_info FROM 'C:/Users/MANIA/Desktop/portfolio_projects/dwh_project/datasets/source_crm/cust_info.csv' DELIMITER ',' CSV HEADER QUOTE '"';

    -- Truncate and copy data for crm_prd_info
    TRUNCATE TABLE bronze.crm_prd_info;
    COPY bronze.crm_prd_info FROM 'C:/Users/MANIA/Desktop/portfolio_projects/dwh_project/datasets/source_crm/prd_info.csv' DELIMITER ',' CSV HEADER QUOTE '"';

    -- Truncate and copy data for crm_sales_details
    TRUNCATE TABLE bronze.crm_sales_details;
    COPY bronze.crm_sales_details FROM 'C:/Users/MANIA/Desktop/portfolio_projects/dwh_project/datasets/source_crm/sales_details.csv' DELIMITER ',' CSV HEADER QUOTE '"';

    -- Truncate and copy data for erp_cust_az12
    TRUNCATE TABLE bronze.erp_cust_az12;
    COPY bronze.erp_cust_az12 FROM 'C:/Users/MANIA/Desktop/portfolio_projects/dwh_project/datasets/source_erp/cust_az12.csv' DELIMITER ',' CSV HEADER QUOTE '"';

    -- Truncate and copy data for erp_loc_a101
    TRUNCATE TABLE bronze.erp_loc_a101;
    COPY bronze.erp_loc_a101 FROM 'C:/Users/MANIA/Desktop/portfolio_projects/dwh_project/datasets/source_erp/loc_a101.csv' DELIMITER ',' CSV HEADER QUOTE '"';

    -- Truncate and copy data for erp_px_cat_g1v2
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;
    COPY bronze.erp_px_cat_g1v2 FROM 'C:/Users/MANIA/Desktop/portfolio_projects/dwh_project/datasets/source_erp/px_cat_g1v2.csv' DELIMITER ',' CSV HEADER QUOTE '"';
END;
$$;
