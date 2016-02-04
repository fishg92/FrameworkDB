



--GetRecipientPool 1

CREATE PROC [dbo].[GetRecipientPool]
(	
	@pkRecipientPool decimal(18, 0) 
)
AS

SELECT	distinct pkRecipientPool
		,Name	
FROM	RecipientPool
where pkRecipientPool = @pkRecipientPool

Select fkApplicationUser
from JoinRecipientPoolMember
where fkRecipientPool = @pkRecipientPool

Select fkApplicationUser
from JoinRecipientPoolManager
where fkRecipientPool = @pkRecipientPool

Select	fkApplicationUser,
		TickListIndex,
		pkJoinRecipientPoolTickListItem,
		Selected
from JoinRecipientPoolTickListItem
where fkRecipientPool = @pkRecipientPool
order by TickListIndex asc
