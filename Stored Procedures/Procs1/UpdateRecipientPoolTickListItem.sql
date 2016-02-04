


CREATE proc [dbo].[UpdateRecipientPoolTickListItem]
(
	  @pkJoinRecipientPoolTickListItem decimal(18,0)
	, @TickListIndex int
   	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
)

as


exec dbo.SetAuditDataContext @LupUser, @LupMachine

update JoinRecipientPoolTickListItem
set TickListIndex = @TickListIndex
where pkJoinRecipientPoolTickListItem = @pkJoinRecipientPoolTickListItem
