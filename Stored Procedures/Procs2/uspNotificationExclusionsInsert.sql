----------------------------------------------------------------------------
-- Insert a single record into NotificationExclusions
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspNotificationExclusionsInsert]
(	  @TableName varchar(100)
	, @fkApplicationUser int
	, @fkType int
	, @TypePkName varchar(50)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkNotificationExclusions int = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT NotificationExclusions
(	  TableName
	, fkApplicationUser
	, fkType
	, TypePkName
)
VALUES 
(	  @TableName
	, @fkApplicationUser
	, @fkType
	, @TypePkName

)

SET @pkNotificationExclusions = SCOPE_IDENTITY()
