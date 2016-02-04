----------------------------------------------------------------------------
-- Update a single record in ColumnNameFriendlyNameMapping
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspColumnNameFriendlyNameMappingUpdate]
(	  @pkColumnNameFriendlyNameMapping decimal(18, 0)
	, @TableName varchar(200) = NULL
	, @ColumnName varchar(200) = NULL
	, @FriendlyName varchar(200) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	ColumnNameFriendlyNameMapping
SET	TableName = ISNULL(@TableName, TableName),
	ColumnName = ISNULL(@ColumnName, ColumnName),
	FriendlyName = ISNULL(@FriendlyName, FriendlyName)
WHERE 	pkColumnNameFriendlyNameMapping = @pkColumnNameFriendlyNameMapping
