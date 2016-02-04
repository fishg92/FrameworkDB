CREATE PROCEDURE [api].[SaveCase]
	 @CaseID decimal
	,@StateCaseNumber varchar(20)
	,@LocalCaseNumber varchar(20)
	,@ProgramType varchar(50)
	,@LUPUser varchar(50)
AS

EXEC dbo.SetAuditDataContext @AuditUser = @LUPUser, @AuditMachine = 'WebAPI'

DECLARE @ProgramTypeID decimal
SELECT @ProgramTypeID = pkProgramType
FROM ProgramType
WHERE ProgramType = @ProgramType

IF @CaseID = 0
BEGIN
	INSERT INTO CPClientCase
	(
		 StateCaseNumber
		,LocalCaseNumber
		,fkCPRefClientCaseProgramType
		,fkCPClientCaseHead
	)
	VALUES
	(
		 @StateCaseNumber
		,@LocalCaseNumber
		,@ProgramTypeID
		,0
	)

	SET @CaseID = SCOPE_IDENTITY()
END
ELSE
BEGIN
	UPDATE CPClientCase
	SET  StateCaseNumber = @StateCaseNumber
		,LocalCaseNumber = @LocalCaseNumber
		,fkCPRefClientCaseProgramType = @ProgramTypeID
	WHERE pkCPClientCase = @CaseID
END

SELECT @CaseID