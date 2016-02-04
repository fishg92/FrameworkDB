CREATE PROCEDURE [dbo].[UnLockRecipientPool]
(	
	@pkRecipientPool decimal(18, 0) = null
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS

	exec dbo.SetAuditDataContext @LupUser, @LupMachine

	If @pkRecipientPool = -1 --unlock all pools locked more than 5 minutes
	begin 
		if exists(Select * from RecipientPool where datediff(mi,lockdate,getdate()) > 5)
		begin 
			Update RecipientPool
			Set fkLockApplicationUser = null
				, LockDate = null
			Where pkRecipientPool in (Select pkRecipientPool from RecipientPool where datediff(mi,lockdate,getdate()) > 5)
		end
	end
	else
	begin
		Update RecipientPool
		Set fkLockApplicationUser = null
			, LockDate = null
		Where pkRecipientPool = @pkRecipientPool
	end
