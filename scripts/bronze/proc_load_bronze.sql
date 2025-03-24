CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
	DECLARE @start_time DATETIME,@end_time DATETIME;
	BEGIN TRY
		PRINT '==========================';
		PRINT 'Loading the bronze layer';
		PRINT '==========================';

		PRINT '==========================';
		PRINT 'Loading CRM Tables';
		PRINT '==========================';
		SET @start_time = GETDATE()
		TRUNCATE TABLE bronze.crm_cust_info;
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\AKSHAR_1\C\Users\Akshar\Akshar\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);

		TRUNCATE TABLE bronze.crm_prd_info;
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\AKSHAR_1\C\Users\Akshar\Akshar\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);

		TRUNCATE TABLE bronze.crm_sales_details;
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\AKSHAR_1\C\Users\Akshar\Akshar\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE()
		PRINT 'Load Duration:'+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';

		SET @start_time = GETDATE()
		PRINT '==========================';
		PRINT 'Loading ERP Tables';
		PRINT '==========================';
		TRUNCATE TABLE bronze.erp_cust_az12;
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\AKSHAR_1\C\Users\Akshar\Akshar\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);

		TRUNCATE TABLE bronze.erp_loc_a101;
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\AKSHAR_1\C\Users\Akshar\Akshar\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);

		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\AKSHAR_1\C\Users\Akshar\Akshar\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE()
		PRINT 'Load Duration:'+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
	END TRY
	BEGIN CATCH
		PRINT '==========================';
		PRINT 'ERROR OCCURED IN BRONZE LAYER';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Number' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error State' + CAST(ERROR_STATE() AS NVARCHAR);

		PRINT '==========================';
	END CATCH
END
