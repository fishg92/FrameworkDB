



CREATE     Proc [dbo].[spCPInsertUpdateCPJoinClientClientCase]
(	
	@fkCPClientCase decimal(18,0),
	@fkCPClient decimal(18,0),
	@PrimaryParticipantOnCase bit,
	@LockedUser varchar(50) = Null,
	@LockedDate datetime = Null,
	@fkCPRefClientRelationshipType decimal(18,0) = null,
	@pkCPJoinClientClientCase decimal(18,0) output
)
as

/* If this case already has a primary participant assigned then we need to dethrone it */
If @PrimaryParticipantOnCase = 1 
begin
	If Exists(	Select 	pkCPJoinClientClientCase
			From	CPJoinClientClientCase
			Where	fkCPClientCase = @fkCPClientCase
			and	PrimaryParticipantOnCase = 1)
	begin
		Update 	CPJoinClientClientCase
		Set	
			PrimaryParticipantOnCase = 0
		Where	fkCPClientCase = @fkCPClientCase
	end
end

If IsNull(@pkCPJoinClientClientCase,0) = 0
begin

	INSERT INTO CPJoinClientClientCase
	(	
		fkCPClientCase, 
		fkCPClient, 
		PrimaryParticipantOnCase, 
		fkCPRefClientRelationshipType,
		LockedUser, 
		LockedDate)
	VALUES     
	(	
		@fkCPClientCase,
		@fkCPClient,
		@PrimaryParticipantOnCase,
		@fkCPRefClientRelationshipType,
		@LockedUser,
		@LockedDate)
	
	Set @pkCPJoinClientClientCase = Scope_Identity()

end
Else
begin
	if not exists(select * 
		      from CPJoinClientClientCase
		      where fkCPClientCase = @fkCPClientCase 
		      and fkCPClient = @fkCPClient 
		      and pkCPJoinClientClientCase = @pkCPJoinClientClientCase
	          and PrimaryParticipantOnCase = @PrimaryParticipantOnCase
	          and fkCPRefClientRelationshipType = @fkCPRefClientRelationshipType 
		     )

	begin
		Update	CPJoinClientClientCase
		Set	
			fkCPClientCase = @fkCPClientCase, 
			fkCPClient = @fkCPClient, 
			PrimaryParticipantOnCase = @PrimaryParticipantOnCase, 
			fkCPRefClientRelationshipType = @fkCPRefClientRelationshipType,
			LockedUser = @LockedUser, 
			LockedDate = @LockedDate
		Where	pkCPJoinClientClientCase = @pkCPJoinClientClientCase
	end

end




