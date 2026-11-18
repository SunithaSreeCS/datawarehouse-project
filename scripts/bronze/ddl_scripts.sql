use master;

--creating database

create database DataWarehouse;


use datawarehouse;

--creating schemas for each layer

create schema bronze;
go
create schema silver;
go
create schema gold;

---building bronze layer

if object_id('bronze.crm_cust_info ','U') is not null
   drop table bronze.crm_cust_info;
create table bronze.crm_cust_info 
(cst_id int,
cst_key nvarchar(50),
cst_firstname nvarchar(20),
cst_lastname nvarchar(50),
cst_marital_status nvarchar(50),
cst_gndr nvarchar(50),
cst_created_date date);
go
if object_id('bronze.crm_prd_info ','U') is not null
   drop table bronze.crm_prd_info;
create table bronze.crm_prd_info(prd_id int,prd_key nvarchar(50),
prd_nm nvarchar(50),prd_cost int,prd_line nvarchar(50),prd_start_dt date,
prd_end_date date);
go
alter table bronze.crm_prd_info
alter column prd_start_dt datetime;
go
alter table bronze.crm_prd_info
alter column prd_end_date datetime;
go
if object_id('bronze.crm_sales_details ','U') is not null
   drop table bronze.crm_sales_details;
create table bronze.crm_sales_details(sls_ord_num nvarchar(20),
sls_prd_key nvarchar(20),sls_cust_id int,sls_order_dt int,sls_ship_dt int,
sls_due_dt int,
sls_sales int,sls_quality int
,sls_price int);
go
if object_id('bronze.erp_cust_az12 ','U') is not null
   drop table bronze.erp_cust_az12;
create table bronze.erp_cust_az12(cid nvarchar(20),bdate date,gen nvarchar(20));
go
if object_id('bronze.erp_loc_a101 ','U') is not null
   drop table bronze.erp_loc_a101;
create table bronze.erp_loc_a101(cid nvarchar(20),cntry nvarchar(20));
go
if object_id('bronze.erp_px_cat_g1v2 ','U') is not null
   drop table bronze.erp_px_cat_g1v2;
create table bronze.erp_px_cat_g1v2(id nvarchar(10),cat nvarchar(50),subcat nvarchar(100),
maintenance nvarchar(10));

