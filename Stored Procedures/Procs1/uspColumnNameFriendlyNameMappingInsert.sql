----------------------------------------------------------------------------
-- Insert a single record into ColumnNameFriendlyNameMapping
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspColumnNameFriendlyNameMappingInsert]
(	  @TableName varchar(200)
	, @ColumnName varchar(200)
	, @FriendlyName varchar(200)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkColumnNameFriendlyNameMapping decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT ColumnNameFriendlyNameMapping
(	  TableName
	, ColumnName
	, FriendlyName
)
VALUES 
(	  @TableName
	, @ColumnName
	, @FriendlyName

)

SET @pkColumnNameFriendlyNameMapping = SCOPE_IDENTITY()
