-- Data quality checks

SELECT *
FROM bronze_erp_PX_CAT_G1V2;

-- Data Inconcistency

SELECT
	*
FROM bronze_erp_PX_CAT_G1V2
WHERE
	CAT != TRIM(CAT)


SELECT
	*
FROM bronze_erp_PX_CAT_G1V2
WHERE
	SUBCAT != TRIM(SUBCAT);



SELECT
	*
FROM bronze_erp_PX_CAT_G1V2
WHERE
	MAINTENANCE != TRIM(MAINTENANCE);