CREATE PROCEDURE [dbo].[GetRecipientPoolLockingInformation]
(	
	@pkRecipientPool decimal(18, 0) = null
)
AS



SELECT	 isnull(Lockdate, '1/1/1900') LockDate
		, isnull(FirstName + ' ' + LastName,'') LockUser
FROM	RecipientPool
left join ApplicationUser  on RecipientPool.fkLockApplicationUser = ApplicationUser.pkapplicationuser
where pkRecipientPool = @pkRecipientPool
