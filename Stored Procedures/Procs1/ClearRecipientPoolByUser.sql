
CREATE PROC [dbo].[ClearRecipientPoolByUser]
(
	 @pkApplicationUser decimal(18, 0),
	 @pkRecipientPool decimal(18, 0)
)
AS

declare @canRunTasksPermission decimal
set @canRunTasksPermission = 44

if(dbo.UserHasPermission(@pkApplicationUser, @canRunTasksPermission) <> 1)
BEGIN
	
	delete [JoinRecipientPoolManager]
	where fkApplicationUser = @pkApplicationUser
	  AND fkRecipientPool = @pkRecipientPool

	delete [JoinRecipientPoolMember]
	where fkApplicationUser = @pkApplicationUser
	  AND fkRecipientPool = @pkRecipientPool

	delete [JoinRecipientPoolTickListItem]
	where fkApplicationUser = @pkApplicationUser
	  AND fkRecipientPool = @pkRecipientPool

END
