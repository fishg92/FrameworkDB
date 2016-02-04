CREATE PROCEDURE [api].[SetPasswordHash]
	 @UserName varchar(50)
	,@PasswordHash varchar(100)
	,@LUPUser varchar(50) = '0'
AS

EXEC dbo.SetAuditDataContext @AuditUser = @LUPUser, @AuditMachine = 'WebAPI'

UPDATE ApplicationUser
SET [Password] = @PasswordHash
WHERE UserName = @UserName