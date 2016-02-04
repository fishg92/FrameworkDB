CREATE PROCEDURE [dbo].[LockRecipientPool]
(	
	@pkRecipientPool decimal(18, 0) = null
	, @fkLockApplicationUser decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS

	exec dbo.SetAuditDataContext @LupUser, @LupMachine

	Update RecipientPool
	Set fkLockApplicationUser = @fkLockApplicationUser
		, LockDate = getdate()
	Where pkRecipientPool = @pkRecipientPool
