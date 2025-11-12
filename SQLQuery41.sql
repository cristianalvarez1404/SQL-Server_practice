SELECT DISTINCT
sls_sales AS old_sls_sales,
sls_quantity,
sls_price AS old_sls_price,
CASE WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price)
	THEN sls_quantity * ABS(sls_price)
	ELSE sls_sales
END AS sls_sales,
CASE WHEN sls_price IS NULL OR sls_price <= 0
	THEN sls_sales / NULLIF(sls_quantity, 0)
	ELSE sls_price
END AS sls_price,

FROM bronze.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price;


SELECT
	sls_ord_num,
	sls_prd_key,
	sls_cust_id,
	CASE
		WHEN sls_order_dt = 0 OR LEN(sls_order_dt) != 8 THEN NULL
		ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE)
	END AS sls_order_dt,
	CASE
		WHEN sls_ship_dt = 0 OR  LEN(sls_ship_dt) != 8 THEN NULL
		ELSE CAST(CAST(sls_ship_dt AS VARCHAR) AS DATE)
	END AS sls_ship_dt,
	CASE
		WHEN sls_due_dt = 0 OR  LEN(sls_due_dt) != 8 THEN NULL
		ELSE CAST(CAST(sls_due_dt AS VARCHAR) AS DATE)
	END AS sls_due_dt,
	CASE
		WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price)
			THEN sls_quantity * ABS(sls_price)
		ELSE sls_sales
	END AS sls_sales,
	sls_quantity,
	CASE 
		WHEN sls_price IS NULL OR sls_price <= 0
			THEN sls_sales / NULLIF(sls_quantity, 0)
		ELSE sls_price
	END AS sls_price
FROM bronze.crm_sales_details;

SELECT
cid,
CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid))
	ELSE cid
END AS cid,
bdate,
gen
FROM bronze.erp_cust_az12
WHERE CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid))
	ELSE cid
END NOT IN (SELECT DISTINCT cst_key FROM silver_crm_cust_info);

/*===========================================================*/
SELECT DISTINCT
bdate
FROM bronze.erp_curt_az12
WHERE bdate < '1924-01-01' OR bdate > GETDATE();

SELECT DISTINCT gen
FROM bronze.erp_cust_az12; 

INSERT INTO silver.erp_cust_az12(
	cid,
	dbate,
	gen
) 
SELECT
CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid))
	ELSE cid
END AS cid,
CASE WHEN dbate > GETDATE() THEN NULL
	ELSE dbate
END AS dbate,
CASE WHEN gen UPPER(TRIM(gen)) IN ('F','FEMALE') THEN 'Female'
		WHEN gen UPPER(TRIM(gen)) IN ('M', 'MALE') THEN 'Male'
		ELSE 'n/a'
END AS gen
FROM bronze.erp_cust_az12;

/*===========================================================*/

SELECT cst_key FROM silver.crm_cust_info;

SELECT DISTINCT cntry FROM bronze_erp_loc_a101 ORDER BY cntry;

INSERT INTO silver.erp_loc_a101
(
	cid,
	cntry
)
SELECT
REPLACE(cid, '-', '') AS cid,
CASE WHEN cntry TRIM(cntry) IN('USA','US') THEN 'United States'
	WHEN cntry TRIM(cntry) 'DE' THEN 'Germany'
	WHEN cntry TRIM(cntry) = '' OR IS NULL THEN 'n/a'
	ELSE TRIM(cntry)
END AS cntry
FROM bronze.erp_loc_a101 WHERE REPLACE(cid, '-','') NOT IN 
	(SELECT cst_key FROM silver.crm_cust_info);

/*===========================================================*/

INSERT INTO silver.erp_px_cat_g1v2
(id,cat,subcat,maintenance)
SELECT
id,
cat,
subcat,
maintenance
FROM bronze.erp_px_cat_g1v2;

-- check for unwanted Spaces
SELECT * FROM bronze.erp_px_cat_g1v2
WHERE cat != TRIM(cat) OR subcat != TRIM(subcat) OR maintenance != TRIM(maintenance);

-- Data Standardization & Consistency
SELECT DISTINCT
cat,
FROM bronze.erp_px_cat_g1v2



/*===================================================================*/

SELECT cst_id, COUNT(*) FROM
	(SELECT
		ci.cst_id,
		ci.cst_key,
		ci.cst_firstname,
		ci.cst_lastname,
		ci.cst_marital_status,
		ci.cst_gndr,
		ci.cst_create_date,
		ca.bdate,
		ca.gen,
		la.cntry
	FROM silver.crm_cust_info AS ci
	LEFT JOIN silver.erp_cust_az12 AS ca
	ON ci.cst_id = ca.cid
	LEFT JOIN silver.erp_loc_a101 AS la
	ON ci.cst_ley = la.cid
)t GROUP BY cst_id
HAVING COUNT(*) > 1

/*===================================================================*/

CREATE VIEW gold.dim_customers AS 
SELECT DISTINCT
	ROW_NUMBER() OVER(ORDER BY cst_id) AS customer_key,
	ci.cst_id AS customer_id,
	ci.cst_key AS customer_number,
	ci.cst_firstname AS first_name,
	ci.cst_lastname AS last_name,
	la.cntry AS country
	ci.cst_marital_status AS marital_status,
	CASE WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr --CRM is the Master for gender info
		ELSE COALENSCE(ca.gen, 'n/a')
	END AS gender,
	ca.bdate AS birthdate,
	ci.cst_create_date AS create_date
FROM silver.crm_cust_info AS ci
LEFT JOIN silver.crm_cust_info AS ca
ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 AS la
ON ci.cst_key = la.cid


/*===================================================================*/
/*SELECT prd_key, COUNT(*) FROM (
*/
CREATE VIEW gold.dim_products AS 
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
	pn.prd_start_dt AS start_date,
FROM silver.crm_prd_info AS pn
LEFT JOIN silver.erp_px_cat_g1v2 AS pc
ON pn.cat_id = pc.id
WHERE prd_end_dt IS NULL -- Filter out all historical data

/*
)t GROUP BY prd_key
HAVING COUNT(*) > 1
*/











