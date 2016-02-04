CREATE PROCEDURE [api].[SetCaseHead]
	 @CaseID decimal
	,@CaseHeadID decimal
	,@LUPUser varchar(50)
AS

EXEC dbo.SetAuditDataContext @AuditUser = @LUPUser, @AuditMachine = 'WebAPI'

UPDATE CPJoinClientClientCase
SET PrimaryParticipantOnCase = 1
WHERE fkCPClientCase = @CaseID
AND fkCPClient = @CaseHeadID
AND PrimaryParticipantOnCase <> 1

UPDATE CPJoinClientClientCase
SET PrimaryParticipantOnCase = 0
WHERE fkCPClientCase = @CaseID
AND fkCPClient <> @CaseHeadID
AND PrimaryParticipantOnCase <> 0