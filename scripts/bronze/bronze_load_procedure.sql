USE [DataWarehouse]
GO
/****** Object:  StoredProcedure [bronze].[data_load]    Script Date: 18-11-2026 22:19:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER   procedure [bronze].[data_load]
as
begin
begin try
declare @batch_starttime datetime;
declare @batch_endtime datetime;
declare @tbl_st datetime;
declare @tbl_end datetime;
SET @batch_starttime=GETDATE();
print'================================================';
print'Loading bronze layer';
print 'Loading CRM tables';
SET @batch_starttime=GETDATE();
set @tbl_st=GETDATE();
truncate table bronze.crm_cust_info;
SET DATEFORMAT DMY;
bulk insert bronze.crm_cust_info from 'C:\Users\sunitha\Documents\datawarehouse-project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
with(
firstrow=2,
fieldterminator=',',
tablock);
set @tbl_end=GETDATE();
print'Duration of load for crm.cust_info:'+cast(datediff(second,@tbl_st,@tbl_end) as varchar);
set @tbl_st=GETDATE();
truncate table  bronze.crm_prd_info;
 bulk insert bronze.crm_prd_info
 from 'C:\Users\sunitha\Documents\datawarehouse-project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
 with
 (firstrow=2,
 fieldterminator=',',
 tablock);
 set @tbl_end=GETDATE();
 print'Duration of load for crm.prd_info:'+cast(datediff(second,@tbl_st,@tbl_end) as varchar);
 set @tbl_st=GETDATE();
 truncate table bronze.crm_sales_details;
 bulk insert bronze.crm_sales_details
 from 'C:\Users\sunitha\Documents\datawarehouse-project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
 with
 (firstrow=2,
 fieldterminator=',',
 tablock);
 set @tbl_end=GETDATE();
 print'Duration of load for crm.sales_details:'+cast(datediff(second,@tbl_st,@tbl_end) as varchar);
 set @tbl_st=GETDATE();
 print 'Loading ERP tables';
 truncate table bronze.erp_cust_az12;
  bulk insert bronze.erp_cust_az12
 from 'C:\Users\sunitha\Documents\datawarehouse-project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
 with
 (firstrow=2,
 fieldterminator=',',
 tablock);
 set @tbl_end=GETDATE();
 print'Duration of load for erp.cust_az12:'+cast(datediff(second,@tbl_st,@tbl_end) as varchar);
 set @tbl_st=GETDATE();
 truncate table bronze.erp_loc_a101;
  bulk insert bronze.erp_loc_a101
 from 'C:\Users\sunitha\Documents\datawarehouse-project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
 with
 (firstrow=2,
 fieldterminator=',',
 tablock);
 set @tbl_end=GETDATE();
 print'Duration of load for erp.loc_a101:'+cast(datediff(second,@tbl_st,@tbl_end) as varchar);
 set @tbl_st=GETDATE();
 truncate table bronze.erp_px_cat_g1v2;
  bulk insert bronze.erp_px_cat_g1v2
 from 'C:\Users\sunitha\Documents\datawarehouse-project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
 with
 (firstrow=2,
 fieldterminator=',',
 tablock);
  set @tbl_end=GETDATE();
 print'Duration of load for erp.px_cat_g1v1:'+cast(datediff(second,@tbl_st,@tbl_end) as varchar);
 SET @batch_endtime=GETDATE();
 print 'Total duration of Load:'+cast(datediff(second,@batch_starttime,@batch_endtime) as varchar);
 print'end of load operation';
 print'===========================================================';
 end try
 begin catch
 print'Error occured during load of bronze layer';
 print'err-msg'+error_message();
 print 'err-number'+cast(error_number() as nvarchar);
 PRINT 'err line: ' + CAST(ERROR_LINE() AS VARCHAR(10));
 end catch
 end;
