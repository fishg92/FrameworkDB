----------------------------------------------------------------------------
-- Select a single record from NotificationExclusions
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspNotificationExclusionsSelect]
(	@pkNotificationExclusions int = NULL,
	@TableName varchar(100) = NULL,
	@fkApplicationUser int = NULL,
	@fkType int = NULL,
	@TypePkName varchar(50) = NULL
)
AS

SELECT	pkNotificationExclusions,
	TableName,
	fkApplicationUser,
	fkType,
	TypePkName
FROM	NotificationExclusions
WHERE 	(@pkNotificationExclusions IS NULL OR pkNotificationExclusions = @pkNotificationExclusions)
 AND 	(@TableName IS NULL OR TableName LIKE @TableName + '%')
 AND 	(@fkApplicationUser IS NULL OR fkApplicationUser = @fkApplicationUser)
 AND 	(@fkType IS NULL OR fkType = @fkType)
 AND 	(@TypePkName IS NULL OR TypePkName LIKE @TypePkName + '%')
