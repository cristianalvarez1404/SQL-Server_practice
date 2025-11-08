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






