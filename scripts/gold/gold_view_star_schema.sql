/*
========================================================
CREATING VIEWS FOR THE GOLD LAYER OF THE DATA WAREHOUSE
========================================================
Script Purpose: 
	The script creates views for the gold layer of the data warehouse. 
	The script contains view for dimensions and fact tables. 

*/


/*
==============================
CREATING A CUSTOMER DIMENSION
==============================
Script Purpose: 
	The script creates a customer dimension in the gold 
	layer by integrating data from multiple source tables in the silver layer. 
	The script performs data integration, deduplication, and 
	transformation to create a clean and consolidated customer dimension.

Steps: 
	1. Use LEFT JOIN to combine all tables with customer data
	2. Verify no duplicates after the join by grouping by 
	   customer ID and COUNT(*) occurrences. The result should be blank (no duplicates).
	3. Perform data integration on columns that exist in two tables. For example, gender
	4. Give friendly names for column headers
	5. Re-organise the coumns in a more logical order
	6. Create a surrogate key for the customer dimension using ROW_NUMBER() function
	7. Create a view for the customer dimension in the gold layer

Execute View
	SELECT * FROM gold.dim_customer
*/

-- Script
CREATE OR ALTER VIEW gold.dim_customer AS
SELECT 
	ROW_NUMBER() OVER(ORDER BY cst_id) AS customer_key,-- Creting a surrogate key for the customer dimension
	ci.cst_id AS customer_id,
	ci.cst_key AS customer_number,
	ci.cst_firstname AS first_name,
	ci.cst_lastname AS last_name,
	ci.cst_marital_status AS marital_status,
	la.cntry AS country,
	CASE
		WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr --CRM is Master for gender info
		ELSE COALESCE(ca.gen, 'n/a') -- If CRM is n/a, take from ERP
	END gender,
	ca.bdate AS birthdate,
	ci.cst_create_date AS create_date
FROM silver.crm_cust_info AS ci
LEFT JOIN silver.erp_cust_az12 AS ca
	ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 AS la
	ON ci.cst_key = la.cid


/*
=============================
CREATING A PRODUCT DIMENSION
=============================
Script Purpose:
	The script creates a product dimension view in the gold layer by joining the
	silver-layer product and category data into a gold-layer VIEW.

Execute View
	SELECT * FROM gold.dim_product
*/

-- Script
CREATE OR ALTER VIEW gold.dim_product AS
SELECT 
	ROW_NUMBER() OVER(ORDER BY pn.prd_start_dt, pn.prd_key) AS product_key,
	pn.prd_id AS product_id,
	pn.prd_key AS product_number,
	pn.prd_nm AS product_name,
	pn.cat_id AS category_id,
	pc.cat AS category,
	pc.subcat AS subcategory,
	pc.maintenance,
	pn.prd_cost AS cost,
	pn.prd_line AS product_line,
	pn.prd_start_dt AS start_date
/*pn.prd_end_dt, Remove this as the whole column is NULL*/
FROM silver.crm_prd_info pn
LEFT JOIN silver.erp_px_cat_g1v2 pc
	ON pn.cat_id = pc.id
WHERE prd_end_dt IS NULL -- Filter out historical data

/*
==============================
CREATING THE SALES FACT TABLE
==============================

Steps:
	1. Join the silver.crm_sales_details table with the gold.dim_product 
	   and gold.dim_customer views
	2. Replace the fact table "connection keys" with the corresponding 
	   surrogate keys from the dimension tables

Execute View
	SELECT * FROM gold.fact_sales

*/
--Script
CREATE OR ALTER VIEW gold.fact_sales AS
SELECT 
	sd.sls_ord_num AS order_number,
	cu.customer_key,
	pr.product_key,
	sd.sls_order_dt AS order_date,
	sd.sls_ship_dt AS shipping_date,
	sd.sls_due_dt AS due_date,
	sd.sls_quantity AS quantity,
	sd.sls_price AS price,
	sd.sls_sales AS sales_amount
FROM silver.crm_sales_details sd
LEFT JOIN gold.dim_product pr
	ON sd.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customer cu
	ON sd.sls_cust_id = cu.customer_id