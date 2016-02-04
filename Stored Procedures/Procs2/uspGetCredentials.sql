
CREATE PROC [dbo].[uspGetCredentials]
(
	@fkApplicationUser decimal, 
	@fkrefCredentialType decimal
)

AS

select username,
       password,
	   pkJoinApplicationUserRefCredentialType,
	   LUPDate
from dbo.JoinApplicationUserRefCredentialType with (NOLOCK)
where fkApplicationUser = @fkApplicationUser
and fkrefCredentialType = @fkrefCredentialType
