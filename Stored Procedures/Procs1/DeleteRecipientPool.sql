
CREATE PROC [dbo].[DeleteRecipientPool]
(	@pkRecipientPool decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

Delete JoinRecipientPoolMember
where fkRecipientPool = @pkRecipientPool

Delete JoinRecipientPoolManager
where fkRecipientPool = @pkRecipientPool

Delete JoinRecipientPoolTickListItem
where fkRecipientPool = @pkRecipientPool
	
DELETE	RecipientPool
WHERE 	pkRecipientPool = @pkRecipientPool
