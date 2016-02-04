
CREATE PROC [dbo].[SetSelectedTickListItem]
(
	 @pkSetSelectedTickListItem decimal(18, 0)
)
AS

declare @poolId decimal
select @poolId =  (select distinct fkrecipientpool 
					from JoinRecipientPoolTickListItem 
					where pkJoinRecipientPoolTickListItem = @pkSetSelectedTickListItem)

Update JoinRecipientPoolTickListItem
Set Selected = 0
Where pkJoinRecipientPoolTickListItem in (Select pkJoinRecipientPoolTickListItem 
										from JoinRecipientPoolTickListItem 
										where fkRecipientPool = @poolId)

Update JoinRecipientPoolTickListItem
Set Selected = 1
where pkJoinRecipientPoolTickListItem = @pkSetSelectedTickListItem
