CREATE PROCEDURE [api].[FindPasswordHash]
	@UserName varchar(50)
AS

SELECT PasswordHash = [Password]
FROM ApplicationUser
WHERE UserName = @UserName