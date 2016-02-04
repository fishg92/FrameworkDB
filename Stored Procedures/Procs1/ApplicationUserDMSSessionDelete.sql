create proc ApplicationUserDMSSessionDelete
	@pkApplicationUser decimal
as

delete	ApplicationUserDMSSession
where	fkApplicationUser = @pkApplicationUser
