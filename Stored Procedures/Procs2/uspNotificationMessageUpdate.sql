----------------------------------------------------------------------------
-- Update a single record in NotificationMessage
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspNotificationMessageUpdate]
(	  @pkNotificationMessage decimal(18, 0)
	, @fkApplicationUser decimal(18, 0) = NULL
	, @MessageDeliveryType int = NULL
	, @NCPApplicationSource int = NULL
	, @ShowBubbleSeconds int = NULL
	, @MessageText varchar(200) = NULL
	, @MessageTitle varchar(50) = NULL
	, @fkAssignedBy decimal(18, 0) = NULL
	, @fkTask decimal(18, 0) = NULL
	, @UseToastNotification bit = NULL
	, @ClientNamesList nvarchar(510) = NULL
	, @IsNotificationForAssigningUser bit = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	NotificationMessage
SET	fkApplicationUser = ISNULL(@fkApplicationUser, fkApplicationUser),
	MessageDeliveryType = ISNULL(@MessageDeliveryType, MessageDeliveryType),
	NCPApplicationSource = ISNULL(@NCPApplicationSource, NCPApplicationSource),
	ShowBubbleSeconds = ISNULL(@ShowBubbleSeconds, ShowBubbleSeconds),
	MessageText = ISNULL(@MessageText, MessageText),
	MessageTitle = ISNULL(@MessageTitle, MessageTitle),
	fkAssignedBy = ISNULL(@fkAssignedBy, fkAssignedBy),
	fkTask = ISNULL(@fkTask, fkTask),
	UseToastNotification = ISNULL(@UseToastNotification, UseToastNotification),
	ClientNamesList = ISNULL(@ClientNamesList, ClientNamesList),
	IsNotificationForAssigningUser = ISNULL(@IsNotificationForAssigningUser, IsNotificationForAssigningUser)
WHERE 	pkNotificationMessage = @pkNotificationMessage
