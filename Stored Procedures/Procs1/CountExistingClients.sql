
CREATE PROCEDURE [dbo].[CountExistingClients]
	  @SSN varchar(10) = Null
	, @LastName varchar(100) = null
	, @pkCase decimal(18,0) = NULL
	, @FirstName varchar(100) = NULL
AS

SET @SSN = LTRIM(RTRIM(ISNULL(@SSN,'')))
SET @LastName = LTRIM(RTRIM(ISNULL(@LastName,'')))
SET @FirstName = LTRIM(RTRIM(ISNULL(@FirstName,'')))

--SELECT CaseCount = COUNT(*) 
--FROM CPClient (NOLOCK) 
--WHERE (SSN = @SSN OR @ssn = '')
--	AND (LastName = @LastName or @LastName = '')
--	AND (FirstName = @FirstName or @FirstName = '')
		


IF DATALENGTH(@SSN) <> 9
BEGIN
	SET @SSN = ''
END
	
IF  @SSN = ''
AND @LastName = ''
AND @FirstName = ''
BEGIN
	--no search criteria, pass back a zero count
	SELECT TOP 1 CaseCount = 0 FROM CPClient
END
ELSE IF @SSN <> ''
	AND @LastName = ''
	AND @FirstName = ''
	BEGIN
		SELECT CaseCount = COUNT(*) 
		FROM CPClient (NOLOCK) 
		WHERE SSN = @SSN
		option (recompile)
	END
ELSE IF @SSN = ''
	AND @LastName <> ''
	AND @FirstName = ''
	BEGIN
		SELECT CaseCount = COUNT(*) 
		FROM CPClient (NOLOCK) 
		WHERE LastName LIKE @LastName + '%'
		option (recompile)
	END
ELSE IF @SSN = ''
	AND @LastName = ''
	AND @FirstName <> ''
	BEGIN
		SELECT CaseCount = COUNT(*) 
		FROM CPClient (NOLOCK) 
		WHERE FirstName LIKE @FirstName + '%'
		option (recompile)
	END		
ELSE IF @SSN <> ''
	AND @LastName <> ''
	AND @FirstName = ''
	BEGIN
		SELECT CaseCount = COUNT(*) 
		FROM CPClient (NOLOCK) 
		WHERE SSN = @SSN 
		AND LastName LIKE @LastName +'%'
		option (recompile)
	END
ELSE IF @SSN <> ''
	AND @LastName = ''
	AND @FirstName <> ''
	BEGIN
		SELECT CaseCount = COUNT(*) 
		FROM CPClient (NOLOCK) 
		WHERE SSN = @SSN 
		AND FirstName LIKE @FirstName + '%'
		option (recompile)
	END
ELSE IF @SSN = ''
	AND @LastName <> ''
	AND @FirstName <> ''
	BEGIN
		SELECT CaseCount = COUNT(*) 
		FROM CPClient (NOLOCK) 
		WHERE LastName LIKE @LastName + '%' 
		AND FirstName LIKE @FirstName + '%'
		option (recompile)
	END
ELSE
BEGIN
	SELECT CaseCount = COUNT(*) 
	FROM CPClient (NOLOCK) 
	WHERE SSN = @SSN 
	AND LastName LIKE @LastName + '%' 
	AND FirstName LIKE @FirstName + '%'
	option (recompile)
END
	


