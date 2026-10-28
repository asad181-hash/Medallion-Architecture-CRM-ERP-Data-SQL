-- Data Quality check

SELECT *
FROM bronze_erp_CUST_AZ12;

-- White spaces check

SELECT
	CID
FROM bronze_erp_CUST_AZ12
WHERE 
	CID != TRIM(CID);


SELECT
	*
FROM bronze_erp_CUST_AZ12
WHERE 
	GEN != TRIM(GEN);


-- Checking nulls in CID
SELECT *
FROM silver_erp_CUST_AZ12
WHERE 
	CID IS NULL;


-- Identify out of range dates

SELECT *
FROM bronze_erp_CUST_AZ12
WHERE 
	BDATE < '2020-01-01';

-- Future bdates


SELECT *
FROM bronze_erp_CUST_AZ12
WHERE 
	BDATE > GETDATE();

-- DATE Standardization

SELECT 
	DISTINCT GEN
FROM bronze_erp_CUST_AZ12
;