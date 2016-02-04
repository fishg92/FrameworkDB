CREATE proc [dbo].[pr__SYS_CreateStandardSchema]
	@tableName varchar(128)

as

set @tableName = object_name(object_id(@tableName))

exec dbo.pr__SYS_AddAuditFields
	@tableName = @tableName

exec dbo.pr__SYS_CreateAuditSchema
	@tableName = @tableName

exec dbo.pr__SYS_MakeDeleteRecordProcAuditFields 
	@sTableName = @tableName
	,@bExecute = 1

exec dbo.pr__SYS_MakeInsertRecordProcAuditFields 
	@sTableName = @tableName
	,@bExecute = 1

exec dbo.pr__SYS_MakeUpdateRecordProcAuditFields 
	@sTableName = @tableName
	,@bExecute = 1

exec dbo.pr__SYS_MakeSelectRecordProc
	@sTableName = @tableName
	,@bExecute = 1
