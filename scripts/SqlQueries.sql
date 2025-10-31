CREATE DATABASE DATAWAREHOUSE;

CREATE SCHEMA BRONZE;

CREATE SCHEMA SILVER;

CREATE SCHEMA GOLD;

CREATE TABLE BRONZE.crm_cust_info(
cst_id INT,
cst_key varchar(50),
cst_firstname varchar(50),
cst_lastname varchar(50),
cst_marital_status varchar(50),
cst_gndr varchar(50),
cst_create_date date
);


SELECT*FROM BRONZE.crm_cust_info;

set global local_infile=1;
show variables like'local_infile';

LOAD DATA LOCAL INFILE '/Users/gangamakankshareddy/Downloads/datasets/source_crm/cust_info.csv'INTO TABLE bronze.crm_cust_info
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;


CREATE TABLE BRONZE.crm_prd_info(
prd_id INT,
prd_key varchar(50),
prd_nm varchar(50),
prd_cost INT,
prd_line varchar(50),
prd_start_dt DATETIME,
prd_end_dt DATETIME
);


LOAD DATA LOCAL INFILE '/Users/gangamakankshareddy/Downloads/datasets/source_crm/prd_info.csv'INTO TABLE bronze.crm_cust_info
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;



CREATE TABLE BRONZE.crm_sales_details(
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


LOAD DATA LOCAL INFILE '/Users/gangamakankshareddy/Downloads/datasets/source_crm/sales_details.csv'INTO TABLE bronze.crm_cust_info
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;



CREATE TABLE BRONZE.erp_cust_az12(
cid varchar(50),
bdate DATE,
gen varchar(50)
);

LOAD DATA LOCAL INFILE '/Users/gangamakankshareddy/Downloads/datasets/source_erp/CUST_AZ12.csv'INTO TABLE bronze.crm_cust_info
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;


CREATE TABLE bronze.erp_loc_a101(
cid varchar(50),
cntry varchar(50)
);


LOAD DATA LOCAL INFILE '/Users/gangamakankshareddy/Downloads/datasets/source_erp/LOC_A101.csv'INTO TABLE bronze.crm_cust_info
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;



CREATE TABLE BRONZE.erp_px_cat_g1v2(
id varchar(50),
cat varchar(50),
subcat varchar(50),
maintenance varchar(50)
);


LOAD DATA LOCAL INFILE '/Users/gangamakankshareddy/Downloads/datasets/source_erp/PX_CAT_G1V2.csv'INTO TABLE bronze.crm_cust_info
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;
