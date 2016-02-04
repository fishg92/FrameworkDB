
CREATE  proc [dbo].[spCPInsertUpdateCPClientCase]
(	
	@StateCaseNumber varchar(20),
	@LocalCaseNumber varchar(20),
	@fkCPRefClientCaseProgramType decimal(18,0),
	@fkCPCaseWorker decimal(18,0),
	@LockedUser varchar(50) = Null,
	@LockedDate datetime = Null,
	@pkCPClientCase decimal(18,0) output
)
as

If IsNull(@pkCPClientCase,0) = 0 
begin
	
	INSERT INTO CPClientCase
	(	
		StateCaseNumber, 
		LocalCaseNumber, 
		fkCPRefClientCaseProgramType, 
		fkCPCaseWorker, 
		LockedUser, 
		LockedDate)
	VALUES     
	(	
		@StateCaseNumber,
		@LocalCaseNumber,
		@fkCPRefClientCaseProgramType,
		@fkCPCaseWorker,
		@LockedUser,
		@LockedDate)
	
	Set @pkCPClientCase = Scope_Identity()

end
Else
begin

	Update	CPClientCase
	Set	
		StateCaseNumber = @StateCaseNumber, 
		LocalCaseNumber = @LocalCaseNumber, 
		fkCPRefClientCaseProgramType = @fkCPRefClientCaseProgramType, 
		fkCPCaseWorker = @fkCPCaseWorker, 
		LockedUser = @LockedUser, 
		LockedDate = @LockedDate
	Where	pkCPClientCase = @pkCPClientCase

end

