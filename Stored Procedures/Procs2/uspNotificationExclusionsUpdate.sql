----------------------------------------------------------------------------
-- Update a single record in NotificationExclusions
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspNotificationExclusionsUpdate]
(	  @pkNotificationExclusions int
	, @TableName varchar(100) = NULL
	, @fkApplicationUser int = NULL
	, @fkType int = NULL
	, @TypePkName varchar(50) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	NotificationExclusions
SET	TableName = ISNULL(@TableName, TableName),
	fkApplicationUser = ISNULL(@fkApplicationUser, fkApplicationUser),
	fkType = ISNULL(@fkType, fkType),
	TypePkName = ISNULL(@TypePkName, TypePkName)
WHERE 	pkNotificationExclusions = @pkNotificationExclusions
