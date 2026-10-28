USE DataWarehouse;
Go

-- CRM DATA
-- Creating tables for silver layer
-- Creating table customer info table

IF OBJECT_ID ('silver_crm_cust_info') IS NOT NULL
	DROP TABLE silver_crm_cust_info;

CREATE TABLE silver_crm_cust_info (
	cst_id INT,
	cst_key VARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50),
	cst_marital_status NVARCHAR(10),
	cst_gndr NVARCHAR(10),
	cst_create_date DATE,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

Go

-- Creating product_info table

IF OBJECT_ID ('silver_crm_prd_info') IS NOT NULL
	DROP TABLE silver_crm_prd_info;

CREATE TABLE silver_crm_prd_info (
	prd_id INT,
	cat_id NVARCHAR(50),
	prd_key NVARCHAR(50),
	prd_nm NVARCHAR(100),
	prd_cost INT,
	prd_line NVARCHAR(20),
	prd_start_dt DATE,
	prd_end_dt DATE,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

Go

-- Creating Sales_details table

IF OBJECT_ID ('silver_crm_sales_details') IS NOT NULL
	DROP TABLE silver_crm_sales_details;

CREATE TABLE silver_crm_sales_details (
	sls_ord_num NVARCHAR(50),
	sls_prd_key NVARCHAR(50),
	sls_cust_id INT,
	sls_order_dt DATE,
	sls_ship_dt DATE,
	sls_due_dt DATE,
	sls_sales INT,
	sls_quantity INT,
	sls_price INT,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

Go

-- ERP DATE
-- Creating tables for silver layer

-- CUST_AZ12 table

IF OBJECT_ID ('silver_erp_CUST_AZ12') IS NOT NULL
	DROP TABLE silver_erp_CUST_AZ12;

CREATE TABLE silver_erp_CUST_AZ12 (
	CID NVARCHAR(100),
	BDATE DATE,
	GEN NVARCHAR(10),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

Go

-- LOC_A101 table

IF OBJECT_ID ('silver_erp_LOC_A101') IS NOT NULL
	DROP TABLE silver_erp_LOC_A101;

CREATE TABLE silver_erp_LOC_A101 (
	CID NVARCHAR(100),
	CNTRY NVARCHAR(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

Go

-- PX_CAT_G1V2 table

IF OBJECT_ID ('silver_erp_PX_CAT_G1V2') IS NOT NULL
	DROP TABLE silver_erp_PX_CAT_G1V2;

CREATE TABLE silver_erp_PX_CAT_G1V2 (
	ID NVARCHAR(100),
	CAT NVARCHAR(100),
	SUBCAT NVARCHAR(100),
	MAINTENANCE NVARCHAR(100),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

Go