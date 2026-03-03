/*
================================================================================================
Script Name: Create Bronze Schema Tables
Description: 
    This script initializes the 'Bronze' layer of the DataWarehouse. It defines 
    the raw table structures for both CRM and ERP source systems. 

Instructions:
    1. Ensure the 'DataWarehouse' database and 'bronze' schema already exist.
    2. Execute this script to create the 6 core staging tables.
    3. After execution, use the 'bronze.load_bronze' procedure to populate these tables.

WARNING:
    This script uses 'DROP TABLE' statements. Executing this will permanently 
    delete all existing data within the bronze tables before recreating them. 
    Do not run on production environments without a verified backup.
================================================================================================
*/

-- =============================================================================
-- Create Bronze Tables (Raw Data)
-- =============================================================================

-- 1. CRM Customer Info
IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_cust_info;
CREATE TABLE bronze.crm_cust_info (
    cst_id          INT,
    cst_key         NVARCHAR(50),
    cst_firstname   NVARCHAR(50),
    cst_lastname    NVARCHAR(50),
    cst_marital_status NVARCHAR(50),
    cst_gndr        NVARCHAR(50),
    cst_create_date DATE
);
GO

-- 2. CRM Product Info
IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_prd_info;
CREATE TABLE bronze.crm_prd_info (
    prd_id       INT,
    prd_key      NVARCHAR(50),
    prd_nm       NVARCHAR(50),
    prd_cost     INT,
    prd_line     NVARCHAR(50),
    prd_start_dt DATETIME,
    prd_end_dt   DATETIME
);
GO

-- 3. CRM Sales Details
IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE bronze.crm_sales_details;
CREATE TABLE bronze.crm_sales_details (
    sls_ord_num  NVARCHAR(50),
    sls_prd_key  NVARCHAR(50),
    sls_cust_id  INT,
    sls_order_dt INT,
    sls_ship_dt  INT,
    sls_due_dt   INT,
    sls_sales    INT,
    sls_qty      INT,
    sls_price    INT
);
GO

-- 4. ERP Customer AZ12
IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE bronze.erp_cust_az12;
CREATE TABLE bronze.erp_cust_az12 (
    CID    NVARCHAR(50),
    BDate  DATE,
    Gen    NVARCHAR(50)
);
GO

-- 5. ERP Location A101
IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE bronze.erp_loc_a101;
CREATE TABLE bronze.erp_loc_a101 (
    CID    NVARCHAR(50),
    CNTRY  NVARCHAR(50)
);
GO

-- 6. ERP Product Category G1V2
IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE bronze.erp_px_cat_g1v2;
CREATE TABLE bronze.erp_px_cat_g1v2 (
    ID           NVARCHAR(50),
    CAT          NVARCHAR(50),
    SUBCAT       NVARCHAR(50),
    MAINTENANCE  NVARCHAR(50)
);
GO
