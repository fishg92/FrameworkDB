
CREATE PROCEDURE [dbo].[spCPGetCPClientCaseAndAncillaryTables]
(
	  @StateCaseNumber varchar(20) = NULL
	, @LocalCaseNumber varchar(20) = NULL
)
AS

SELECT DISTINCT
  cc.pkCPClientCase
, cc.CreateUser
, cc.CreateDate
, cc.LUPUser
, cc.LUPDate
, StateCaseNumber = CASE WHEN UPPER(ISNULL(cc.StateCaseNumber, '#EMPTY')) = '#EMPTY' THEN '' ELSE cc.StateCaseNumber END
, LocalCaseNumber = CASE WHEN UPPER(ISNULL(cc.LocalCaseNumber, '#EMPTY')) = '#EMPTY' THEN '' ELSE cc.LocalCaseNumber END
, cc.fkCPRefClientCaseProgramType
, cc.fkCPCaseWorker
, cc.LockedUser
, cc.LockedDate
, cc.fkApplicationUser
, cc.CaseStatus
FROM CPClientCase cc WITH (NOLOCK)
--LEFT JOIN CPCaseWorker cw ON cw.pkCPCaseWorker = cc.fkCPCaseWorker
--LEFT JOIN CPRefClientCaseProgramType rpt ON cc.fkCPRefClientCaseProgramType = rpt.pkCPRefClientCaseProgramType
WHERE (@StateCaseNumber IS NULL OR cc.StateCaseNumber LIKE @StateCaseNumber + '%')
AND   (@LocalCaseNumber IS NULL OR cc.LocalCaseNumber LIKE @LocalCaseNumber + '%')
AND	ISNULL(cc.pkCPClientCase,0) <> 0

-- The two ancillary tables are no longer used in the client 
--returning empty sets to maintain compatibility with the dataset in the WCF service
--SELECT TOP 1 NULL FROM CPCaseWorker
--SELECT TOP 1 NULL FROM CPRefClientCaseProgramType