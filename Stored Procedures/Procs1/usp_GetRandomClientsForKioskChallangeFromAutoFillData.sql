



CREATE PROC [dbo].[usp_GetRandomClientsForKioskChallangeFromAutoFillData]
(
	@DataViewID int
	, @KeywordName varchar(100)
	, @KeywordValue varchar(100)
	, @MaxResults int
	, @OrderBy varchar(100) = 'NewID()'
)
AS



select @KeywordValue = replace(@KeywordValue,'''','''''')


If @Maxresults < 0
BEGIN
	SET @Maxresults = 100
END

-- Get View Name
DECLARE @ViewName varchar(255)
SELECT @ViewName = dbo.fnGetAutoFillViewName(@DataViewID)

-- Must have a keyword name, if not - replace it with 1 and value is 0
IF LTRIM(RTRIM(@KeywordName)) = ''
BEGIN
	-- Return Nothing
	SET @KeywordName = '1'
	SET @KeywordValue = '0'
END
ELSE
BEGIN

	IF dbo.ColumnAlreadyExistsInView(@ViewName, @KeywordName) = 1
	BEGIN

		-- Column name exists, put brackets
		SET @KeywordName = '[' + @KeywordName + ']'

	END
	ELSE
	BEGIN
		-- Return Nothing
		SET @KeywordName = '1'
		SET @KeywordValue = '0'
	END

END


-- MaxResults must be a positive int
If @MaxResults < 0
BEGIN
	SET @MaxResults = 1000
END

DECLARE @SQLExec varchar(1500)

SELECT @OrderBy = 
	CASE @OrderBy
	WHEN '' THEN ' ORDER BY ' + @KeywordName
	ELSE ' ORDER BY ' + @OrderBy
END
	SET @SQLExec = 'SELECT TOP ' + CONVERT(varchar(100), @MaxResults) 
	+ ' * FROM ' + @ViewName + ' WHERE ' + @KeywordName + ' NOT LIKE ''' 
	+ @KeywordValue + '''' 

	if len(ltrim(rtrim(@KeywordValue))) = 0 BEGIN
		SET @SQLExec = @SQLExec + ' and 1 = 2 '
	END

--print @sqlexec

	SET @SQLExec = @SQLExec + @OrderBy


EXEC(@SQLExec)













