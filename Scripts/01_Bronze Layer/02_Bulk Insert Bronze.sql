-- ======================================================
--          Stored Procedure for Bulk Insert
-- ======================================================


CREATE OR ALTER PROCEDURE load_bronze AS
BEGIN
	
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;

	BEGIN TRY

		SET @batch_start_time = GETDATE();
		PRINT '====================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '====================================================';

		PRINT '====================================================';
		PRINT 'Loading CRM TABLES';
		PRINT '====================================================';

		-- CRM DB
		-- cust_info table

		SET @start_time = GETDATE();

		TRUNCATE TABLE bronze_crm_cust_info;

		BULK INSERT bronze_crm_cust_info
		FROM 'D:\NextBridge\SQL\Datawarehouse Project\Medallion_architecture\Data-Warehouse-Project-Material\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS VARCHAR) + ' seconds';

		-- prd_info table

		SET @start_time = GETDATE();

		TRUNCATE TABLE bronze_crm_prd_info;

		BULK INSERT bronze_crm_prd_info
		FROM 'D:\NextBridge\SQL\Datawarehouse Project\Medallion_architecture\Data-Warehouse-Project-Material\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @end_time = GETDATE()
		PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS VARCHAR) + ' seconds';

		-- sales_details table

		SET @start_time = GETDATE()

		TRUNCATE TABLE bronze_crm_sales_details; 

		BULK INSERT bronze_crm_sales_details
		FROM 'D:\NextBridge\SQL\Datawarehouse Project\Medallion_architecture\Data-Warehouse-Project-Material\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @end_time = GETDATE();
		PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS VARCHAR) + ' seconds';

		PRINT '====================================================';
		PRINT 'Loading ERP TABLES';
		PRINT '====================================================';

		-- ERP DB
		-- CUST_AZ12 table

		SET @start_time = GETDATE();

		TRUNCATE TABLE bronze_erp_CUST_AZ12

		BULK INSERT bronze_erp_CUST_AZ12
		FROM 'D:\NextBridge\SQL\Datawarehouse Project\Medallion_architecture\Data-Warehouse-Project-Material\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @end_time = GETDATE()
		PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS VARCHAR) + ' seconds';

		-- LOC_A101 table

		SET @start_time = GETDATE()

		TRUNCATE TABLE bronze_erp_LOC_A101

		BULK INSERT bronze_erp_LOC_A101
		FROM 'D:\NextBridge\SQL\Datawarehouse Project\Medallion_architecture\Data-Warehouse-Project-Material\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @end_time = GETDATE()
		PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS VARCHAR)+ ' seconds';

		-- PX_CAT_G1V2 table

		SET @start_time = GETDATE();

		TRUNCATE TABLE bronze_erp_PX_CAT_G1V2

		BULK INSERT bronze_erp_PX_CAT_G1V2
		FROM 'D:\NextBridge\SQL\Datawarehouse Project\Medallion_architecture\Data-Warehouse-Project-Material\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @end_time = GETDATE()
		PRINT '>> LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS VARCHAR) + ' seconds';

		SET @batch_end_time = GETDATE();
		PRINT '=============================================================';
		PRINT 'Loading Bronze layer is completed';
		PRINT '>> Total LOAD DURATION FOR BRONZE LAYER: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS VARCHAR) + ' seconds';
		PRINT '=============================================================';

	END TRY

	BEGIN CATCH
		PRINT '=============================================================';
		PRINT 'Error occoured during loading Bronze Layer';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Number' + CAST(ERROR_NUMBER()AS NVARCHAR);
		PRINT 'Error State' + CAST(ERROR_STATE()AS NVARCHAR);
		PRINT '=============================================================';
	END CATCH
END



EXEC load_bronze;