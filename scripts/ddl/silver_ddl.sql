/*
=====================
silver Layer DDL
=====================
this scripts create the tables in the silver layer of the data warehouse with naming conventions
(source)_tablename
=====================`
columns have the same names as the source tables
=====================
WARNING:
This script will drop the tables if they already exist

 */
-- \c "DataWarehouse";

drop table if exists silver.crm_cust_info;

create table
    silver.crm_cust_info (
        cst_id int,
        cst_key varchar(100),
        cst_firstname varchar(100),
        cst_lastname varchar(20),
        cst_marital_status varchar(20),
        cst_gndr varchar(20),
        cst_create_date date,
        dwh_create_date date default NOW()
    );

drop table if exists silver.crm_prd_info;

create table
    silver.crm_prd_info (
        prd_id int,
        cat_id varchar(50),
        prd_key varchar(50),
        prd_nm varchar(100),
        prd_cost decimal(10, 2),
        prd_line varchar(100),
        prd_start_dt date,
        prd_end_dt date,
        dwh_create_date date default NOW()
    );

drop table if exists silver.crm_sales_details;

create table
    silver.crm_sales_details (
        sls_ord_num varchar(50),
        sls_prd_key varchar(60),
        sls_cust_id int,
        sls_order_dt date,
        sls_ship_dt date,
        sls_due_dt date,
        sls_sales decimal(10, 2),
        sls_quantity int,
        sls_price decimal(10, 2),
        dwh_create_date date default NOW()
    );

drop table if exists silver.erp_cust_az12;

create table
    silver.erp_cust_az12 (
        CID varchar(50),
        BDATE date,
        GEN varchar(20),
        dwh_create_date date default NOW()
    );

drop table if exists silver.erp_loc_a101;

create table
    silver.erp_loc_a101 (
        CID varchar(50),
        CNTRY varchar(50),
        dwh_create_date date default NOW()
    );

drop table if exists silver.erp_px_cat_g1v2;

create table
    silver.erp_px_cat_g1v2 (
        ID varchar(50),
        CAT varchar(50),
        SUBCAT varchar(50),
        MAINTENANCE varchar(50),
        dwh_create_date date default NOW()
    );