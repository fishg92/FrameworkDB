CREATE PROCEDURE [api].[InsertClientCaseJoin]
	 @CaseID decimal
	,@ClientID decimal
	,@LUPUser varchar(50)
AS

EXEC dbo.SetAuditDataContext @AuditUser = @LUPUser, @AuditMachine = 'WebAPI'

IF NOT EXISTS(SELECT * 
			  FROM CPJoinClientClientCase
			  WHERE fkCPClient = @ClientID
			  AND fkCPClientCase = @CaseID)
BEGIN
	INSERT INTO CPJoinClientClientCase
	(
		 fkCPClient
		,fkCPClientCase
		,PrimaryParticipantOnCase
	)
	VALUES
	(
		 @ClientID
		,@CaseID
		,0
	)
END