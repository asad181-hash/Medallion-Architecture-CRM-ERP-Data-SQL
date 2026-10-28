
-- Insertion into silver layer

CREATE OR ALTER PROCEDURE load_silver AS
BEGIN

	PRINT '========================================================'
	PRINT 'Truncating & Inserting CRM Tables'
	PRINT '========================================================'

	PRINT '>> Truncating Table: silver_crm_cust_info'
	TRUNCATE TABLE silver_crm_cust_info;
	PRINT '>> Inserting data into: silver_crm_cust_info'

	INSERT INTO silver_crm_cust_info (
		cst_id,
		cst_key,
		cst_firstname,
		cst_lastname,
		cst_marital_status,
		cst_gndr,
		cst_create_date
	)
	SELECT
		cst_id,
		cst_key,
		TRIM(cst_firstname) AS cst_firstname,
		TRIM(cst_lastname) AS cst_lastname,
		CASE
			WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
			WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
			ELSE 'n/a'
		END
		cst_marital_status,
		CASE
			WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
			WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
			ELSE 'n/a'
		END
		cst_gndr,
		cst_create_date
	FROM
		(SELECT
			*,
			ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
		FROM bronze_crm_cust_info
		WHERE 
			cst_id IS NOT NULL
		) t
	WHERE
		flag_last = 1;

	-- silver_crm_prd_info table
	PRINT '>> Truncating Table: silver_crm_prd_info'
	TRUNCATE TABLE silver_crm_prd_info;
	PRINT '>> Inserting data into: silver_crm_prd_info'

	INSERT INTO silver_crm_prd_info (
		prd_id,
		cat_id,
		prd_key,
		prd_nm,
		prd_cost,
		prd_line,
		prd_start_dt,
		prd_end_dt
	)

	SELECT
		prd_id,
		REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') AS cat_id,
		SUBSTRING(prd_key, 7, LEN(prd_key)) AS prd_key,
		prd_nm,
		ISNULL(prd_cost,0) AS prd_cost,
		CASE UPPER(TRIM(prd_line))
		   WHEN 'R' THEN 'Roads'
		   WHEN 'S' THEN 'Other Sales'
		   WHEN 'M' THEN 'Mountain'
		   WHEN 'T' THEN 'Tourism'
		   ELSE 'Unknown'
		END AS prd_line,
		CAST(prd_start_dt AS DATE) AS prd_start_dt,
		DATEADD(DAY, -1, LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt)) AS prd_end_dt
	FROM bronze_crm_prd_info

	-- silver_crm_sales_details table

	PRINT '>> Truncating Table: silver_crm_sales_details'
	TRUNCATE TABLE silver_crm_sales_details;
	PRINT '>> Inserting data into: silver_crm_sales_details'

	INSERT INTO silver_crm_sales_details (
		sls_ord_num,
		sls_prd_key,
		sls_cust_id,
		sls_order_dt,
		sls_ship_dt,
		sls_due_dt,
		sls_sales,
		sls_quantity,
		sls_price
	)

	SELECT
		sls_ord_num,
		sls_prd_key,
		sls_cust_id,
		CASE
			WHEN sls_order_dt = 0 OR LEN(sls_order_dt) != 8 THEN NULL
			ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE)
		END AS sls_order_dt,
		CASE
			WHEN sls_ship_dt = 0 OR LEN(sls_ship_dt) != 8 THEN NULL
			ELSE CAST(CAST(sls_ship_dt AS VARCHAR) AS DATE)
		END AS sls_ship_dt,
		CASE
			WHEN sls_due_dt = 0 OR LEN(sls_due_dt) != 8 THEN NULL
			ELSE CAST(CAST(sls_due_dt AS VARCHAR) AS DATE) 
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
	FROM bronze_crm_sales_details

	PRINT '========================================================'
	PRINT 'Truncating & Inserting ERP Tables'
	PRINT '========================================================'

	-- silver_erp_CUST_AZ12 table

	PRINT '>> Truncating Table: silver_erp_CUST_AZ12'
	TRUNCATE TABLE silver_erp_CUST_AZ12;
	PRINT '>> Inserting data into: silver_erp_CUST_AZ12'

	INSERT INTO silver_erp_CUST_AZ12 (
		CID,
		BDATE,
		GEN
	)

	SELECT
		CASE
			WHEN CID LIKE 'NAS%' THEN SUBSTRING(CID, 4, LEN(CID))
			ELSE CID
		END AS cid,
		CASE
			WHEN BDATE > GETDATE() THEN NULL
			ELSE BDATE
		END AS bdate,
		CASE
			WHEN UPPER(TRIM(GEN)) IN ('F', 'Female') THEN 'Female'
			WHEN UPPEr(TRIM(GEN)) IN ('M', 'Male') THEN 'Male'
			ELSE 'n/a'
		END AS gen
	FROM bronze_erp_CUST_AZ12


	-- silver_erp_LOC_A101 table

	PRINT '>> Truncating Table: silver_erp_LOC_A101'
	TRUNCATE TABLE silver_erp_LOC_A101;
	PRINT '>> Inserting data into: silver_erp_LOC_A101'

	INSERT INTO silver_erp_LOC_A101 (
		CID,
		CNTRY
	)

	SELECT
		REPLACE(CID, '-', '') AS CID,
		CASE
			 WHEN TRIM(CNTRY) = 'DE' THEN 'Germany'
			 WHEN TRIM(CNTRY) IN ('US', 'USA') THEN 'United States'
			 WHEN TRIM(CNTRY) = '' OR TRIM(CNTRY) IS NULL THEN 'n/a'
			 ELSE TRIM(CNTRY)
		END AS cntry
	FROM bronze_erp_LOC_A101


	-- silver_erp_PX_CAT_G1V2 table

	PRINT '>> Truncating Table: silver_erp_PX_CAT_G1V2'
	TRUNCATE TABLE silver_erp_PX_CAT_G1V2;
	PRINT '>> Inserting data into: silver_erp_PX_CAT_G1V2'

	INSERT INTO silver_erp_PX_CAT_G1V2 (
		ID,
		CAT,
		SUBCAT,
		MAINTENANCE
	)
	SELECT
		ID,
		CAT,
		SUBCAT,
		MAINTENANCE
	FROM bronze_erp_PX_CAT_G1V2

END


EXEC load_silver;
