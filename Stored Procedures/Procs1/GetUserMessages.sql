/*
getusermessages 1

*/
CREATE proc [dbo].[GetUserMessages]
	@pkApplicationUser decimal
as

select	pkNotificationMessage
		,fkApplicationUser
		,MessageDeliveryType
		,NCPApplicationSource
		,ShowBubbleSeconds
		,MessageText
		,CreateDate
		,MessageTitle
		,fkAssignedBy
		,fkTask
		,UseToastNotification
		,ClientNamesList
		,IsNotificationForAssigningUser
from	NotificationMessage
where	(fkApplicationUser = @pkApplicationUser
and		IsNotificationForAssigningUser = 0)
or		(fkAssignedBy = @pkApplicationUser
and		IsNotificationForAssigningUser = 1)

select	pkNotificationMessageAction
		,fkNotificationMessage
		,ActionKey
		,ActionValue
from	NotificationMessageAction a
join NotificationMessage m
	on a.fkNotificationMessage = m.pkNotificationMessage
where	(m.fkApplicationUser = @pkApplicationUser
and		m.IsNotificationForAssigningUser = 0)
or		(m.fkAssignedBy = @pkApplicationUser
and		m.IsNotificationForAssigningUser = 1)