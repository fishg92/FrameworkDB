----------------------------------------------------------------------------
-- Delete a single record from NotificationExclusions
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspNotificationExclusionsDelete]
(	@pkNotificationExclusions int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	NotificationExclusions
WHERE 	pkNotificationExclusions = @pkNotificationExclusions
