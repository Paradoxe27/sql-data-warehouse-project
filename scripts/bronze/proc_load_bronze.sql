/*
================================================================================================
Stored Procedure: Load Bronze Layer (Source --> Bronze)
Description: 
    This procedure truncates and reloads the bronze tables by importing raw data from 
    external CSV files (CRM and ERP sources). It includes performance logging 
    (duration tracking) and error handling via TRY...CATCH blocks.

Instructions:
    1. Verify that the source CSV files exist in the specified C:\ drive paths.
    2. Ensure the SQL Server service account has "Read" permissions for those folders.
    3. Execute the procedure using the command: EXEC bronze.load_bronze;

Note:
  1- The stored procedure does not accept any parameter
  2- The stored procedure use the "BULK INSERT" to load datas into the bronze layer
  

WARNING:
    This procedure performs a 'TRUNCATE', which removes all existing records from 
    the bronze tables before loading new data. It is intended for a full-refresh 
    loading strategy.
================================================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME,@final_start_time DATETIME, @final_end_time DATETIME; 
	BEGIN TRY
		
		SET @final_start_time = GETDATE();
		PRINT '--===============================================================';
		PRINT '--     1-        LOADING THE BRONZE LAYER';
		PRINT '--===============================================================';
	
		PRINT '             LOADING THE CRM TABLES                               ';
		PRINT '-----------------------------------------------------------------';		

		SET @start_time = GETDATE();
		PRINT '>> TRUNCATING THE TABLE : bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>> LOADING THE TABLE : bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\Paradoxe27\Desktop\SQL Course\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		); 
		SET @end_time = GETDATE();
		PRINT '>> Load Duration :'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' Seconds';
		PRINT '------------------'
		PRINT ''
		PRINT ''

		--===============================================================
		--     2-        LOADING THE PRODUCT INFOS TABLE
		--===============================================================

		SET @start_time = GETDATE();
		PRINT '>> TRUNCATING THE TABLE : bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;


		PRINT '>> LOADING THE TABLE : bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\Paradoxe27\Desktop\SQL Course\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		); 

		SET @end_time = GETDATE();
		PRINT '>> Load Duration :'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' Seconds';
		PRINT '------------------'
		PRINT ''
		PRINT ''
	

		--===============================================================
		--    3-         LOADING THE SALES DETAILS TABLE
		--===============================================================

		SET @start_time = GETDATE();
		PRINT '>> TRUNCATING THE TABLE : bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>> LOADING THE TABLE : bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\Paradoxe27\Desktop\SQL Course\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		); 
		SET @end_time = GETDATE();
		PRINT '>> Load Duration :'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' Seconds';
		PRINT '------------------'
		PRINT ''
		PRINT ''
	


		--===============================================================
		--    4-         LOADING THE ERP_CUST_AZ12  TABLE
		--===============================================================	
		PRINT '-----------------------------------------------------------------';
		PRINT '             LOADING THE ERP TABLES                               ';
		PRINT '-----------------------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> TRUNCATING THE TABLE : bronze.erp_cust_az12;';
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT '>> LOADING THE TABLE : bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\Paradoxe27\Desktop\SQL Course\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		); 
		SET @end_time = GETDATE();
		PRINT '>> Load Duration :'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' Seconds';
		PRINT '------------------'
		PRINT ''
		PRINT ''
	

		--===============================================================
		--    5-         LOADING THE ERP_LOC_A101  TABLE
		--===============================================================

		SET @start_time = GETDATE();
		PRINT '>> TRUNCATING THE TABLE : bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT '>> LOADING THE TABLE : bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\Paradoxe27\Desktop\SQL Course\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		); 
		SET @end_time = GETDATE();
		PRINT '>> Load Duration :'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' Seconds';
		PRINT '------------------'
		PRINT ''
		PRINT ''
	

		--===============================================================
		--     6-        LOADING THE ERP_PX_CAT_G1V2  TABLE
		--===============================================================

		SET @start_time = GETDATE();
		PRINT '>> TRUNCATING THE TABLE : bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT '>> LOADING THE TABLE : bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\Paradoxe27\Desktop\SQL Course\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		); 
		SET @end_time = GETDATE();
		PRINT '>> Load Duration :'+ CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' Seconds';
		PRINT '------------------'
		PRINT ''
		PRINT ''

		PRINT '=============================== TOTAL DURATION'
		SET @final_end_time = GETDATE();
		PRINT '>>  :'+ CAST(DATEDIFF(second,@final_start_time,@final_end_time) AS NVARCHAR)+' Seconds';
		PRINT '------------------'

	END TRY 

	BEGIN CATCH 
			
			PRINT '--===============================================================';
			PRINT 'ERROR OCCURED DURING LOADING THE BRONZE LAYER';
			PRINT 'ERROR Message: '+ERROR_MESSAGE();
			PRINT 'ERROR Number: '+ CAST(ERROR_NUMBER() AS NVARCHAR);
			PRINT 'ERROR Number: '+ CAST(ERROR_STATE() AS NVARCHAR);
			PRINT '--===============================================================';

	END CATCH
	
END
