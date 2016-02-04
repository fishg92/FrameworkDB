
/*

[dbo].[usp_GetAutoFillDataWithPagingTest] 
@DataViewID = 1
, @KeywordNameValuePairs = '<row itemKey="First Name" itemValue="J" /><row itemKey="Last Name" itemValue="N" />'
, @MaxResults = 10
, @OrderBy = 'Last Name, First Name'
, @PageNumber = 1
, @GetTotalResults  = 1

[dbo].[usp_GetAutoFillDataWithPagingTest] 
@DataViewID = 1
, @KeywordNameValuePairs = '<row itemKey="1" itemValue="J" /><row itemKey="2" itemValue="N" />'
, @MaxResults = 10
, @OrderBy = 'Last Name'
, @PageNumber = 0
, @GetTotalResults  = 1


*/

CREATE PROCEDURE [dbo].[usp_GetAutoFillDataWithPagingTest]
(
	  @DataViewID int
	, @KeywordNameValuePairs as XML
	, @MaxResults int
	, @OrderBy varchar(100) = ''
	, @PageNumber int
	, @GetTotalResults bit = NULL
)
AS

DECLARE @KeyValueClause varchar(max)

declare @KeywordName varchar(max)
declare @KeywordValue varchar(max)
set @KeyWordValue = ''
set @KeyValueClause = ''

if @Orderby <> ''
BEGIN
  set @OrderBy = @OrderBy + ', [Compass Number]'
END

--SET @KeywordValue = REPLACE(@KeywordValue,'''','''''')

IF @Maxresults < 0
BEGIN
	SET @Maxresults = 100
END

-- Get View Name
DECLARE @ViewName varchar(255)
SET @ViewName = dbo.fnGetAutoFillViewName(@DataViewID)



DECLARE CriteriaCursor Cursor FOR

select itemKey
,ItemValue
 from dbo.fnSplitList(@KeywordNameValuePairs)

		Open CriteriaCursor 

		DECLARE @itemKey varchar(max)
		DECLARE @itemValue varchar(max)

		Fetch NEXT FROM CriteriaCursor INTO @itemKey, @itemValue

		While (@@FETCH_STATUS <> -1)
		BEGIN
			IF (@@FETCH_STATUS <> -2)			
print 'executing while logic'
					select @KeywordValue = replace(@itemValue,'''','''''')
					select @KeywordName = @itemKey
					-- Must have a keyword name, if not - replace it with 1 and value is 0
					IF LTRIM(RTRIM(@KeywordName)) = ''
					BEGIN
						-- Return Nothing
						SET @KeywordName = '1'
						SET @KeywordValue = '0'
					END
					ELSE
					BEGIN
print 'Keywordname=' + @KeywordName
		--print 'dbo.ColumnAlreadyExistsInView(' + @ViewName + ' , ' + @KeywordName + ')'
						IF dbo.ColumnAlreadyExistsInView(@ViewName, @KeywordName) = 1
						BEGIN
							-- Column name exists, put brackets
							print 'found keyword in view'
							SET @KeywordName = '[' + @KeywordName + ']'
						END
						ELSE
						BEGIN
							-- Return Nothing
							SET @KeywordName = '1'
							SET @KeywordValue = '0'
						END
					END

/* TODO: We cannot assume Compass Number will exist. The caller should pass in Compass Number if they want to order by that  */

					SELECT @OrderBy = 
						CASE @OrderBy
						WHEN '' THEN  '[' + @KeywordName + ']' + ', [Compass Number] '
						ELSE  @OrderBy  
					END
print '@Orderby = ' + @Orderby
print 'setting keyvalueclause'
						SET @KeyValueClause = @KeyValueClause +  @KeywordName + ' LIKE ''' 
							+ REPLACE(@KeywordValue,'''','''''') + '%''' + ' and '

print '@KeyValueClause is ' + @KeyValueClause

			Fetch NEXT FROM CriteriaCursor INTO @itemKey, @itemValue
		END
		CLOSE CriteriaCursor
		DEALLOCATE CriteriaCursor

set @KeyValueClause = substring(@KeyValueClause,1,len(@KeyValueClause)-4)


/*
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
*/
DECLARE @SQLExec varchar(max)

/* TODO: We cannot assume Compass Number will exist. The caller should pass in Compass Number if they want to order by that  */
/*
print 'where caluse done, setting orderby'
SET @OrderBy = 
	CASE @OrderBy
		WHEN '' THEN
			 ' ORDER BY ' + @KeywordName + ', [Compass Number] '
		ELSE
			 ' ORDER BY ' + @OrderBy + ', [Compass Number] '
	END
*/
DECLARE @ColumnNames varchar(max)
SET @ColumnNames = dbo.fnGetViewColumnNames(@ViewName)

DECLARE @PagingWhereClause varchar(max)
SET @PagingWhereClause = ''
IF (ISNULL(@PageNumber,0) = 0)
BEGIN
	SET @PagingWhereClause = ' WHERE row <= ' + CONVERT(varchar(10), @MaxResults)
END
ELSE
BEGIN
	SET @PagingWhereClause = ' WHERE row > ' + CONVERT(varchar(10), (@MaxResults * @PageNumber)) + ' AND row <= ' + CONVERT(varchar(10), (@MaxResults * (@PageNumber + 1)))
END

DECLARE @WhereClause varchar(max)
DECLARE @CountSelect varchar(2000)

print '@Orderby = ' + @Orderby
--SET @WhereClause = ' WHERE ' + @KeywordName + ' LIKE ''' + @KeywordValue + '%'''
SET @WhereClause = ' WHERE ' + @KeyValueClause

SET @CountSelect = 'SELECT COUNT(' + @KeywordName + ') FROM ' + @ViewName + @WhereClause

SET @SQLExec = 'SELECT ' + @ColumnNames + ' FROM ( SELECT ' + @ColumnNames + ', row_number() OVER (ORDER BY ' + @OrderBy + ') AS row FROM ' + @ViewName + @WhereClause + ' ) AS ResultSet ' + @PagingWhereClause

print 'sql to exec is ' + @sqlexec
EXEC (@SQLExec)

IF (ISNULL(@GetTotalResults,0) = 1)
BEGIN
	EXEC (@CountSelect)
END
ELSE
BEGIN
	--return a blank table so that the resulting dataset still has 2 tables
	SELECT 0 FROM sysobjects WHERE 1 = 0
END
