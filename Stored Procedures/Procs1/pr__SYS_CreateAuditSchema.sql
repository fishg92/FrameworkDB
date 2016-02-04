CREATE proc [dbo].[pr__SYS_CreateAuditSchema]
	@tableName varchar(128)

as

--correct capitalization in input parameter
set @tableName = object_name(object_id(@tableName))

declare	@auditTable varchar(128)

set @auditTable = @tableName + 'Audit'

--Generate audit columns if needed
--if exists (select * from sysobjects
--			where name = @tableName + 'Hist')
--	begin
--	exec pr__SYS_AddAuditFields @tableName = @tableName
--	end

--Create the Audit table if needed
if not exists (select * from sysobjects
				where name = @auditTable
				and xtype = 'U')
	
	exec dbo.pr__SYS_MakeAuditTables @tableName,1  
else
	begin
	exec dbo.pr__SYS_UpdateAuditTables @tableName,1,0                              
	--exec dbo.pr__SYS_UpdateAuditTables @tableName,1,1
	end

--Create or update the delete trigger
exec dbo.pr__SYS_MakeAuditTableDeleteTrigger @tableName,1               

--Create or update the insert/update trigger
exec dbo.pr__SYS_MakeAuditTableUITrigger @tableName,1


