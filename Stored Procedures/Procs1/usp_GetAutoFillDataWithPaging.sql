
/*


	[dbo].[usp_GetAutoFillDataWithPaging] 
	@DataViewID = 3
	, @KeywordNameValuePairs = '<row itemKey="Last Name" itemValue="S" />'
	, @MaxResults = 10
	, @OrderBy = '[Last Name], [First Name]'
	--, @OrderBy = ''
	, @PageNumber = 2
	, @GetTotalResults  = 0



[dbo].[usp_GetAutoFillDataWithPaging] 
@DataViewID = 5
, @KeywordNameValuePairs = '<row itemKey="First Name" itemValue="" /><row itemKey="Last Name" itemValue="T" />'
, @MaxResults = 10
, @OrderBy = '[Last Name], [First Name]'
--, @OrderBy = ''
, @PageNumber = 0
, @GetTotalResults  = 1

*/

CREATE PROCEDURE [dbo].[usp_GetAutoFillDataWithPaging]
(
	  @DataViewID int
	, @KeywordNameValuePairs as XML
	, @MaxResults int
	, @OrderBy varchar(100) = ''
	, @PageNumber int
	, @GetTotalResults bit = NULL
	, @pkApplicationUser decimal = -1
)
AS
DECLARE @KeyValueClause varchar(max)
DECLARE @IgnoreProgramTypeSecurity tinyint
DECLARE @IgnoreSecuredClientSecurity tinyint
DECLARE @SecurityWhereClause varchar(max)
DECLARE @KeywordName varchar(max)
DECLARE @KeywordValue varchar(max)
DECLARE @ViewName varchar(255)
DECLARE @SQLExec varchar(max)
DECLARE @SQLExecNew varchar(max)
DECLARE @ColumnNames varchar(max)

SET @ViewName = dbo.fnGetAutoFillViewName(@DataViewID)
set @IgnoreProgramTypeSecurity = 0
set @IgnoreSecuredClientSecurity = 0
set @SecurityWhereClause = ''

create table #GetViewText (SQLViewPart varchar(8000))
	insert into #GetViewText exec sp_helptext @ViewName
	declare @CompleteViewText varchar(8000)
	set @CompleteViewText = ''

		SET NOCOUNT ON 
		DECLARE @HoldViewText VARCHAR(8000)
		DECLARE c CURSOR FOR 
			SELECT SQLViewPart from #GetViewText
			OPEN c 
			FETCH NEXT FROM c INTO @HoldViewText
			WHILE @@FETCH_STATUS = 0 BEGIN 
				set @CompleteViewText = @CompleteViewText + @HoldViewText
				FETCH NEXT FROM c INTO @HoldViewText 
			END 
			CLOSE c 
		DEALLOCATE c 

	
drop table #GetViewText

set @sqlexecnew = substring(@CompleteViewText,charindex(rtrim('[' + @ViewName + ']') + char(13) + char(10) + 'AS' ,@CompleteViewText,1) + len(rtrim('[' + @ViewName + ']') +char(13) + char(10) + 'AS' ) + 1,len(@CompleteViewText) - len(charindex(rtrim('[' + @ViewName + ']') +char(13) + char(10) + 'AS' ,@CompleteViewText,1))) 

--SET @SQLExecNew = (select top 1 substring(view_definition,charindex(rtrim('[' + @ViewName + ']') + char(13) + char(10) + 'AS' ,view_definition,1) + len(rtrim('[' + @ViewName + ']') +char(13) + char(10) + 'AS' ) + 1,len(view_definition) - len(charindex(rtrim('[' + @ViewName + ']') +char(13) + char(10) + 'AS' ,view_definition,1))) from INFORMATION_SCHEMA.VIEWS where table_name = rtrim(@ViewName) order by table_schema desc) 

-- check to see if openquery is in the query definition. If so then call the CrossServer proc instead.
if charindex('openquery', @SQLExecNew) <> 0
begin
	exec usp_GetAutoFillDataWithPaging_CrossServer @DataViewID, @KeywordNameValuePairs, @MaxResults, @OrderBy, @PageNumber, @GetTotalResults, @pkApplicationUser
end
else
Begin

if exists (select * from AutoFillDataView where pkAutoFillDataView = @DataViewID) BEGIN
	select @IgnoreProgramTypeSecurity = isnull(IgnoreProgramTypeSecurity,0)
		,@IgnoreSecuredClientSecurity = isnull(IgnoreSecuredClientSecurity,0)
			from AutoFillDataView where
		pkAutoFillDataView = @DataViewID
END

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

--print @ViewName
DECLARE @NonblankKeywordValueDataFound int
set @NonblankKeywordValueDataFound = 0

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

					select @KeywordValue = @itemValue --replace(@itemValue,'''','''''')
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

/* TODO: We cannot assume Compass Number will exist. The caller should pass in Compass Number if they want to order by that  */

					SELECT @OrderBy = 
						CASE @OrderBy
						WHEN '' THEN  + @KeywordName  + ', [Compass Number] '
						ELSE  @OrderBy  
					END


						SET @KeyValueClause = @KeyValueClause +  @KeywordName + ' LIKE ''' 
							+ REPLACE(@KeywordValue,'''','''''') + '%''' + ' and '

						if len(rtrim(ltrim(@KeywordValue))) > 0 BEGIN
							set @NonblankKeywordValueDataFound = 1
						END

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


SET @WhereClause = ' WHERE ' + @KeyValueClause

if @NonblankKeywordValueDataFound = 0 BEGIN
	SET @WhereClause = @WhereClause  + ' and 1 = 2 '
END

SET @CountSelect = 'SELECT COUNT(' + @KeywordName + ') FROM ' + @ViewName + @WhereClause

--SET @SQLExec = 'SELECT ' + @ColumnNames + ' FROM ( SELECT ' + @ColumnNames + ', row_number() OVER (ORDER BY ' + @OrderBy + ') AS row FROM '
--	 + @ViewName 
--		+ @WhereClause + ' ) AS ResultSet ' + @PagingWhereClause

/* Do we already have a WHERE clause in this view? Note, the need to do this will go away when autofill views are converted to being table-driven */
if charindex('WHERE',substring(@SqlExecnew,charindex('FROM ',@SqlExecnew,1),len(@SqlExecnew)-charindex('FROM ',@SqlExecnew,1)+1)) = 0 BEGIN
	set @SqlExecnew = @SqlExecnew + ' where 1=1 and'
END ELSE BEGIN
	set @SqlExecnew = @SqlExecnew + ' and'
END

-- extracted text of underlyng security filtering into separate function for portability to other procs
set @SecurityWhereClause = dbo.fnGetAutoFillSecurityWhereClause(@IgnoreProgramTypeSecurity, @IgnoreSecuredClientSecurity, @pkApplicationUser)

if @SecurityWhereClause <> '' 
begin
	set @SqlExecnew = @SqlExecnew + @SecurityWhereClause	
end

set @SQLExecNew = substring(@SQLExecNew,1,len(@SQLExecNew)-4) 

set @SQLExecNew = ' (' + @SQLExecNew + ') SQLView '
--print @SQLExecNew

SET @SQLExec = 'SELECT ' + @ColumnNames + ' FROM ( SELECT ' + @ColumnNames + ', row_number() OVER (ORDER BY ' + @OrderBy + ') AS row FROM '
	 + @SQLExecNew
		+ @WhereClause + ' ) AS ResultSet ' + @PagingWhereClause



--print @Sqlexec
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
end
