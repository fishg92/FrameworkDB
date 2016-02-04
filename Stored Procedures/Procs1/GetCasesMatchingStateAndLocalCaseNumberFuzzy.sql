
/*

exec GetCasesMatchingStateAndLocalCaseNumberFuzzy '33333333333333333333', ''

*/

CREATE proc [dbo].[GetCasesMatchingStateAndLocalCaseNumberFuzzy]
(
	@StateCaseNumber varchar(100)
   ,@LocalCaseNumber varchar(100)
)

as

SET @StateCaseNumber = LTRIM(RTRIM(ISNULL(@StateCaseNumber,'')))
SET @LocalCaseNumber = LTRIM(RTRIM(ISNULL(@LocalCaseNumber,'')))

IF @StateCaseNumber <> '' AND @LocalCaseNumber = '' BEGIN
	SELECT *
	FROM CPClientCase (NOLOCK) 
	WHERE StateCaseNumber LIKE @StateCaseNumber + '%'
	option (recompile)
END
ELSE IF @StateCaseNumber = '' AND @LocalCaseNumber <> '' BEGIN
	SELECT *
	FROM CPClientCase (NOLOCK) 
	WHERE LocalCaseNumber LIKE @LocalCaseNumber + '%'
	option (recompile)
END
ELSE IF @StateCaseNumber <> '' AND @LocalCaseNumber <> '' BEGIN
	SELECT *
	FROM CPClientCase (NOLOCK) 
	WHERE StateCaseNumber LIKE @StateCaseNumber + '%' 
	AND LocalCaseNumber LIKE @LocalCaseNumber + '%'
	option (recompile)
END
