CREATE TABLE silver.crm_cust_info(
cst_id INT,
cst_key varchar(50),
cst_firstname varchar(50),
cst_lastname varchar(50),
cst_marital_status varchar(50),
cst_gndr varchar(50),
cst_create_date DATE
);

CREATE TABLE silver.crm_prd_info(
prd_id INT,
prd_key varchar(50),
prd_nm varchar(50),
prd_cost INT,
prd_line varchar(50),
prd_start_dt DATETIME,
prd_end_dt DATETIME
);

CREATE TABLE silver.crm_sales_details(
sls_ord_name VARCHAR(50),
sls_prd_key VARCHAR(50),
sls_cust_id INT,
sls_order_dt INT,
sls_ship_dt INT,
sls_due_dt INT,
sls_sales INT,
sls_quantity INT,
sls_price INT
);

CREATE TABLE silver.erp_cust_az12(
cid varchar(50),
bdate DATE,
gen varchar(50)
);

CREATE TABLE silver.erp_loc_a101(
cid varchar(50),
cntry varchar(50)
);

CREATE TABLE silver.erp_px_cat_g1v2(
id varchar(50),
cat varchar(50),
subcat varchar(50),
maintenance varchar(50)
);
