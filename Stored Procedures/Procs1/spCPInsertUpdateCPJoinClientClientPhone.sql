

CREATE   Proc [dbo].[spCPInsertUpdateCPJoinClientClientPhone]
(
	
	@fkCPClient decimal(18,0), 
	@fkCPClientPhone decimal(18,0), 
	@LockedUser varchar(50) = Null, 
	@LockedDate datetime = Null,
	@pkCPJoinClientClientPhone decimal(18,0) output
)
as

If IsNull(@pkCPJoinClientClientPhone,0) = 0 
begin
	
	INSERT INTO CPJoinClientClientPhone
	(	
		fkCPClient, 
		fkCPClientPhone, 
		LockedUser, 
		LockedDate)
	VALUES     
	(	 
		@fkCPClient, 
		@fkCPClientPhone, 
		@LockedUser, 
		@LockedDate)
	
	Set @pkCPJoinClientClientPhone = Scope_Identity()

end
Else
begin

	Update 	CPJoinClientClientPhone
	Set	
		fkCPClient = @fkCPClient, 
		fkCPClientPhone = @fkCPClientPhone, 
		LockedUser = @LockedUser, 
		LockedDate = @LockedDate
	Where	pkCPJoinClientClientPhone = @pkCPJoinClientClientPhone
end


