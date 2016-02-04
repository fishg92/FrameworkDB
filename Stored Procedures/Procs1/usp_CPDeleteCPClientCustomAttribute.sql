
CREATE PROC [dbo].[usp_CPDeleteCPClientCustomAttribute]
(	@pkColumnNameFriendlyNameMapping decimal (18,0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
)  
AS

Declare @ColumnName varchar (300) 
Declare @TableName varchar (300)

Set @ColumnName = (Select ColumnName from dbo.ColumnNameFriendlyNameMapping (nolock) 
where pkColumnNameFriendlyNameMapping = @pkColumnNameFriendlyNameMapping)

Set @TableName = (Select TableName from dbo.ColumnNameFriendlyNameMapping (nolock) 
where pkColumnNameFriendlyNameMapping = @pkColumnNameFriendlyNameMapping)

Declare @DefaultFriendlyName as Varchar (50)
Set @DefaultFriendlyName = Replace(@ColumnName, 'DATA', 'Field ') 


exec dbo.SetAuditDataContext @LupUser, @LupMachine

Declare @SQL Varchar (1000)

Select @SQL = ('Update dbo.CPClientCustomAttribute Set ' + @ColumnName + ' = '''' where ' + @ColumnName + ' <> ''''' )
exec (@SQL)


exec dbo.SetAuditDataContext @LupUser, @LupMachine

Update dbo.ColumnNameFriendlyNameMapping
set FriendlyName = @DefaultFriendlyName
where TableName = @TableName
and ColumnName = @ColumnName


exec dbo.SetAuditDataContext @LupUser, @LupMachine

Delete from dbo.ProgramTypeClientCustomAttributeColumnMapping
where ClientCustomAttributeColumn = @ColumnName
