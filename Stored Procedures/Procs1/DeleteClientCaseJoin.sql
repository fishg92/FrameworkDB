CREATE PROCEDURE [api].[DeleteClientCaseJoin]
	 @CaseID decimal
	,@ClientID decimal
	,@LUPUser varchar(50)
AS

EXEC dbo.SetAuditDataContext @AuditUser = @LUPUser, @AuditMachine = 'WebAPI'

DELETE CPJoinClientClientCase
WHERE fkCPClient = @ClientID
AND fkCPClientCase = @CaseID