

/*Foregin Key Integrity (Dimmensions)
Checking if all dimension tables are properly joined to the fact table.

*/
SELECT * FROM gold.fact_sales f
LEFT JOIN gold.dim_customer c
	ON f.customer_key = c.customer_key
LEFT JOIN gold.dim_product p
 	ON f.product_key = p.product_key
WHERE c.customer_key IS NULL
OR p.product_key IS NULL -- should not return any records if joined properly