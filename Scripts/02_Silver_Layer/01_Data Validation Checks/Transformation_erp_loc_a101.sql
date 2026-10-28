-- Data Quality checks

SELECT *
FROM bronze_erp_LOC_A101;

-- Data standardization

SELECT 
	DISTINCT CNTRY
FROM bronze_erp_LOC_A101;