----------------------------------------------------------------------------
-- Select a single record from ColumnNameFriendlyNameMapping
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspColumnNameFriendlyNameMappingSelect]
(	@pkColumnNameFriendlyNameMapping decimal(18, 0) = NULL,
	@TableName varchar(200) = NULL,
	@ColumnName varchar(200) = NULL,
	@FriendlyName varchar(200) = NULL
)
AS

SELECT	pkColumnNameFriendlyNameMapping,
	TableName,
	ColumnName,
	FriendlyName
FROM	ColumnNameFriendlyNameMapping
WHERE 	(@pkColumnNameFriendlyNameMapping IS NULL OR pkColumnNameFriendlyNameMapping = @pkColumnNameFriendlyNameMapping)
 AND 	(@TableName IS NULL OR TableName LIKE @TableName + '%')
 AND 	(@ColumnName IS NULL OR ColumnName LIKE @ColumnName + '%')
 AND 	(@FriendlyName IS NULL OR FriendlyName LIKE @FriendlyName + '%')

