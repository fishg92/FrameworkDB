----------------------------------------------------------------------------
-- Insert a single record into NotificationMessageAction
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspNotificationMessageActionInsert]
(	  @fkNotificationMessage decimal(18, 0)
	, @ActionKey varchar(255)
	, @ActionValue varchar(255)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkNotificationMessageAction decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT NotificationMessageAction
(	  fkNotificationMessage
	, ActionKey
	, ActionValue
)
VALUES 
(	  @fkNotificationMessage
	, @ActionKey
	, @ActionValue

)

SET @pkNotificationMessageAction = SCOPE_IDENTITY()
