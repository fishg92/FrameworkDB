CREATE PROCEDURE [api].[DeleteUser]
	 @UserName varchar(50)
	,@LUPUser varchar(50)
AS

EXEC dbo.SetAuditDataContext @AuditUser = @LUPUser, @AuditMachine = 'WebAPI'

UPDATE ApplicationUser
SET IsActive = 0
WHERE UserName = @UserName