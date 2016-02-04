
CREATE  Proc [dbo].[spCPGetCaseMembershipChangeDate]
@pkCPClientCase decimal(18,0)
as

begin
	
	Select 	distinct CreateDate
	From 	CPJoinClientClientCase with (NoLock)
	Where	fkCPClientCase = @pkCPClientCase
	
	Union All
	
	Select 	Distinct AuditStartDate
	From	CPJoinClientClientCaseAudit with (NoLock)
	Where	fkCPClientCase = @pkCPClientCase

end
