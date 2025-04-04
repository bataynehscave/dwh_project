DROP PROCEDURE IF EXISTS silver.load_silver;

CREATE PROCEDURE silver.load_silver()
LANGUAGE plpgsql
AS $$
DECLARE
    start_time TIMESTAMP;
    end_time TIMESTAMP;
    step_start TIMESTAMP;
    step_end TIMESTAMP;
BEGIN
    start_time := clock_timestamp();
    RAISE NOTICE 'Started silver ingestion procedure at: %', start_time;

    BEGIN
        step_start := clock_timestamp();
        RAISE NOTICE 'Ingesting CRM Customer Info into Silver Layer';
        TRUNCATE TABLE silver.crm_cust_info;
        INSERT INTO silver.crm_cust_info
        SELECT 
            cst_id,
            cst_key,
            TRIM(cst_firstname) AS cst_firstname,
            TRIM(cst_lastname) AS cst_lastname,
            CASE
                WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
                WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
                ELSE 'n/a'
            END AS cst_marital_status,
            CASE
                WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
                WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
                ELSE 'n/a'
            END AS cst_gndr,
            cst_create_date
        FROM (
            SELECT *, ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date) AS last_flag
            FROM bronze.crm_cust_info
            WHERE cst_id IS NOT NULL
        ) sub
        WHERE last_flag = 1;
        step_end := clock_timestamp();
        RAISE NOTICE 'Finished crm_cust_info ingestion at: %', step_end;
    EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'Error occurred while loading crm_cust_info: %', SQLERRM;
    END;

    BEGIN
        step_start := clock_timestamp();
        RAISE NOTICE 'Ingesting CRM Product Info into Silver Layer';
        TRUNCATE TABLE silver.crm_prd_info;
        INSERT INTO silver.crm_prd_info
        SELECT
            prd_id,
            REPLACE(SUBSTRING(prd_key FROM 1 FOR 5), '-', '_') AS cat_id,
            REPLACE(SUBSTRING(prd_key FROM 7), '-', '_') AS prd_key,
            prd_nm,
            COALESCE(prd_cost, 0) AS prd_cost,
            CASE UPPER(TRIM(prd_line))
                WHEN 'M' THEN 'Mountain'
                WHEN 'R' THEN 'Road'
                WHEN 'S' THEN 'Other Sales'
                WHEN 'T' THEN 'Touring'
                ELSE 'n/a'
            END AS prd_line,
            CAST(prd_start_dt AS DATE) AS prd_start_dt,
            CAST(LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt) - 1 AS DATE) AS prd_end_dt
        FROM bronze.crm_prd_info;
        step_end := clock_timestamp();
        RAISE NOTICE 'Finished crm_prd_info ingestion at: %', step_end;
    EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'Error occurred while loading crm_prd_info: %', SQLERRM;
    END;

    BEGIN
        step_start := clock_timestamp();
        RAISE NOTICE 'Ingesting CRM Sales Info into Silver Layer';
        TRUNCATE TABLE silver.crm_sales_details;
        INSERT INTO silver.crm_sales_details
        SELECT 
            sls_ord_num,
            replace(sls_prd_key, '-', '_') as sls_prd_key,
            sls_cust_id,
            CASE WHEN sls_order_dt <= 0 OR FLOOR(LOG(sls_order_dt)) < 7 THEN NULL
                 ELSE CAST(CAST(sls_order_dt AS VARCHAR(8)) AS DATE)
            END AS sls_order_dt,
            CASE WHEN sls_ship_dt <= 0 OR FLOOR(LOG(sls_ship_dt)) < 7 THEN NULL
                 ELSE CAST(CAST(sls_ship_dt AS VARCHAR(8)) AS DATE)
            END AS sls_ship_dt, 
            CASE WHEN sls_due_dt <= 0 OR FLOOR(LOG(sls_due_dt)) < 7 THEN NULL
                 ELSE CAST(CAST(sls_due_dt AS VARCHAR(8)) AS DATE)
            END AS sls_due_dt,
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
        FROM bronze.crm_sales_details;
        step_end := clock_timestamp();
        RAISE NOTICE 'Finished crm_sales_details ingestion at: %', step_end;
    EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'Error occurred while loading crm_sales_details: %', SQLERRM;
    END;

    BEGIN
        step_start := clock_timestamp();
        RAISE NOTICE 'Ingesting ERP Location Info into Silver Layer';
        TRUNCATE TABLE silver.erp_loc_a101;
        INSERT INTO silver.erp_loc_a101
        SELECT
            REPLACE(cid, '-', '') AS cid,
            CASE WHEN TRIM(cntry) = 'DE' THEN 'Germany'
                 WHEN TRIM(cntry) IN ('US', 'USA') THEN 'United States'
                 WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
                 ELSE TRIM(cntry)
            END AS cntry
        FROM bronze.erp_loc_a101;
        step_end := clock_timestamp();
        RAISE NOTICE 'Finished erp_loc_a101 ingestion at: %', step_end;
    EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'Error occurred while loading erp_loc_a101: %', SQLERRM;
    END;

    end_time := clock_timestamp();
    RAISE NOTICE 'Completed silver ingestion procedure at: %', end_time;
END;
$$;
