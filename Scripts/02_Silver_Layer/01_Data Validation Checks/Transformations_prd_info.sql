-- ==============================================
-- Checking data quality issues from bronze layer
-- ==============================================

-- Check for Nulls or duplicates in primary key.
-- No result
SELECT *
FROM bronze_crm_prd_info;

SELECT
	prd_id,
	COUNT(*) AS count
FROM bronze_crm_prd_info
GROUP BY
	prd_id
HAVING 
	COUNT(*) > 1 
	OR
	prd_id IS NULL;


-- Check for unwanted spaces

SELECT
	prd_key
FROM bronze_crm_prd_info
WHERE prd_key != TRIM(prd_key);


SELECT
	prd_nm
FROM bronze_crm_prd_info
WHERE prd_nm != TRIM(prd_nm);


SELECT
	*
FROM bronze_crm_prd_info
WHERE 
	prd_cost IS NULL OR
	prd_cost < 0;


-- Date standardization & Consistency

SELECT
	DISTINCT prd_line
FROM bronze_crm_prd_info;

-- Check for invalid date orders

SELECT
	*
FROM bronze_crm_prd_info
WHERE
	prd_end_dt < prd_start_dt;


-- =====================================================
-- Validating data quality issues from silver layer
-- =====================================================

-- Check for Nulls or duplicates in primary key.
-- No result
SELECT *
FROM silver_crm_prd_info;

SELECT
	prd_id,
	COUNT(*) AS count
FROM silver_crm_prd_info
GROUP BY
	prd_id
HAVING 
	COUNT(*) > 1 
	OR
	prd_id IS NULL;


-- Check for unwanted spaces

SELECT
	prd_key
FROM silver_crm_prd_info
WHERE prd_key != TRIM(prd_key);


SELECT
	prd_nm
FROM silver_crm_prd_info
WHERE prd_nm != TRIM(prd_nm);


SELECT
	*
FROM silver_crm_prd_info
WHERE 
	prd_cost IS NULL OR
	prd_cost < 0;


-- Date standardization & Consistency

SELECT
	DISTINCT prd_line
FROM silver_crm_prd_info;

-- Check for invalid date orders

SELECT
	*
FROM bronze_crm_prd_info
WHERE
	prd_end_dt < prd_start_dt;