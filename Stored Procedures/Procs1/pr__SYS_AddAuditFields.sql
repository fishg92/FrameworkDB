CREATE proc [dbo].[pr__SYS_AddAuditFields]
	@tableName varchar(128)
as


declare @cmd varchar(1000)

set @cmd = 'if not exists (select * from syscolumns where id = object_id(''' 
	+ @tablename + ''') and name = ''LUPUser'') 
alter table ' + @tablename + ' add LUPUser varchar(50) NULL'

exec (@cmd)

set @cmd = 'if not exists (select * from syscolumns where id = object_id(''' 
	+ @tablename + ''') and name = ''LUPDate'') 
alter table ' + @tablename + ' add LUPDate datetime NULL'

exec (@cmd)

set @cmd = 'if not exists (select * from syscolumns where id = object_id(''' 
	+ @tablename + ''') and name = ''CreateUser'') 
alter table ' + @tablename + ' add CreateUser varchar(50) NULL'

exec (@cmd)

set @cmd = 'if not exists (select * from syscolumns where id = object_id(''' 
	+ @tablename + ''') and name = ''CreateDate'') 
alter table ' + @tablename + ' add CreateDate datetime NULL'

exec (@cmd)

