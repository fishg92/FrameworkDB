
CREATE   Proc [dbo].[spCPInsertUpdateCPClientMilitaryRecord]
(	
	@fkCPClient decimal(18, 0),
	@fkCPRefMilitaryBranch decimal(18, 0),
	@StartDate datetime,
	@EndDate datetime = Null,
	@DishonorablyDischarged bit,
	@LockedUser varchar(50) = Null,
	@LockedDate datetime = Null,
	@pkCPClientMilitaryRecord decimal(18,0) output
)
as


If IsNull(@pkCPClientMilitaryRecord,0) = 0
begin

	INSERT INTO CPClientMilitaryRecord
	(	
		fkCPClient, 
		fkCPRefMilitaryBranch,
		StartDate ,
		EndDate,
		DishonorablyDischarged,
		LockedUser, 
		LockedDate)
	VALUES     
	(	
		@fkCPClient,
		@fkCPRefMilitaryBranch,
		@StartDate,
		@EndDate,
		@DishonorablyDischarged,
		@LockedUser,
		@LockedDate)
	
	Set @pkCPClientMilitaryRecord = Scope_Identity()

end
Else
begin

	Update	CPClientMilitaryRecord
	Set	 
		fkCPClient = @fkCPClient, 
		StartDate = @StartDate,
		EndDate = @EndDate,
		DishonorablyDischarged = @DishonorablyDischarged,
		LockedUser = @LockedUser, 
		LockedDate = @LockedDate
	Where	pkCPClientMilitaryRecord = @pkCPClientMilitaryRecord

end