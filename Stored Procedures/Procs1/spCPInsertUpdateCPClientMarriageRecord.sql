
CREATE   Proc [dbo].[spCPInsertUpdateCPClientMarriageRecord]
(	
	@fkCPClient decimal(18, 0) ,
	@StartDate datetime ,
	@EndDate datetime = Null ,
	@fkCPRefMarraigeEndType decimal(18, 0) ,
	@LockedUser varchar(50) = Null,
	@LockedDate datetime = Null,
	@Spouse Varchar(50) = Null,
	@pkCPClientMarriageRecord decimal(18,0) output
)
as


If IsNull(@pkCPClientMarriageRecord,0) = 0
begin

	INSERT INTO CPClientMarriageRecord
	(	 
		fkCPClient, 
		StartDate ,
		EndDate,
		fkCPRefMarraigeEndType,
		LockedUser, 
		LockedDate,
		Spouse)
	VALUES     
	(	
		@fkCPClient,
		@StartDate,
		@EndDate,
		@fkCPRefMarraigeEndType,
		@LockedUser,
		@LockedDate,
		@Spouse)
	
	Set @pkCPClientMarriageRecord = Scope_Identity()

end
Else
begin

	Update	CPClientMarriageRecord
	Set 
		fkCPClient = @fkCPClient, 
		StartDate = @StartDate,
		EndDate = @EndDate,
		fkCPRefMarraigeEndType = @fkCPRefMarraigeEndType,
		LockedUser = @LockedUser, 
		LockedDate = @LockedDate,
		Spouse = @Spouse
	Where	pkCPClientMarriageRecord = @pkCPClientMarriageRecord

end