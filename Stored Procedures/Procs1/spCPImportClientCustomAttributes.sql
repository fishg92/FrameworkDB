
--select * from ProgramTypeClientCustomAttributeColumnMapping

--select * from CPClientCustomAttribute
--delete CPClientCustomAttribute where fkcpclient = 74

--select * from ColumnNameFriendlyNameMapping

--select * from ProgramType

--delete cpmigrationmap where pkcpmigrationmap = 1
--select * from cpmigrationmap 

--update joinprogramtypecpmigrationmap set fkcpmigrationmap = 2

--select * from joinprogramtypecpmigrationmap
-- select * from cpimportfsis

CREATE procedure [dbo].[spCPImportClientCustomAttributes]
 @fkCPClient decimal(18,0)
,@pkCPImportFSIS decimal(18,0)

as 

declare @MigrationFieldName varchar(50)
		,@MigrationTableName varchar(50)
		,@ColumnName varchar(50)
		,@FriendlyName varchar(100)
		,@SqlString varchar(500)
		,@CustomValue varchar(500)
		,@lf int

Declare  customFields  cursor for

select  m.MigrationFieldName
	  , m.MigrationTableName
	  , n.ColumnName
	  , n.FriendlyName 
from JoinProgramTypeCPMigrationMap j
inner join CPMigrationMap m
on m.pkCPMigrationMap = j.fkCPMigrationMap
inner join ColumnNameFriendlyNameMapping n
on n.pkColumnNameFriendlyNameMapping = m.fkColumnNameFriendlyNameMapping
where j.fkProgramType = 4 or j.fkProgramType = 2



Open customFields

Fetch Next From customFields into @MigrationFieldName,@MigrationTableName,@ColumnName,@FriendlyName

Set @lf = @@Fetch_Status


While @lf = 0
begin

	if ( exists( select 1 from CPClientCustomAttribute where fkCPClient = @fkCPClient))
	begin

		select @SqlString = 'Update CPClientCustomAttribute set ' + @ColumnName + ' = ' + 
		'(Select ' + @MigrationFieldName + ' from ' + @MigrationTableName + ' where pkCPImportFSIS = ' + convert(varchar(18),@pkCPImportFSIS) + ')' + 
		' Where fkCPClient = ' + convert(varchar(18),@fkCPClient) 
	end
	else
	begin

		-- first create the record in the CPClientCustomAttribute table
		insert into CPClientCustomAttribute 
		(fkCPClient) values(@fkCPClient)

		select @SqlString = 'Update CPClientCustomAttribute set ' + @ColumnName + ' = ' + 
		'(Select ' + @MigrationFieldName + ' from ' + @MigrationTableName + ' where pkCPImportFSIS = ' + convert(varchar(18),@pkCPImportFSIS) + ')' + 
		' Where fkCPClient = ' + convert(varchar(18),@fkCPClient) 

	end

	select @SqlString
--	select @CustomValue

	execute(@SqlString)

	Fetch Next From customFields into @MigrationFieldName,@MigrationTableName,@ColumnName,@FriendlyName
	Set @lf = @@Fetch_Status

end

close customFields
deallocate customFields

Return 0







