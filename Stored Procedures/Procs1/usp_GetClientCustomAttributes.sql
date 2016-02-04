
--[usp_GetClientCustomAttributes] 1,2
--[usp_GetClientCustomAttributes] 1111,2

CREATE PROC [dbo].[usp_GetClientCustomAttributes]
(@fkcpClient as decimal
,@fkProgramType as decimal
)
As
DECLARE @SQLString VARCHAR(8000)
DECLARE @Fields varchar(5000)

if exists (select * FROM CPClientCustomAttribute where fkCPClient = @fkCPClient) BEGIN
	select @Fields = COALESCE(@Fields + ', ' + Mapping, Mapping)
	 from (select Mapping = 
		'[' + 
		(select FriendlyName from ColumnNameFriendlyNameMapping
		where TableName = 'CPClientCustomAttribute'
		and ColumnName = m.ClientCustomAttributeColumn) + '] = ' + m.ClientCustomAttributeColumn 	
		from ProgramTypeClientCustomAttributeColumnMapping m
		where fkProgramType = @fkProgramType) a
	set @SQLString = 'select fkCPClient, ' + @Fields + ' FROM CPClientCustomAttribute where fkCPClient = ' + cast(@fkCpClient as varchar(100))
END ELSE BEGIN
	select @Fields = COALESCE(@Fields + ', ' + Mapping, Mapping)
	 from (select Mapping = 
		'[' + 
		(select FriendlyName from ColumnNameFriendlyNameMapping
		where TableName = 'CPClientCustomAttribute'
		and ColumnName = m.ClientCustomAttributeColumn) + '] = ' + '''''' 
		from ProgramTypeClientCustomAttributeColumnMapping m
		where fkProgramType = @fkProgramType) a
	set @SQLString = 'select fkCPClient = ' + cast(@fkCpClient as varchar(100)) + ', ' + @Fields 
END




exec (@SQLString)
--print @sqlstring

SET ANSI_NULLS OFF
