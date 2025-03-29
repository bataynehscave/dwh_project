DROP PROCEDURE IF EXISTS bronze.load_bronze;

CREATE PROCEDURE bronze.load_bronze()
LANGUAGE plpgsql
AS $$
DECLARE
    start_time TIMESTAMP;
    end_time TIMESTAMP;
    duration INTERVAL;
BEGIN
    -- Print starting message with timestamp
    start_time := clock_timestamp();
    RAISE NOTICE 'Starting the data load process at: %', start_time;

    -- Truncate and copy data for crm_cust_info
    BEGIN
        RAISE NOTICE 'Truncating crm_cust_info table...';
        TRUNCATE TABLE bronze.crm_cust_info;
        RAISE NOTICE 'Loading data into crm_cust_info...';
        COPY bronze.crm_cust_info FROM 'C:/Users/MANIA/Desktop/portfolio_projects/dwh_project/datasets/source_crm/cust_info.csv' DELIMITER ',' CSV HEADER QUOTE '"';
        end_time := clock_timestamp();
        duration := end_time - start_time;
        RAISE NOTICE 'Data loaded into crm_cust_info in: %', duration;
    EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'Error occurred while loading crm_cust_info: %', SQLERRM;
    END;

    -- Truncate and copy data for crm_prd_info
    BEGIN
        RAISE NOTICE 'Truncating crm_prd_info table...';
        TRUNCATE TABLE bronze.crm_prd_info;
        RAISE NOTICE 'Loading data into crm_prd_info...';
        COPY bronze.crm_prd_info FROM 'C:/Users/MANIA/Desktop/portfolio_projects/dwh_project/datasets/source_crm/prd_info.csv' DELIMITER ',' CSV HEADER QUOTE '"';
        end_time := clock_timestamp();
        duration := end_time - start_time;
        RAISE NOTICE 'Data loaded into crm_prd_info in: %', duration;
    EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'Error occurred while loading crm_prd_info: %', SQLERRM;
    END;

    -- Truncate and copy data for crm_sales_details
    BEGIN
        RAISE NOTICE 'Truncating crm_sales_details table...';
        TRUNCATE TABLE bronze.crm_sales_details;
        RAISE NOTICE 'Loading data into crm_sales_details...';
        COPY bronze.crm_sales_details FROM 'C:/Users/MANIA/Desktop/portfolio_projects/dwh_project/datasets/source_crm/sales_details.csv' DELIMITER ',' CSV HEADER QUOTE '"';
        end_time := clock_timestamp();
        duration := end_time - start_time;
        RAISE NOTICE 'Data loaded into crm_sales_details in: %', duration;
    EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'Error occurred while loading crm_sales_details: %', SQLERRM;
    END;

    -- Truncate and copy data for erp_cust_az12
    BEGIN
        RAISE NOTICE 'Truncating erp_cust_az12 table...';
        TRUNCATE TABLE bronze.erp_cust_az12;
        RAISE NOTICE 'Loading data into erp_cust_az12...';
        COPY bronze.erp_cust_az12 FROM 'C:/Users/MANIA/Desktop/portfolio_projects/dwh_project/datasets/source_erp/cust_az12.csv' DELIMITER ',' CSV HEADER QUOTE '"';
        end_time := clock_timestamp();
        duration := end_time - start_time;
        RAISE NOTICE 'Data loaded into erp_cust_az12 in: %', duration;
    EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'Error occurred while loading erp_cust_az12: %', SQLERRM;
    END;

    -- Truncate and copy data for erp_loc_a101
    BEGIN
        RAISE NOTICE 'Truncating erp_loc_a101 table...';
        TRUNCATE TABLE bronze.erp_loc_a101;
        RAISE NOTICE 'Loading data into erp_loc_a101...';
        COPY bronze.erp_loc_a101 FROM 'C:/Users/MANIA/Desktop/portfolio_projects/dwh_project/datasets/source_erp/loc_a101.csv' DELIMITER ',' CSV HEADER QUOTE '"';
        end_time := clock_timestamp();
        duration := end_time - start_time;
        RAISE NOTICE 'Data loaded into erp_loc_a101 in: %', duration;
    EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'Error occurred while loading erp_loc_a101: %', SQLERRM;
    END;

    -- Truncate and copy data for erp_px_cat_g1v2
    BEGIN
        RAISE NOTICE 'Truncating erp_px_cat_g1v2 table...';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;
        RAISE NOTICE 'Loading data into erp_px_cat_g1v2...';
        COPY bronze.erp_px_cat_g1v2 FROM 'C:/Users/MANIA/Desktop/portfolio_projects/dwh_project/datasets/source_erp/px_cat_g1v2.csv' DELIMITER ',' CSV HEADER QUOTE '"';
        end_time := clock_timestamp();
        duration := end_time - start_time;
        RAISE NOTICE 'Data loaded into erp_px_cat_g1v2 in: %', duration;
    EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'Error occurred while loading erp_px_cat_g1v2: %', SQLERRM;
    END;

    -- Final message with total elapsed time
    end_time := clock_timestamp();
    duration := end_time - start_time;
    RAISE NOTICE 'Data load process completed successfully! Total time: %', duration;
END;
$$;
