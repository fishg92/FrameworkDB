


CREATE PROC [dbo].[GetRecipientPoolList]
(	
	@fkApplicationUser decimal(18, 0) = null
)
AS

SELECT	distinct pkRecipientPool
		,Name	
FROM	RecipientPool
where pkRecipientPool in 
(select fkRecipientPool from JoinrecipientPoolManager j 
where fkApplicationUser =  ISNULL(@fkApplicationUser,fkApplicationUser))
or @fkApplicationUser is null

order by Name

