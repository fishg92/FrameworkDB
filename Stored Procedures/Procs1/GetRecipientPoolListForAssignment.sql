


CREATE PROC [dbo].[GetRecipientPoolListForAssignment]

AS

SELECT	distinct pkRecipientPool
		,Name	
FROM	RecipientPool
where pkRecipientPool in 
(select fkRecipientPool from JoinRecipientPoolTickListItem)

order by Name