----------------------------------------------------------------------------
-- Select a single record from NotificationMessageAction
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspNotificationMessageActionSelect]
(	@pkNotificationMessageAction decimal(18, 0) = NULL,
	@fkNotificationMessage decimal(18, 0) = NULL,
	@ActionKey varchar(255) = NULL,
	@ActionValue varchar(255) = NULL	
)
AS

SELECT	pkNotificationMessageAction,
	fkNotificationMessage,
	ActionKey,
	ActionValue
FROM	NotificationMessageAction
WHERE 	(@pkNotificationMessageAction IS NULL OR pkNotificationMessageAction = @pkNotificationMessageAction)
 AND 	(@fkNotificationMessage IS NULL OR fkNotificationMessage = @fkNotificationMessage)
 AND 	(@ActionKey IS NULL OR ActionKey LIKE @ActionKey + '%')
 AND 	(@ActionValue IS NULL OR ActionValue LIKE @ActionValue + '%')
 