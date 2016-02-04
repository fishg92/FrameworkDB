CREATE PROCEDURE [api].[GetExistingClientID]
	 @StateIssuedNumber varchar(50) = NULL
	,@SSN varchar(10) = NULL
	,@FirstName varchar(100) = NULL
	,@LastName varchar(100) = NULL
	,@BirthDate datetime = NULL
AS

SET @StateIssuedNumber = ISNULL(@StateIssuedNumber,'')
SET @FirstName = ISNULL(@FirstName,'')
SET @LastName = ISNULL(@LastName,'')
SET @SSN = ISNULL(@SSN,'')

DECLARE @ClientID decimal

-- Attempt to match by state issued number
SELECT @ClientID = pkCPClient
FROM CPClient
WHERE StateIssuedNumber = @StateIssuedNumber
AND @StateIssuedNumber <> ''

-- Attempt to match SSN
-- Only valid if one side OR the other didn't provide a State Issued Number
IF @ClientID IS NULL
AND @SSN <> ''
BEGIN
	SELECT @ClientID = pkCPClient
	FROM CPClient
	WHERE SSN = @SSN
	AND (@StateIssuedNumber = '' OR StateIssuedNumber = '')
END

-- Attempt to match name and DOB
-- Only valid if one side OR the other didn't provide a State Issued Number
-- AND one side OR the other didn't provide an SSN
IF @ClientID IS NULL
AND @BirthDate IS NOT NULL
AND @FirstName <> ''
AND @LastName <> ''
BEGIN
	SELECT @ClientID = pkCPClient
	FROM CPClient
	WHERE FirstName = @FirstName
	AND LastName = @LastName
	AND BirthDate = @BirthDate
	AND (@StateIssuedNumber = '' OR StateIssuedNumber = '')
	AND (@SSN = '' OR SSN = '' OR SSN = '000000000')
END

SELECT @ClientID