CREATE proc [dbo].[AcknowledgeUserMessage]
	@pkNotificationMessage decimal
as

delete	NotificationMessageAction
where	fkNotificationMessage = @pkNotificationMessage

delete	NotificationMessage
where	pkNotificationMessage = @pkNotificationMessage