

CREATE   Proc [dbo].[spCPInsertUpdateCPJoinClientClientAddress]
(	
	@fkCPClient decimal(18,0),
	@fkCPClientAddress decimal(18,0),
	@LockedUser varchar(50) = Null,
	@LockedDate datetime = Null, 
	@pkCPJoinClientClientAddress decimal(18,0) output
)
as

If IsNull(@pkCPJoinClientClientAddress,0) = 0 
begin
	
	INSERT INTO CPJoinClientClientAddress
	(	 
		fkCPClient, 
		fkCPClientAddress, 
		LockedUser, 
		LockedDate)
	VALUES     
	(	
		@fkCPClient,
		@fkCPClientAddress,
		@LockedUser,
		@LockedDate)
	
	Set @pkCPJoinClientClientAddress = Scope_Identity()

end
Else
begin
	if not exists(select * 
		      from CPJoinClientClientAddress
		      where pkCPJoinClientClientAddress = @pkCPJoinClientClientAddress
		      and fkCPClient = @fkCPClient
		      and fkCPClientAddress = @fkCPClientAddress
		     )
		begin
			Update	CPJoinClientClientAddress
			Set	 
				fkCPClient = @fkCPClient, 
				fkCPClientAddress = @fkCPClientAddress, 
				LockedUser = @LockedUser, 
				LockedDate = @LockedDate
			Where	pkCPJoinClientClientAddress = @pkCPJoinClientClientAddress
		end
end



