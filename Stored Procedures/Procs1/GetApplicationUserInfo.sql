CREATE proc GetApplicationUserInfo
	@pkApplicationUser decimal
	,@UserName varchar(50) = null output
	,@FirstName varchar(50) = null output
	,@LastName varchar(50) = null output
	,@Password varchar(100) = null output
	,@fkDepartment decimal = null output
	,@WorkerNumber varchar(50) = null output
	,@LDAPUser bit = null output
as

select	@UserName = UserName
		,@FirstName = FirstName
		,@LastName = LastName
		,@Password = [Password]
		,@fkDepartment = isnull(fkDepartment,-1)
		,@WorkerNumber = isnull(WorkerNumber,'')
		,@LDAPUser = isnull(LDAPUser,0)
from ApplicationUser
where pkApplicationUser = @pkApplicationUser

set @UserName = isnull(@UserName,'')
set @FirstName = isnull(@FirstName,'')
set @LastName = isnull(@LastName,'')
set @Password = isnull(@Password,'')
set @fkDepartment = isnull(@fkDepartment,-1)
set @WorkerNumber = isnull(@WorkerNumber,'')
set @LDAPUser = isnull(@LDAPUser,'')

