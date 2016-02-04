CREATE PROCEDURE [dbo].[CountExistingCases]
	  @StateCaseNumber varchar(20)
	, @LocalCaseNumber varchar(20)
AS

SET @StateCaseNumber = LTRIM(RTRIM(ISNULL(@StateCaseNumber,'')))
SET @LocalCaseNumber = LTRIM(RTRIM(ISNULL(@LocalCaseNumber,'')))

IF @StateCaseNumber = ''
AND @LocalCaseNumber = ''
BEGIN
	SELECT TOP 1 CaseCount = 0 
	FROM CPClientCase (NOLOCK)
	option (recompile)
END
ELSE IF @StateCaseNumber <> ''
AND @LocalCaseNumber = ''
BEGIN
	SELECT CaseCount = COUNT(*) 
	FROM CPClientCase (NOLOCK) 
	WHERE StateCaseNumber LIKE @StateCaseNumber + '%'
	option (recompile)
END
ELSE IF @StateCaseNumber = ''
AND @LocalCaseNumber <> ''
BEGIN
	SELECT CaseCount = COUNT(*) 
	FROM CPClientCase (NOLOCK) 
	WHERE LocalCaseNumber LIKE @LocalCaseNumber + '%'
	option (recompile)
END
ELSE IF @StateCaseNumber <> ''
AND @LocalCaseNumber <> ''
BEGIN
	SELECT CaseCount = COUNT(*) 
	FROM CPClientCase (NOLOCK) 
	WHERE StateCaseNumber LIKE @StateCaseNumber + '%' 
	AND LocalCaseNumber LIKE @LocalCaseNumber + '%'
	option (recompile)
END
