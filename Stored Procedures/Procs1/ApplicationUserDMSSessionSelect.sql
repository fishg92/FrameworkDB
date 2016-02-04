create proc ApplicationUserDMSSessionSelect
	@pkApplicationUser decimal
as

select	SessionID
		,SessionOpenTime
from	ApplicationUserDMSSession
where	fkApplicationUser = @pkApplicationUser
