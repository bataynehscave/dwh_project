/*
=====================
Bronze Layer DDL
=====================
this scripts create the tables in the bronze layer of the data warehouse with naming conventions
(source)_tablename
=====================`
columns have the same names as the source tables
=====================
WARNING:
This script will drop the tables if they already exist

*/


\c "DataWarehouse";

drop table if exists bronze.crm_cust_info;
create table
    bronze.crm_cust_info (
        cst_id int primary key,
        cst_key varchar(100),
        cst_firstname varchar(100),
        cst_lastname varchar(20),
        cst_address varchar(100),
        cst_marital_status varchar(20),
        cst_gender varchar(20),
        cst_create_date date
    );

drop table if exists bronze.prd_info;
create table
    bronze.prd_info (
        prd_id int primary key,
        prd_key varchar(60),
        prd_nm varchar(100),
        prd_cost decimal(10, 2),
        prd_line varchar(100),
        prd_start_dt date,
        prd_end_dt date
    );

drop table if exists bronze.sales_details;
create table
    bronze.sales_details (
        sls_ord_num int primary key,
        sls_prd_key varchar(60),
        sls_cust_id int,
        sls_order_dt date,
        sls_ship_dt date,
        sls_due_dt date,
        sls_sales decimal(10, 2),
        sls_quantity int,
        sls_price decimal(10, 2)
    );


drop table if exists bronze.erp_cust_az12;
create table
    bronze.erp_cust_az12 (CID int primary key, BDATE date, GEN varchar(20));


drop table if exists bronze.erp_loc_a101;
create table
    bronze.erp_loc_a101 (CID int primary key, CNTRY varchar(50));


drop table if exists bronze.erp_px_cat_g1v2;
create table
    bronze.erp_px_cat_g1v2 (
        ID int primary key,
        CAT varchar(50),
        SUBCAT varchar(50),
        MAINTENANCE varchar(50)
    );