CREATE proc [dbo].[GetUsersWithMessagesList]
as

select	distinct fkApplicationUser
from	NotificationMessage
where IsNotificationForAssigningUser = 0

union

select distinct fkAssignedBy
from NotificationMessage
where IsNotificationForAssigningUser = 1
