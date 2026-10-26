-- Stored Procedure for FULL LOAD:

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME,
	@batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		-- Develop SQL Load scripts:
		-- Using BULK INSERT technique
		-- Write SQL BULK INSERT to load all the csv files into your Bronze tables.

		-- We are using FULL LOAD method - first truncate the table, make it empty and
		-- then INSERT the data from the scratch into the table, we call it full load.
		-- INSERT the data using normal insert or bulk insert.

		SET @start_time = GETDATE();
		-- 1. For table bronze.crm_cust_info
		TRUNCATE TABLE bronze.crm_cust_info;
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\Admin\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		-- SELECT * FROM bronze.crm_cust_info;
		--SELECT COUNT(*) FROM bronze.crm_cust_info;
		-- DELETE FROM bronze.crm_cust_info;
		-- SELECT 1 FROM bronze.crm_cust_info;
		SET @end_time = GETDATE();
		PRINT '1. Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';


		-- 2. For table bronze.crm_prd_info
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_prd_info;
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\Admin\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		--SELECT COUNT(*) FROM bronze.crm_prd_info;
		-- SELECT * FROM bronze.crm_prd_info;
		SET @end_time = GETDATE();
		PRINT '2. Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';


		-- 3. For table bronze.crm_sales_details
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_sales_details
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\Admin\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		-- SELECT COUNT(*) FROM bronze.crm_sales_details;
		-- SELECT * FROM bronze.crm_sales_details;
		SET @end_time = GETDATE();
		PRINT '3. Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';



		-- 4. For table bronze.erp_cust_az12
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_cust_az12;
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\Admin\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SELECT COUNT(*) FROM bronze.erp_cust_az12;
		-- SELECT * FROM bronze.erp_cust_az12;
		SET @end_time = GETDATE();
		PRINT '4. Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';



		-- 5. For table bronze.erp_loc_a101
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_loc_a101;
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\Admin\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		-- SELECT COUNT(*) FROM bronze.erp_loc_a101;
		-- SELECT * FROM bronze.erp_loc_a101;
		SET @end_time = GETDATE();
		PRINT '5. Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';



		-- 6. For table bronze.erp_px_cat_g1v2
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\Admin\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		-- SELECT COUNT(*) FROM bronze.erp_px_cat_g1v2;
		-- SELECT * FROM bronze.erp_px_cat_g1v2;
		SET @end_time = GETDATE();
		PRINT '6. Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		SET @batch_end_time = GETDATE();
		PRINT 'Total time:' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
	END TRY
	BEGIN CATCH
		PRINT 'ERROR occurred during loading the bronze layer';
		PRINT 'ERROR Message: ' + ERROR_MESSAGE();
		PRINT 'ERROR Number: ' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR State: ' + CAST (ERROR_STATE() AS NVARCHAR);
	END CATCH
END
