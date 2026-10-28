-- Gold layer
-- Fact table Sales

DROP VIEW IF EXISTS fact_sales;
Go

CREATE VIEW fact_sales AS
SELECT
	sd.sls_ord_num AS order_number,
	pr.product_key,
	c.customer_key,
	sd.sls_order_dt AS order_date,
	sd.sls_ship_dt AS ship_date,
	sd.sls_due_dt AS due_date,
	sd.sls_sales AS sales,
	sd.sls_quantity AS quantity,
	sd.sls_price AS price
FROM silver_crm_sales_details sd
LEFT JOIN dim_products pr
	ON sd.sls_prd_key = pr.product_number
LEFT JOIN dim_customers c
	ON sd.sls_cust_id = c.customer_id
