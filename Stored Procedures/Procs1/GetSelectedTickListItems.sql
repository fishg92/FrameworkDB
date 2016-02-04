
CREATE PROC [dbo].[GetSelectedTickListItems]

AS

select	pkJoinRecipientPoolTickListItem as TickListItemId,
		fkRecipientPool as RecipientPoolId,
		fkApplicationUser as UserId,
		TickListIndex,
		Selected
 from JoinRecipientPoolTickListItem where Selected > 0
 order by RecipientPoolId
