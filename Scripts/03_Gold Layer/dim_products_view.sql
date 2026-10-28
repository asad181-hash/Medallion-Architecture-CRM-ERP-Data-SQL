-- Gold Layer
-- Dimension Products

DROP VIEW IF EXISTS dim_products;
Go

CREATE VIEW dim_products AS
SELECT
    ROW_NUMBER() OVER (ORDER BY pri.prd_id) AS product_key,
    pri.prd_id AS product_id,
    pri.cat_id AS category_id,
    pri.prd_key AS product_number,
    pri.prd_nm AS product_name,
    pc.cat AS category,
    pc.subcat AS subcategory,
    pc.maintenance,
    pri.prd_cost AS cost,
    pri.prd_line AS product_line,
    pri.prd_start_dt AS start_date,
    pri.prd_end_dt AS end_date
FROM silver_crm_prd_info pri
LEFT JOIN silver_erp_PX_CAT_G1V2 pc
    ON pri.cat_id = pc.ID;