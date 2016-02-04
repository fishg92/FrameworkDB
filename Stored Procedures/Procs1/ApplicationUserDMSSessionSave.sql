CREATE proc [dbo].[ApplicationUserDMSSessionSave]
	@pkApplicationUser decimal
	,@SessionID varchar(50)
	,@SessionOpenTime datetime
	,@ExistingSessionID varchar(50) output
as


select @ExistingSessionID = SessionID
from	ApplicationUserDMSSession
where	fkApplicationUser = @pkApplicationUser

set @ExistingSessionID = isnull(@ExistingSessionID,'')

--update	ApplicationUserDMSSession
--set		SessionID = @SessionID
--		,SessionOpenTime = @SessionOpenTime
--where	fkApplicationUser = @pkApplicationUser

if @ExistingSessionID = ''
	begin
	insert	ApplicationUserDMSSession
		(
			fkApplicationUser
			,SessionID
			,SessionOpenTime
		)
	values
		(
			@pkApplicationUser
			,@SessionID
			,@SessionOpenTime
		)
	end
	
