
/*


	[dbo].[usp_GetAutoFillDataWithPaging_CrossServer] 
	@DataViewID = 5
	, @KeywordNameValuePairs = '<row itemKey="Last Name" itemValue="T" />'
	, @MaxResults = 10
	, @OrderBy = '[Last Name], [First Name]'
	--, @OrderBy = ''
	, @PageNumber = 2
	, @GetTotalResults  = 0



[dbo].[usp_GetAutoFillDataWithPaging_CrossServer] 
@DataViewID = 5
, @KeywordNameValuePairs = '<row itemKey="First Name" itemValue="" /><row itemKey="Last Name" itemValue="T" />'
, @MaxResults = 10
, @OrderBy = '[Last Name], [First Name]'
--, @OrderBy = ''
, @PageNumber = 1
, @GetTotalResults  = 1

*/

CREATE PROC [dbo].[usp_GetAutoFillDataWithPaging_CrossServer]
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
DECLARE @InnerWhereClause varchar(max)
DECLARE @IgnoreProgramTypeSecurity tinyint
DECLARE @IgnoreSecuredClientSecurity tinyint
DECLARE @KeywordName varchar(max)
DECLARE @KeywordValue varchar(max)
DECLARE @ViewName varchar(255)
DECLARE @SQLExec varchar(max)
DECLARE @SqlViewText varchar(max)
DECLARE @ColumnNames varchar(max)
DECLARE @ParseLeft varchar(max)
DECLARE @ParseRight varchar(max)
DECLARE @ParseCountQuery varchar(max)
DECLARE @LastOccuranceCountQuery varchar(max)
DECLARE @InsertSelectBegin int
DECLARE @LastOccurance int
DECLARE @FromLocation int
DECLARE @WhereClause varchar(max)
DECLARE @CountSelect varchar(2000)
DECLARE @SecurityWhereClause varchar(max)

set @SecurityWhereClause = ''
set @IgnoreProgramTypeSecurity = 0
set @IgnoreSecuredClientSecurity = 0

SELECT @ViewName = dbo.fnGetAutoFillViewName(@DataViewID)

if exists (select * from AutoFillDataView where pkAutoFillDataView = @DataViewID) BEGIN
	select @IgnoreProgramTypeSecurity = isnull(IgnoreProgramTypeSecurity,0)
		,@IgnoreSecuredClientSecurity = isnull(IgnoreSecuredClientSecurity,0)
			from AutoFillDataView where
		pkAutoFillDataView = @DataViewID
END

--Cannot apply security if ProgramTypeID is not part of select list
IF dbo.ColumnAlreadyExistsInView(@ViewName, 'ProgramTypeID') <> 1 BEGIN
	set	@IgnoreProgramTypeSecurity = 1
	set @IgnoreSecuredClientSecurity = 1
END
IF dbo.ColumnAlreadyExistsInView(@ViewName, 'pkCpClient') <> 1 BEGIN
	set @IgnoreSecuredClientSecurity = 1
END

-- extracted text of underlyng security filtering into separate function for portability to other procs
set @SecurityWhereClause = dbo.fnGetAutoFillSecurityWhereClause(@IgnoreProgramTypeSecurity, @IgnoreSecuredClientSecurity, @pkApplicationUser)
set @KeyWordValue = ''
set @InnerWhereClause = ''

if @Orderby <> ''
BEGIN
	if dbo.ColumnAlreadyExistsInView(@ViewName, 'Compass Number') <> 1
		begin
			set @OrderBy = @OrderBy + ', [Compass Number]'
		end  
END

IF @Maxresults < 0
BEGIN
	SET @Maxresults = 100
END

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

					if @OrderBy = ''
					begin
						if dbo.ColumnAlreadyExistsInView(@ViewName, 'Compass Number') <> 1
						begin
							Set @OrderBy = @KeywordName  + ', [Compass Number] '
						end
						else
						begin
							Set @OrderBy = @KeywordName
						end  
					end
					
						SET @InnerWhereClause = @InnerWhereClause +  @KeywordName + ' LIKE ''' 
							+ REPLACE(@KeywordValue,'''','''''') + '%''' + ' and '

						if len(rtrim(ltrim(@KeywordValue))) > 0 BEGIN
							set @NonblankKeywordValueDataFound = 1
						END

			Fetch NEXT FROM CriteriaCursor INTO @itemKey, @itemValue
		END
		CLOSE CriteriaCursor
		DEALLOCATE CriteriaCursor

set @InnerWhereClause = substring(@InnerWhereClause,1,len(@InnerWhereClause)-4)

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

SET @WhereClause = ' WHERE ' + @InnerWhereClause

if @NonblankKeywordValueDataFound = 0 BEGIN
	SET @WhereClause = @WhereClause  + ' and 1 = 2 '
END

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

set @sqlViewText = substring(@CompleteViewText,charindex(rtrim('[' + @ViewName + ']') + char(13) + char(10) + 'AS' ,@CompleteViewText,1) + len(rtrim('[' + @ViewName + ']') +char(13) + char(10) + 'AS' ) + 1,len(@CompleteViewText) - len(charindex(rtrim('[' + @ViewName + ']') +char(13) + char(10) + 'AS' ,@CompleteViewText,1))) 

--SET @SqlViewText = (select top 1 substring(view_definition,charindex(rtrim('[' + @ViewName + ']') + char(13) + char(10) + 'AS' ,view_definition,1) + len(rtrim('[' + @ViewName + ']') +char(13) + char(10) + 'AS' ) + 1,len(view_definition) - len(charindex(rtrim('[' + @ViewName + ']') +char(13) + char(10) + 'AS' ,view_definition,1))) from INFORMATION_SCHEMA.VIEWS where table_name = rtrim(@ViewName) order by table_schema desc) 

-- wrap the select statement in the openquery with an outer select statement to handle the filtering and paging on the link server.
-- otherwise result set could be very large and cause performance issues as well as consume bandwidth unnecessarily
set @InsertSelectBegin = charindex('SELECT', @SqlViewText, charindex('openquery', @SqlViewText))
set @ParseLeft = substring(@SqlViewText, 1, @InsertSelectBegin-1)
set @ParseRight = substring(@SqlViewText, @InsertSelectBegin, len(@SqlViewText))
set @SqlViewText = @ParseLeft + 'SELECT * FROM (' + @ParseRight
set @CountSelect = @ParseLeft + 'SELECT COUNT(*) FROM (' + @ParseRight

--Now find last occurance of FROM before closing parenth
set @Fromlocation = len(@SqlViewText) - charindex(' morf',reverse(@SqlViewText))
set @ParseLeft = substring(@SqlviewText,1, @FromLocation - 5) 
set @ParseLeft = @ParseLeft + ', row_number() OVER (ORDER BY ' + @OrderBy + ') AS row '
set @ParseLeft = @ParseLeft + substring(@SqlViewText, @FromLocation - 4, len(@SqlViewText)) 

set @SqlViewText = @ParseLeft
set @LastOccurance = charindex(')''', reverse(@ParseLeft))
set @ParseLeft = substring(@ParseLeft, 1, len(@SqlViewText)-@LastOccurance-1)
set @LastOccuranceCountQuery = charindex(')''', reverse(@CountSelect))
set @ParseCountQuery = substring(@CountSelect, 1, len(@CountSelect)-@LastOccuranceCountQuery-1)
set @SqlViewText = @ParseLeft + ' WHERE ' + replace(@InnerWhereClause,'''' , '''''' ) + ') InnerQuery ' + @PagingWhereClause + ' '')'
set @CountSelect = @ParseCountQuery + ' WHERE ' + replace(@InnerWhereClause,'''' , '''''' ) + ') InnerQuery '')'

set @SqlViewText = @SqlViewText + ' where 1=1 and'
--set @CountSelect = @CountSelect + ' where 1=1 and'

if @SecurityWhereClause <> '' 
begin
	set @SqlViewText = @SqlViewText + @SecurityWhereClause
	--set @CountSelect = @CountSelect + @SecurityWhereClause
end

set @SqlViewText = substring(@SqlViewText,1,len(@SqlViewText)-4) 
--set @CountSelect = substring(@CountSelect,1,len(@CountSelect)-4) 

set @SqlViewText = ' (' + @SqlViewText + ') SQLView '
--print @SqlViewText

SET @SQLExec = 'SELECT ' + @ColumnNames + ' FROM ' + @SqlViewText

--print @Sqlexec
EXEC (@SQLExec)

IF (ISNULL(@GetTotalResults,0) = 1)
BEGIN
	EXEC (@CountSelect)
	--print (@CountSelect)
END
ELSE
BEGIN
	--return a blank table so that the resulting dataset still has 2 tables
	SELECT 0 FROM sysobjects WHERE 1 = 0
END
