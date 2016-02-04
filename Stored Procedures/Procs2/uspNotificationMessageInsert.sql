----------------------------------------------------------------------------
-- Insert a single record into NotificationMessage
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspNotificationMessageInsert]
(	  @fkApplicationUser decimal(18, 0)
	, @MessageDeliveryType int = NULL
	, @NCPApplicationSource int = NULL
	, @ShowBubbleSeconds int = NULL
	, @MessageText varchar(200) = NULL
	, @MessageTitle varchar(50)
	, @fkAssignedBy decimal(18, 0) = NULL
	, @fkTask decimal(18, 0) = NULL
	, @UseToastNotification bit = NULL
	, @ClientNamesList nvarchar(510) = NULL
	, @IsNotificationForAssigningUser bit = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkNotificationMessage decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT NotificationMessage
(	  fkApplicationUser
	, MessageDeliveryType
	, NCPApplicationSource
	, ShowBubbleSeconds
	, MessageText
	, MessageTitle
	, fkAssignedBy
	, fkTask
	, UseToastNotification
	, ClientNamesList
	, IsNotificationForAssigningUser
)
VALUES 
(	  @fkApplicationUser
	, COALESCE(@MessageDeliveryType, (2))
	, COALESCE(@NCPApplicationSource, (-1))
	, COALESCE(@ShowBubbleSeconds, (-1))
	, COALESCE(@MessageText, '')
	, @MessageTitle
	, COALESCE(@fkAssignedBy, (0))
	, COALESCE(@fkTask, (0))
	, COALESCE(@UseToastNotification, (0))
	, COALESCE(@ClientNamesList, '')
	, COALESCE(@IsNotificationForAssigningUser, (0))

)

SET @pkNotificationMessage = SCOPE_IDENTITY()
