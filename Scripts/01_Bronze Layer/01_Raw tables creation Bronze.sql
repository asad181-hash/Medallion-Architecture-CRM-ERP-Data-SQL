USE DataWarehouse;
Go

-- CRM DATA
-- Extracting raw tables for bronze layer
-- Extracting raw (staging) customer info table

IF OBJECT_ID ('bronze_crm_cust_info') IS NOT NULL
	DROP TABLE bronze_crm_cust_info;

CREATE TABLE bronze_crm_cust_info (
	cst_id INT,
	cst_key VARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50),
	cst_marital_status NVARCHAR(10),
	cst_gndr NVARCHAR(5),
	cst_create_date DATE
);

Go

-- Extracting raw (Staging) product_info table

IF OBJECT_ID ('bronze_crm_prd_info') IS NOT NULL
	DROP TABLE bronze_crm_prd_info;

CREATE TABLE bronze_crm_prd_info (
	prd_id INT,
	prd_key NVARCHAR(50),
	prd_nm NVARCHAR(100),
	prd_cost INT,
	prd_line NVARCHAR(20),
	prd_start_dt DATE,
	prd_end_dt DATE
);

Go

-- Extracting raw Sales_details table

IF OBJECT_ID ('bronze_crm_sales_details') IS NOT NULL
	DROP TABLE bronze_crm_sales_details;

CREATE TABLE bronze_crm_sales_details (
	sls_ord_num NVARCHAR(50),
	sls_prd_key NVARCHAR(50),
	sls_cust_id INT,
	sls_order_dt INT,
	sls_ship_dt INT,
	sls_due_dt INT,
	sls_sales INT,
	sls_quantity INT,
	sls_price INT
);

Go

-- ERP DATE
-- Extracting raw tables for bronze layer

-- CUST_AZ12 table

IF OBJECT_ID ('bronze_erp_CUST_AZ12') IS NOT NULL
	DROP TABLE bronze_erp_CUST_AZ12;

CREATE TABLE bronze_erp_CUST_AZ12 (
	CID NVARCHAR(100),
	BDATE DATE,
	GEN NVARCHAR(10)
);

Go

-- LOC_A101 table

IF OBJECT_ID ('bronze_erp_LOC_A101') IS NOT NULL
	DROP TABLE bronze_erp_LOC_A101;

CREATE TABLE bronze_erp_LOC_A101 (
	CID NVARCHAR(100),
	CNTRY NVARCHAR(50)
);

Go

-- PX_CAT_G1V2 table

IF OBJECT_ID ('bronze_erp_PX_CAT_G1V2') IS NOT NULL
	DROP TABLE bronze_erp_PX_CAT_G1V2;

CREATE TABLE bronze_erp_PX_CAT_G1V2 (
	ID NVARCHAR(100),
	CAT NVARCHAR(100),
	SUBCAT NVARCHAR(100),
	MAINTENANCE NVARCHAR(100)
);

Go