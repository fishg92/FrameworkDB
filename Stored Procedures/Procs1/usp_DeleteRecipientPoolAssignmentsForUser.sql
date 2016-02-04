


--exec usp_DeleteRecipientPoolAssignmentsForUser '1'


CREATE      procedure [dbo].[usp_DeleteRecipientPoolAssignmentsForUser]
(	
  @pkApplicationUser decimal
, @LUPUser varchar(50)
, @LUPMac char(17)
, @LUPIP varchar(15)
, @LUPMachine varchar(15)
)
as

exec dbo.SetAuditDataContext @LupUser, @LupMachine

delete from [JoinRecipientPoolManager]
where fkApplicationUser = @pkApplicationUser 

delete from [JoinRecipientPoolMember]
where fkApplicationUser = @pkApplicationUser 


declare @pkTickListItem decimal(18, 0)
declare @tickListItemsByUser cursor
set @tickListItemsByUser = cursor for 
	select pkjoinrecipientpoolticklistitem 
	from dbo.JoinRecipientPoolTickListItem tli 
	where tli.fkApplicationUser = @pkApplicationUser

open @tickListItemsByUser

fetch next
from @tickListItemsByUser
into @pkTickListItem

while @@FETCH_STATUS = 0
BEGIN
 exec [dbo].[DeleteRecipientPoolTickListItem] @pkTickListItem, 
 @LUPUser, @LUPMac, @LUPIP, @LUPMachine
fetch next
from @tickListItemsByUser into @pkTickListItem
end

close @tickListItemsByUser
deallocate @tickListItemsByUser
