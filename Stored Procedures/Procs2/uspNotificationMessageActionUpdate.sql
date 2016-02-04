----------------------------------------------------------------------------
-- Update a single record in NotificationMessageAction
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspNotificationMessageActionUpdate]
(	  @pkNotificationMessageAction decimal(18, 0)
	, @fkNotificationMessage decimal(18, 0) = NULL
	, @ActionKey varchar(255) = NULL
	, @ActionValue varchar(255) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	NotificationMessageAction
SET	fkNotificationMessage = ISNULL(@fkNotificationMessage, fkNotificationMessage),
	ActionKey = ISNULL(@ActionKey, ActionKey),
	ActionValue = ISNULL(@ActionValue, ActionValue)
WHERE 	pkNotificationMessageAction = @pkNotificationMessageAction
