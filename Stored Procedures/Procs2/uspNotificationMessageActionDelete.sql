----------------------------------------------------------------------------
-- Delete a single record from NotificationMessageAction
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspNotificationMessageActionDelete]
(	@pkNotificationMessageAction decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	NotificationMessageAction
WHERE 	pkNotificationMessageAction = @pkNotificationMessageAction
