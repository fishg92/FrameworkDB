

--[usp_ValidateToken] '9d164a70-24be-4279-909c-18b801780848-a3e949ef-521a-4847-b849-04baa230ae60'
/*

exec dbo.usp_ValidateToken 
	@AuthToken=N'9087243c-df96-4f06-b605-114316ec7e02-e336151c-b34f-426c-a7e7-4c837cdcc56c'
	,@LUPUser=196
	,@LUPMAC=N'0019B92FEF0D'
	,@LUPIP=N'10.1.4.214'
	,@LUPMachine=N'STEVESHERER'

select * from logging	
delete logging

Security Threat Detected. Invalid authentication token value '087243c-df96-4f06-b605-114316ec7e02-e336151c-b34f-426c-a7e7-4c837cdcc56c' was attempted to be used to validate an active session
	
select keepalive
from publicauthenticatedsession
where authenticationtoken='9087243c-df96-4f06-b605-114316ec7e02-e336151c-b34f-426c-a7e7-4c837cdcc56c'

*/
CREATE PROC [dbo].[usp_ValidateToken]
(@AuthToken as varchar(75)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
As
declare @Result as tinyint
set @Result = 0

if @AuthToken like '[0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z]-[0-9a-z][0-9a-z][0-9a-z][0-9a-z]-[0-9a-z][0-9a-z][0-9a-z][0-9a-z]-[0-9a-z][0-9a-z][0-9a-z][0-9a-z]-[0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z]-[0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z]-[0-9a-z][0-9a-z][0-9a-z][0-9a-z]-[0-9a-z][0-9a-z][0-9a-z][0-9a-z]-[0-9a-z][0-9a-z][0-9a-z][0-9a-z]-[0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z]'
	BEGIN
		update	PublicAuthenticatedSession
		set		KeepAlive = getdate()
		where	AuthenticationToken = @AuthToken
		
		if @@rowcount > 0
			set @result = 1
	END
else
	begin
	/* If an invalid token is attempted to be passed, make an entry in the logging table */
	declare @AssociateWith varchar(50)
			,@Message varchar(255)
			,@currentDate datetime
					
	if isnumeric(@LUPUser) = 1
		begin
		select	@AssociateWith = UserName
		from	ApplicationUser
		where	pkApplicationUser = @LUPUser
		end
	
	
	set @currentDate = getdate()
	set @Message = 'Security Threat Detected. Invalid authentication token value ''' + @AuthToken + ''' was attempted to be used to validate an active session'
	
	set @AssociateWith = coalesce(@AssociateWith, @LUPUser, 'Unknown')

	exec dbo.usp_LogEntry
		@Source = 'Compass Security Threat'
		,@ApplicationID = -1
		,@EntryType = 'CriticalError'
		,@Message = @Message
		,@AssociateWith = @AssociateWith
		,@CreateUser = @LUPUser
	end


select @Result