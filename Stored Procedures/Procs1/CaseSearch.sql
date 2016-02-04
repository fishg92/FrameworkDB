CREATE PROCEDURE [api].[CaseSearch]
	 @StateCaseNumber varchar(20) = null
	,@LocalCaseNumber varchar(20) = null
	,@ClientID decimal = null
	,@ProgramType varchar(100) = null
	,@CaseID decimal = null
AS

DECLARE @case TABLE
(
	 CaseID decimal
	,StateCaseNumber varchar(20)
	,LocalCaseNumber varchar(20)
	,ProgramType varchar(100)
	,CaseHeadID decimal
)

INSERT @case
(
	 StateCaseNumber
	,LocalCaseNumber
	,CaseID
	,ProgramType
	,CaseHeadID
)
SELECT   cc.StateCaseNumber
		,cc.LocalCaseNumber
		,CaseID = cc.pkCPClientCase
		,ProgramType = ISNULL(pt.ProgramType,'')
		,CaseHeadID = cc.[fkCPClientCaseHead]
FROM CPClientCase cc
JOIN ProgramType pt	ON cc.fkCPRefClientCaseProgramType = pt.pkProgramType
WHERE (cc.StateCaseNumber LIKE @StateCasenumber + '%' OR @StateCaseNumber IS NULL)
AND (cc.LocalCaseNumber LIKE @LocalCasenumber + '%' OR @LocalCaseNumber IS NULL)
AND (pt.ProgramType LIKE @ProgramType + '%' OR @ProgramType IS NULL)
AND (EXISTS(SELECT * FROM CPJoinClientClientCase j 
			WHERE j.fkCPClientCase = cc.pkCPClientCase
			AND j.fkCPClient = @ClientID)
	OR
	@ClientID IS NULL)
AND (cc.pkCPClientCase = @CaseID OR @CaseID IS NULL)

SELECT * FROM @case

SELECT   c.*
		,CaseID = j.fkCPClientCase
		,IsCaseHead = 
			CASE
				WHEN j.PrimaryParticipantOnCase = 1
					THEN CAST(1 AS BIT)
				ELSE
					CAST(0 AS BIT)
			END
FROM cpclient c
JOIN CPJoinClientClientCase j ON c.pkcpclient = j.fkcpclient
JOIN @case cc ON cc.CaseID = j.fkCPClientCase