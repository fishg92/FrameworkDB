CREATE proc [dbo].[GetExternalCredentials]
	@fkApplicationUser decimal
	,@fkrefCredentialType decimal
	,@UserName varchar(50) output
	,@Password varchar(200) output
as

select	@UserName = UserName
		,@Password = Password
from	JoinApplicationUserrefCredentialType
where	fkApplicationUser = @fkApplicationUser
and		fkrefCredentialType = @fkrefCredentialType

set @UserName = isnull(@UserName,'')
set @Password = isnull(@Password,'')
