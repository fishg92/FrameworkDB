
CREATE   Proc [dbo].[spCPInsertUpdateCPJoinClientEmployer]
(	
	@fkCPClient decimal(18,0),
	@fkCPEmployer decimal(18,0),
	@StartDate datetime, 
	@EndDate datetime = Null,
	@LockedUser varchar(50) = Null,
	@LockedDate datetime = Null,
	@pkCPJoinClientEmployer decimal(18,0) output
)
as


If IsNull(@pkCPJoinClientEmployer,0) = 0
begin

	INSERT INTO CPJoinClientEmployer
	(	 
		fkCPEmployer, 
		fkCPClient, 
		StartDate,
		EndDate,
		LockedUser, 
		LockedDate)
	VALUES     
	(	
		@fkCPEmployer,
		@fkCPClient,
		@StartDate,
		@EndDate,
		@LockedUser,
		@LockedDate)
	
	Set @pkCPJoinClientEmployer = Scope_Identity()

end
Else
begin

	Update	CPJoinClientEmployer
	Set	
		fkCPEmployer = @fkCPEmployer, 
		fkCPClient = @fkCPClient, 
		StartDate = @StartDate,
		EndDate = @EndDate,
		LockedUser = @LockedUser, 
		LockedDate = @LockedDate
	Where	pkCPJoinClientEmployer = @pkCPJoinClientEmployer

end