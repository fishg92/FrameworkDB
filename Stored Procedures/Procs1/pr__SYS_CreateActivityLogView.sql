
create proc [dbo].[pr__SYS_CreateActivityLogView]
	@pkrefActivityType decimal
	,@exec bit = 0
as

declare @fkNcpApplication decimal
		,@ApplicationName varchar(2000)
		,@ViewName varchar(2000)
		,@ActivityName varchar(2000)
		,@Data1ColumnName varchar(2000)
		,@Data2ColumnName varchar(2000)
		,@Data3ColumnName varchar(2000)
		,@Data4ColumnName varchar(2000)
		,@Data5ColumnName varchar(2000)
		,@Data6ColumnName varchar(2000)
		,@Data7ColumnName varchar(2000)
		,@Data8ColumnName varchar(2000)
		,@Data9ColumnName varchar(2000)
		,@Data10ColumnName varchar(2000)
		,@DecimalData1ColumnName varchar(2000)
		,@DecimalData2ColumnName varchar(2000)
		,@DecimalData3ColumnName varchar(2000)
		,@DecimalData4ColumnName varchar(2000)
		,@DecimalData5ColumnName varchar(2000)
		,@DecimalData6ColumnName varchar(2000)
		,@DecimalData7ColumnName varchar(2000)
		,@DecimalData8ColumnName varchar(2000)
		,@DecimalData9ColumnName varchar(2000)
		,@DecimalData10ColumnName varchar(2000)
		,@BitData1ColumnName varchar(2000)
		,@BitData2ColumnName varchar(2000)
		,@BitData3ColumnName varchar(2000)
		,@BitData4ColumnName varchar(2000)
		,@BitData5ColumnName varchar(2000)
		,@DateData1ColumnName varchar(2000)
		,@DateData2ColumnName varchar(2000)
		,@DateData3ColumnName varchar(2000)
		,@DateData4ColumnName varchar(2000)
		,@DateData5ColumnName varchar(2000)

select @fkNcpApplication = fkNcpApplication
		,@ActivityName = dbo.CamelCase(Description)
		,@Data1ColumnName = dbo.CamelCase(Data1ColumnName)
		,@Data2ColumnName = dbo.CamelCase(Data2ColumnName)
		,@Data3ColumnName = dbo.CamelCase(Data3ColumnName)
		,@Data4ColumnName = dbo.CamelCase(Data4ColumnName)
		,@Data5ColumnName = dbo.CamelCase(Data5ColumnName)
		,@Data6ColumnName = dbo.CamelCase(Data6ColumnName)
		,@Data7ColumnName = dbo.CamelCase(Data7ColumnName)
		,@Data8ColumnName = dbo.CamelCase(Data8ColumnName)
		,@Data9ColumnName = dbo.CamelCase(Data9ColumnName)
		,@Data10ColumnName = dbo.CamelCase(Data10ColumnName)
		,@DecimalData1ColumnName = dbo.CamelCase(DecimalData1ColumnName)
		,@DecimalData2ColumnName = dbo.CamelCase(DecimalData2ColumnName)
		,@DecimalData3ColumnName = dbo.CamelCase(DecimalData3ColumnName)
		,@DecimalData4ColumnName = dbo.CamelCase(DecimalData4ColumnName)
		,@DecimalData5ColumnName = dbo.CamelCase(DecimalData5ColumnName)
		,@DecimalData6ColumnName = dbo.CamelCase(DecimalData6ColumnName)
		,@DecimalData7ColumnName = dbo.CamelCase(DecimalData7ColumnName)
		,@DecimalData8ColumnName = dbo.CamelCase(DecimalData8ColumnName)
		,@DecimalData9ColumnName = dbo.CamelCase(DecimalData9ColumnName)
		,@DecimalData10ColumnName = dbo.CamelCase(DecimalData10ColumnName)
		,@BitData1ColumnName = dbo.CamelCase(BitData1ColumnName)
		,@BitData2ColumnName = dbo.CamelCase(BitData2ColumnName)
		,@BitData3ColumnName = dbo.CamelCase(BitData3ColumnName)
		,@BitData4ColumnName = dbo.CamelCase(BitData4ColumnName)
		,@BitData5ColumnName = dbo.CamelCase(BitData5ColumnName)
		,@DateData1ColumnName = dbo.CamelCase(DateData1ColumnName)
		,@DateData2ColumnName = dbo.CamelCase(DateData2ColumnName)
		,@DateData3ColumnName = dbo.CamelCase(DateData3ColumnName)
		,@DateData4ColumnName = dbo.CamelCase(DateData4ColumnName)
		,@DateData5ColumnName = dbo.CamelCase(DateData5ColumnName)

from refActivityType
where pkrefActivityType = @pkrefActivityType

select @ApplicationName = convert(varchar(2000),ApplicationName)
from NCPApplication
where pkNCPApplication  = @fkNcpApplication

set @ApplicationName = replace(@ApplicationName,' ','')

set @ViewName = 'alv' + @ApplicationName + '_' + @ActivityName

if @exec = 1
	begin
	if exists (select * from sysobjects where name = @ViewName and xtype = 'V')
		exec ('drop view ' + @ViewName ) 
	end

declare @sql varchar(3000)

set @sql = 'create view dbo.' + @ViewName + '
as
select
pkActivityLog
,ActivityID
,fkApplicationUser
,fkDepartment
,fkAgencyLOB
,ParentActivityID
,ActivityDate
,MachineName'

if @Data1ColumnName <> ''
	set @sql = @sql + '
,' + @Data1ColumnName + ' = Data1'

if @Data2ColumnName <> ''
	set @sql = @sql + '
,' + @Data2ColumnName + ' = Data2'

if @Data3ColumnName <> ''
	set @sql = @sql + '
,' + @Data3ColumnName + ' = Data3'

if @Data4ColumnName <> ''
	set @sql = @sql + '
,' + @Data4ColumnName + ' = Data4'

if @Data5ColumnName <> ''
	set @sql = @sql + '
,' + @Data5ColumnName + ' = Data5'

if @Data6ColumnName <> ''
	set @sql = @sql + '
,' + @Data6ColumnName + ' = Data6'

if @Data7ColumnName <> ''
	set @sql = @sql + '
,' + @Data7ColumnName + ' = Data7'

if @Data8ColumnName <> ''
	set @sql = @sql + '
,' + @Data8ColumnName + ' = Data8'

if @Data9ColumnName <> ''
	set @sql = @sql + '
,' + @Data9ColumnName + ' = Data9'

if @Data10ColumnName <> ''
	set @sql = @sql + '
,' + @Data10ColumnName + ' = Data10'

if @DecimalData1ColumnName <> ''
	set @sql = @sql + '
,' + @DecimalData1ColumnName + ' = DecimalData1'

if @DecimalData2ColumnName <> ''
	set @sql = @sql + '
,' + @DecimalData2ColumnName + ' = DecimalData2'

if @DecimalData3ColumnName <> ''
	set @sql = @sql + '
,' + @DecimalData3ColumnName + ' = DecimalData3'

if @DecimalData4ColumnName <> ''
	set @sql = @sql + '
,' + @DecimalData4ColumnName + ' = DecimalData4'

if @DecimalData5ColumnName <> ''
	set @sql = @sql + '
,' + @DecimalData5ColumnName + ' = DecimalData5'

if @DecimalData6ColumnName <> ''
	set @sql = @sql + '
,' + @DecimalData6ColumnName + ' = DecimalData6'

if @DecimalData7ColumnName <> ''
	set @sql = @sql + '
,' + @DecimalData7ColumnName + ' = DecimalData7'

if @DecimalData8ColumnName <> ''
	set @sql = @sql + '
,' + @DecimalData8ColumnName + ' = DecimalData8'

if @DecimalData9ColumnName <> ''
	set @sql = @sql + '
,' + @DecimalData9ColumnName + ' = DecimalData9'

if @DecimalData10ColumnName <> ''
	set @sql = @sql + '
,' + @DecimalData10ColumnName + ' = DecimalData10'

if @BitData1ColumnName <> ''
	set @sql = @sql + '
,' + @BitData1ColumnName + ' = BitData1'

if @BitData2ColumnName <> ''
	set @sql = @sql + '
,' + @BitData2ColumnName + ' = BitData2'

if @BitData3ColumnName <> ''
	set @sql = @sql + '
,' + @BitData3ColumnName + ' = BitData3'

if @BitData4ColumnName <> ''
	set @sql = @sql + '
,' + @BitData4ColumnName + ' = BitData4'

if @BitData5ColumnName <> ''
	set @sql = @sql + '
,' + @BitData5ColumnName + ' = BitData5'

if @DateData1ColumnName <> ''
	set @sql = @sql + '
,' + @DateData1ColumnName + ' = DateData1'

if @DateData2ColumnName <> ''
	set @sql = @sql + '
,' + @DateData2ColumnName + ' = DateData2'

if @DateData3ColumnName <> ''
	set @sql = @sql + '
,' + @DateData3ColumnName + ' = DateData3'

if @DateData4ColumnName <> ''
	set @sql = @sql + '
,' + @DateData4ColumnName + ' = DateData4'

if @DateData5ColumnName <> ''
	set @sql = @sql + '
,' + @DateData5ColumnName + ' = DateData5'



set @sql = @sql + '
from ActivityLog
where fkrefActivityType = ' + convert(varchar(2000),@pkrefActivityType)

select @sql

if @exec = 1
	exec (@sql)


