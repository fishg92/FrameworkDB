----------------------------------------------------------------------------
-- Select a single record from NotificationMessage
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspNotificationMessageSelect]
(	@pkNotificationMessage decimal(18, 0) = NULL,
	@fkApplicationUser decimal(18, 0) = NULL,
	@MessageDeliveryType int = NULL,
	@NCPApplicationSource int = NULL,
	@ShowBubbleSeconds int = NULL,
	@MessageText varchar(200) = NULL,
	@CreateDate datetime = NULL,
	@MessageTitle varchar(50) = NULL,
	@LUPUser varchar(50) = NULL,
	@LUPDate datetime = NULL,
	@CreateUser varchar(50) = NULL,
	@fkAssignedBy decimal(18, 0) = NULL,
	@fkTask decimal(18, 0) = NULL,
	@UseToastNotification bit = NULL,
	@ClientNamesList nvarchar(510) = NULL,
	@IsNotificationForAssigningUser bit = NULL
)
AS

SELECT	pkNotificationMessage,
	fkApplicationUser,
	MessageDeliveryType,
	NCPApplicationSource,
	ShowBubbleSeconds,
	MessageText,
	CreateDate,
	MessageTitle,
	LUPUser,
	LUPDate,
	CreateUser,
	fkAssignedBy,
	fkTask,
	UseToastNotification,
	ClientNamesList,
	IsNotificationForAssigningUser
FROM	NotificationMessage
WHERE 	(@pkNotificationMessage IS NULL OR pkNotificationMessage = @pkNotificationMessage)
 AND 	(@fkApplicationUser IS NULL OR fkApplicationUser = @fkApplicationUser)
 AND 	(@MessageDeliveryType IS NULL OR MessageDeliveryType = @MessageDeliveryType)
 AND 	(@NCPApplicationSource IS NULL OR NCPApplicationSource = @NCPApplicationSource)
 AND 	(@ShowBubbleSeconds IS NULL OR ShowBubbleSeconds = @ShowBubbleSeconds)
 AND 	(@MessageText IS NULL OR MessageText LIKE @MessageText + '%')
 AND 	(@CreateDate IS NULL OR CreateDate = @CreateDate)
 AND 	(@MessageTitle IS NULL OR MessageTitle LIKE @MessageTitle + '%')
 AND 	(@LUPUser IS NULL OR LUPUser LIKE @LUPUser + '%')
 AND 	(@LUPDate IS NULL OR LUPDate = @LUPDate)
 AND 	(@CreateUser IS NULL OR CreateUser LIKE @CreateUser + '%')
 AND 	(@fkAssignedBy IS NULL OR fkAssignedBy = @fkAssignedBy)
 AND 	(@fkTask IS NULL OR fkTask = @fkTask)
 AND 	(@UseToastNotification IS NULL OR UseToastNotification = @UseToastNotification)
 AND 	(@ClientNamesList IS NULL OR ClientNamesList LIKE @ClientNamesList + '%')
 AND 	(@IsNotificationForAssigningUser IS NULL OR IsNotificationForAssigningUser = @IsNotificationForAssigningUser)

