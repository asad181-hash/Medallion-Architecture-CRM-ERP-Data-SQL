-- ==============================================
-- Checking data quality issues from bronze layer
-- ==============================================

-- Check for Nulls or duplicates in primary key.
-- No result

-- Customer Information Table

SELECT
	cst_id,
	COUNT(*) AS count
FROM bronze_crm_cust_info
GROUP BY
	cst_id
HAVING 
	COUNT(*) > 1 
	OR
	cst_id IS NULL;


SELECT *
FROM bronze_crm_cust_info
WHERE cst_id = 29466;

-- Check for unwanted spaces

SELECT
	cst_firstname
FROM bronze_crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname);


SELECT
	cst_lastname
FROM bronze_crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname);


SELECT
	cst_gndr
FROM bronze_crm_cust_info
WHERE cst_gndr != TRIM(cst_gndr);

-- Date standardization & Consistency

SELECT
	DISTINCT cst_gndr
FROM bronze_crm_cust_info;



SELECT
	DISTINCT cst_marital_status
FROM bronze_crm_cust_info;


-- =============================================================
-- Validating data quality issues from silver layer after fixing
-- =============================================================

SELECT
	cst_id,
	COUNT(*) AS count
FROM silver_crm_cust_info
GROUP BY
	cst_id
HAVING 
	COUNT(*) > 1 
	OR
	cst_id IS NULL;


SELECT *
FROM silver_crm_cust_info
WHERE cst_id = 29466;

-- Check for unwanted spaces

SELECT
	cst_firstname
FROM silver_crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname);


SELECT
	cst_lastname
FROM silver_crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname);


SELECT
	cst_gndr
FROM silver_crm_cust_info
WHERE cst_gndr != TRIM(cst_gndr);

-- Date standardization & Consistency

SELECT
	DISTINCT cst_gndr
FROM silver_crm_cust_info;


SELECT
	DISTINCT cst_marital_status
FROM silver_crm_cust_info;


SELECT *
FROM silver_crm_cust_info;
