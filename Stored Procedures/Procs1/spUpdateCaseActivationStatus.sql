CREATE procedure dbo.spUpdateCaseActivationStatus
(
	@CasePK decimal,
	@CaseStatus bit,
	@LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
as
Set nocount on
exec dbo.SetAuditDataContext @LupUser, @LupMachine

Update CPClientCase 
set CaseStatus = @CaseStatus
where pkCPClientCase = @CasePK
