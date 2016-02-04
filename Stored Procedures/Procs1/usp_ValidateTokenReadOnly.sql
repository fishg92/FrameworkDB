
--[usp_ValidateToken] '9d164a70-24be-4279-909c-18b801780848-a3e949ef-521a-4847-b849-04baa230ae60'


CREATE PROC [dbo].[usp_ValidateTokenReadOnly]
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
	begin

	if exists 
	/* only using this for Benefit Bank installations until PCR 8771 has been worked */
		(select * from NCPApplication where pkNCPApplication= 18
			and Registered = 1 and ShowInMenu = 1) BEGIN
				if exists
					(select * from dbo.PublicAuthenticatedSession where 
						AuthenticationToken = @AuthToken
								and datediff(mi,KeepAlive,getdate()) < dbo.[fnGetNumericConfigurationValue]('PublicSessionTimeoutInMinutes',-1,720)) 
						BEGIN
							set @Result = 1			
						END
	END ELSE BEGIN
				if exists
								(select * from dbo.PublicAuthenticatedSession where 
									AuthenticationToken = @AuthToken)
									--not doing timeouts until PCR 8771
									--and datediff(mi,KeepAlive,getdate()) < dbo.[fnGetNumericConfigurationValue]('PublicSessionTimeoutInMinutes',-1,720)) 
							BEGIN
								set @Result = 1			
							END

		
	END
	end
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
		,@EntryType = 'Warning'
		,@Message = @Message
		,@AssociateWith = @AssociateWith
		,@CreateUser = @LUPUser
	end

	

select @Result