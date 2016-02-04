CREATE PROCEDURE [api].[ClientSearch]
	 @ClientID decimal = NULL
	,@FirstName varchar(100) = NULL
	,@LastName varchar(100) = NULL
	,@SSN varchar(9) = NULL
	,@StateIssuedNumber varchar(50) = NULL
	,@BirthDate datetime = NULL
	,@StateCaseNumber varchar(20) = NULL
	,@LocalCaseNumber varchar(20) = NULL
AS

DECLARE @ClientsForCaseState TABLE (pkCPClient decimal)
DECLARE @ClientsForCaseLocal TABLE (pkCPClient decimal)

IF @StateCaseNumber IS NOT NULL
BEGIN
	INSERT @ClientsForCaseState
	(
		pkCPClient
	)
	SELECT j.fkCPClient
	FROM CPJoinClientClientCase j
	JOIN CPClientCase cc ON j.fkCPClientCase = cc.pkCPClientCase
	WHERE cc.StateCaseNumber LIKE @StateCaseNumber + '%'
END

IF @LocalCaseNumber IS NOT NULL
BEGIN
	INSERT @ClientsForCaseLocal
	(
		pkCPClient
	)
	SELECT j.fkCPClient
	FROM CPJoinClientClientCase j
	JOIN CPClientCase cc ON j.fkCPClientCase = cc.pkCPClientCase
	WHERE cc.LocalCaseNumber LIKE @LocalCaseNumber + '%'
END

DECLARE @client table
(
	 pkCPClient decimal
	,FirstName varchar(100)
	,MiddleName varchar(100)
	,LastName varchar(100)
	,Suffix varchar(20)
	,SSN varchar(10)
	,StateIssuedNumber varchar(50)
	,BirthDate datetime
	,Gender varchar(1)
	,PhysicalAddress1 varchar(100)
	,PhysicalAddress2 varchar(100)
	,PhysicalCity varchar(100)
	,PhysicalState varchar(50)
	,PhysicalZip varchar(5)
	,PhysicalZipPlus4 varchar(4)
	,MailingAddress1 varchar(100)
	,MailingAddress2 varchar(100)
	,MailingCity varchar(100)
	,MailingState varchar(50)
	,MailingZip varchar(5)
	,MailingZipPlus4 varchar(4)
)

INSERT @client
SELECT   c.pkCPClient
		,c.FirstName
		,c.MiddleName
		,c.LastName
		,c.Suffix
		,c.SSN
		,c.StateIssuedNumber
		,c.BirthDate
		,c.Sex
		,PhysicalAddress1 = ap.Street1
		,PhysicalAddress2 = ap.Street2
		,PhysicalCity = ap.City
		,PhysicalState = ap.[State]
		,PhysicalZip = ap.Zip
		,PhysicalZipPlus4 = ap.ZipPlus4
		,MailingAddress1 = am.Street1
		,MailingAddress2 = am.Street2
		,MailingCity = am.City
		,MailingState = am.[State]
		,MailingZip = am.Zip
		,MailingZipPlus4 = am.ZipPlus4
FROM CPClient c
LEFT JOIN CPJoinClientClientAddress jp ON c.pkCPClient = jp.fkCPClient AND jp.fkCPRefClientAddressType = 2
LEFT JOIN CPClientAddress ap ON jp.fkCPClientAddress = ap.pkCPClientAddress
LEFT JOIN CPJoinClientClientAddress jm ON c.pkCPClient = jm.fkCPClient AND jm.fkCPRefClientAddressType = 1
LEFT JOIN CPClientAddress am ON jm.fkCPClientAddress = am.pkCPClientAddress
WHERE (c.pkCPClient = @ClientID OR @ClientID IS NULL)
AND (c.FirstName LIKE @FirstName + '%' OR @FirstName IS NULL)
AND (c.LastName LIKE @LastName + '%' OR @LastName IS NULL)
AND (c.SSN = @SSN OR @SSN IS NULL)
AND (c.StateIssuedNumber LIKE @StateIssuedNumber + '%' OR @StateIssuedNumber IS NULL)
AND (c.BirthDate = @BirthDate OR @BirthDate IS NULL)
AND (c.pkCPClient IN (SELECT pkCPClient FROM @ClientsForCaseState) OR @StateCaseNumber IS NULL)
AND (c.pkCPClient IN (SELECT pkCPClient FROM @ClientsForCaseLocal) OR @LocalCaseNumber IS NULL)

SELECT * FROM @client

SELECT   CaseID = cc.pkCPClientCase
		,ProgramType = ISNULL(pt.ProgramType,'')
		,cc.LocalCaseNumber
		,cc.StateCaseNumber
		,CaseHeadID = cc.fkCPClientCaseHead
		,ClientID = c.pkCPClient
FROM CPClientCase cc
JOIN CPJoinClientClientCase j ON cc.pkCPClientCase = j.fkCPClientCase
JOIN @client c ON c.pkCPClient = j.fkCPClient
LEFT JOIN ProgramType pt ON pt.pkProgramType = cc.fkCPRefClientCaseProgramType