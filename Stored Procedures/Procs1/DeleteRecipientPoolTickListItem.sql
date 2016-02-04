



CREATE proc [dbo].[DeleteRecipientPoolTickListItem]
(
	  @pkJoinRecipientPoolTickListItem decimal(18,0)
   	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
)

as


declare @Selected int
	, @fkPoolID decimal(18,0)
	, @TickLIstIndex int
	, @return_value int


exec dbo.SetAuditDataContext @LupUser, @LupMachine

select @Selected = selected ,@fkPoolID = fkRecipientPool, @TickLIstIndex = TickListIndex
from JoinRecipientPoolTickListItem
where pkJoinRecipientPoolTickListItem = @pkJoinRecipientPoolTickListItem

if ( @Selected = 1 )
begin

	
	EXEC	@return_value = [dbo].[GetPreviousUserFromRecipientPoolTickList]
	@pkRecipientPool = @fkPoolID
	
	
end


delete JoinRecipientPoolTickListItem
where pkJoinRecipientPoolTickListItem = @pkJoinRecipientPoolTickListItem
