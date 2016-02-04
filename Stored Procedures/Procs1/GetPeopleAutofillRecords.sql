/*
	exec ud.GetPeopleAutofillRecords
	@9Char = 21may
	--@LastName = 'Gr'
*/

CREATE PROC [ud].[GetPeopleAutofillRecords]
(	
	@FirstName VARCHAR(100) = null
	,@LastName VARCHAR(100) = null
	,@SSN VARCHAR(10) = null
	,@BirthDate DATETIME = null
	,@StateIssuedNumber VARCHAR(50) = null
	,@SISNumber VARCHAR(50) = null
	,@CompassNumber VARCHAR(25) = null
	
	,@StateCaseNumber VARCHAR(100) = null
	,@LocalCaseNumber VARCHAR(100) = null
	,@WSUserName VARCHAR(100) = null
	,@NineChar VARCHAR(9) = null
	,@TwentyChar VARCHAR(20) = null
	
	--Paging criteria is zero based. (Setting only the rowCount will basically force max records.
	,@StartRow INT = 0
	,@RowCount INT = 50
)
AS

/********Set Up Paging Vars********/
IF @StartRow <= 0 
	SET @StartRow = 1
ELSE
	SET @StartRow = @StartRow + 1
	
IF @RowCount < 0
	SET @RowCount = 0
ELSE IF @RowCount > 1000
	SET @RowCount = 1000
ELSE
	SET @RowCount = @RowCount -1
/**********************************/

/*******Set Up Autofill Table******/
DECLARE @AutofillData TABLE (
	rownum DECIMAL	
	,CompassNumber VARCHAR(25)
	,pkCPClient DECIMAL
	,LastName VARCHAR(100)
	,FirstName VARCHAR(100)
	,MiddleName VARCHAR(50)
	,SSN VARCHAR(11)
	,ExternalSystemID VARCHAR(50)
	,BirthDate DATETIME
	,Sex VARCHAR(6)
	,NameSuffix VARCHAR(50)
	
	,PhysicalStreet1 VARCHAR(100)
	,PhysicalStreet2 VARCHAR(100)
	,PhysicalStreet3 VARCHAR(100)
	,PhysicalCity VARCHAR(100)
	,PhysicalState VARCHAR(20)
	,PhysicalZip VARCHAR(5)
	,PhysicalZipPlus4 VARCHAR(4)
	
	,MailingStreet1 VARCHAR(100)
	,MailingStreet2 VARCHAR(100)
	,MailingStreet3 VARCHAR(100)
	,MailingCity VARCHAR(100)
	,MailingState VARCHAR(20)
	,MailingZip VARCHAR(5)
	,MailingZipPlus4 VARCHAR(4)
	
	,HomePhone VARCHAR(10)
	,CellPhone VARCHAR(10)
		
	,StateCaseNumber VARCHAR(50)
	,LocalCaseNumber VARCHAR(50)
	,CaseManagerUserName VARCHAR(100)
	,CaseManagerName VARCHAR(100)
	,[xxxCheck Consecutive #] VARCHAR(9)
	,[xxxBatch #] VARCHAR(20)
);
/**********************************/

set @CompassNumber = substring(@CompassNumber, 3, len(@CompassNumber) -2)

/********Fill Autofill Table*******/
INSERT INTO @AutofillData 
	SELECT 	
		[rownum] = ROW_NUMBER() OVER(ORDER BY c.LastName, c.FirstName, c.SSN)
		,CompassNumber = c.pkCPClient
		,c.pkCPClient
		,c.LastName
		,c.FirstName
		,c.MiddleName
		--,c.SSN
		,[SSN] = substring(c.SSN,0,4) + '-' + substring(c.SSN,4,2) + '-' + substring(c.SSN,6,4) 
		,[ExternalSystemID] = c.StateIssuedNumber
		,c.BirthDate
		,c.Sex
		,[NameSuffix] = c.Suffix
		
		,[PhysicalStreet1] = pa.Street1
		,[PhysicalStreet2] = pa.Street2
		,[PhysicalStreet3] = pa.Street3
		,[PhysicalCity] = pa.City
		,[PhysicalState] = pa.State
		,[PhysicalZip] = pa.Zip
		,[PhysicalZipPlus4] = pa.ZipPlus4
		
		,[MailingStreet1] = ma.Street1
		,[MailingStreet2] = ma.Street2
		,[MailingStreet3] = ma.Street3
		,[MailingCity] = ma.City
		,[MailingState] = ma.State
		,[MailingZip] = ma.Zip
		,[MailingZipPlus4] = ma.ZipPlus4
		
		,[HomePhone] = c.HomePhone
		,[CellPhone] = c.CellPhone
		
		,[StateCaseNumber] = cc.StateCaseNumber
		,[LocalCaseNumber] = cc.LocalCaseNumber
		,[CaseManagerUserName] = (SELECT au.UserName FROM applicationuser au WHERE pkApplicationUser = cc.fkApplicationUser)
		,[CaseManagerName] = (SELECT [Name] = au.FirstName + ' ' + au.LastName FROM applicationuser au WHERE pkApplicationUser = cc.fkApplicationUser)
		,[xxxCheck Consecutive #] = c.pkCPClient
		,[xxxBatch #] = c.pkCPClient * '10000000000'
	FROM	CPClient c (NOLOCK)
	LEFT JOIN CPJoinClientClientAddress jm
		ON jm.fkCPClient = c.pkCPClient
		AND jm.fkCPRefClientAddressType = 1
	LEFT JOIN CPJoinClientClientAddress jp
		ON jp.fkCPClient = c.pkCPClient	
		AND jp.fkCPRefClientAddressType = 2
	LEFT JOIN CPClientAddress pa
		ON pa.pkCPClientAddress = jm.fkCPClientAddress
	LEFT JOIN CPClientAddress ma
		ON ma.pkCPClientAddress = jp.fkCPClientAddress
	LEFT JOIN CPJoinClientClientCase jcc
		ON c.pkCPClient = jcc.fkCPClient
	LEFT JOIN CPClientCase cc
		ON cc.pkCPClientCase = jcc.fkCPClientCase
	
	WHERE 1=1
	AND 	(@FirstName IS NULL OR c.FirstName LIKE @FirstName + '%')
	AND   	(@LastName IS NULL OR c.LastName LIKE @LastName + '%')
	AND   	(@SSN IS NULL OR c.SSN LIKE @SSN + '%')
	AND   	(@BirthDate IS NULL OR c.BirthDate = @BirthDate)
	AND   	(@StateIssuedNumber IS NULL OR c.StateIssuedNumber LIKE @StateIssuedNumber + '%')
	AND   	(@SISNumber IS NULL OR c.SISNumber LIKE @SISNumber + '%')
	AND		(@StateCaseNumber IS NULL OR cc.StateCaseNumber like @StateCaseNumber + '%')
	AND		(@LocalCaseNumber IS NULL OR cc.LocalCaseNumber like @LocalCaseNumber + '%')
	AND		(@CompassNumber IS NULL OR c.pkCPClient like @CompassNumber + '%')
	AND		(@NineChar IS NULL OR c.pkCPClient like @NineChar + '%')
	AND		(@TwentyChar IS NULL OR c.pkCPClient like @TwentyChar + '%')
/**********************************/

SELECT 
	CompassNumber
	,pkCPClient
	,LastName
	,FirstName
	,MiddleName
	,SSN
	,ExternalSystemID
	,BirthDate
	,Sex
	,NameSuffix
	
	,PhysicalStreet1 
	,PhysicalStreet2
	,PhysicalStreet3
	,PhysicalCity
	,PhysicalState
	,PhysicalZip
	,PhysicalZipPlus4
	
	,MailingStreet1
	,MailingStreet2
	,MailingStreet3
	,MailingCity
	,MailingState
	,MailingZip
	,MailingZipPlus4
	
	,HomePhone
	,CellPhone
	
	,StateCaseNumber
	,LocalCaseNumber
	,CaseManagerUserName
	,CaseManagerName
	,[UserName] = @WSUserName
	,[xxxCheck Consecutive #] 
	,[xxxBatch #] 
	FROM(
		SELECT 	
		*
		FROM @AutofillData
) AS PageableData
WHERE 1=1
AND		(rownum >= @StartRow AND rownum <= @StartRow + @RowCount)

/***************************ROW COUNT***********************************/
SELECT 	
COUNT(*)
FROM	
@AutofillData