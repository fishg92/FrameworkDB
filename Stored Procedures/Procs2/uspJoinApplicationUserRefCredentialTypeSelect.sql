----------------------------------------------------------------------------
-- Select a single record from JoinApplicationUserRefCredentialType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinApplicationUserRefCredentialTypeSelect]
(	@pkJoinApplicationUserRefCredentialType decimal(18, 0) = NULL,
	@fkApplicationUser decimal(18, 0) = NULL,
	@fkRefCredentialType decimal(18, 0) = NULL,
	@UserName varchar(50) = NULL,
	@Password varchar(200) = NULL
)
AS

SELECT	pkJoinApplicationUserRefCredentialType,
	fkApplicationUser,
	fkRefCredentialType,
	UserName,
	Password
FROM	JoinApplicationUserRefCredentialType
WHERE 	(@pkJoinApplicationUserRefCredentialType IS NULL OR pkJoinApplicationUserRefCredentialType = @pkJoinApplicationUserRefCredentialType)
 AND 	(@fkApplicationUser IS NULL OR fkApplicationUser = @fkApplicationUser)
 AND 	(@fkRefCredentialType IS NULL OR fkRefCredentialType = @fkRefCredentialType)
 AND 	(@UserName IS NULL OR UserName LIKE @UserName + '%')
 AND 	(@Password IS NULL OR Password LIKE @Password + '%')
