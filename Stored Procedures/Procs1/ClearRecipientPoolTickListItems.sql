

CREATE proc [dbo].[ClearRecipientPoolTickListItems]
(
	@pkRecipientPool decimal(18,0)
   	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
)

as

exec dbo.SetAuditDataContext @LupUser, @LupMachine

delete JoinRecipientPoolTickListItem
where fkRecipientPool = @pkRecipientPool
