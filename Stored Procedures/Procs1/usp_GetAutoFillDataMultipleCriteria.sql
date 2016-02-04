
/*
[usp_GetAutoFillDataMultipleCriteria] 3, '<row itemKey="Last Name" itemValue="n" />', 25
*/
CREATE PROC [dbo].[usp_GetAutoFillDataMultipleCriteria]
(
	@DataViewID int
	, @KeywordNameValuePairs as XML
	, @MaxResults int
	, @OrderBy varchar(100) = ''
	, @pkApplicationUser decimal = -1
)
AS
DECLARE @KeywordName varchar(max)
DECLARE @KeywordValue varchar(max)
DECLARE @SecurityWhereClause varchar(max)
DECLARE @ViewName varchar(255)
DECLARE @SQLExec varchar(max)
DECLARE @SqlExecNew varchar(max)
DECLARE @IgnoreProgramTypeSecurity tinyint
DECLARE @IgnoreSecuredClientSecurity tinyint

set @KeyWordValue = ''
set @SecurityWhereClause = ''
set @IgnoreProgramTypeSecurity = 0
set @IgnoreSecuredClientSecurity = 0

SELECT @ViewName = dbo.fnGetAutoFillViewName(@DataViewID)

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

--set @SqlExecnew = (select top 1 substring(view_definition,charindex(rtrim('[' + @ViewName + ']') + char(13) + char(10) + 'AS' ,view_definition,1) + len(rtrim('[' + @ViewName + ']') +char(13) + char(10) + 'AS' ) + 1,len(view_definition) - len(charindex(rtrim('[' + @ViewName + ']') +char(13) + char(10) + 'AS' ,view_definition,1))) from INFORMATION_SCHEMA.VIEWS where table_name = rtrim(@ViewName) order by table_schema desc) 

-- check to see if openquery is in the query definition. If so then call the CrossServer proc instead.
if charindex('openquery', @SQLExecNew) <> 0
begin
	exec usp_GetAutoFillDataMultipleCriteria_CrossServer @DataViewID, @KeywordNameValuePairs, @MaxResults, @OrderBy, @pkApplicationUser
end
else
Begin

If @Maxresults < 0
	BEGIN
		SET @Maxresults = 100
	END

-- Get View Name

if exists (select * from AutoFillDataView where pkAutoFillDataView = @DataViewID) BEGIN
	select @IgnoreProgramTypeSecurity = isnull(IgnoreProgramTypeSecurity,0)
		,@IgnoreSecuredClientSecurity = isnull(IgnoreSecuredClientSecurity,0)
			from AutoFillDataView where
		pkAutoFillDataView = @DataViewID
END
--print @ViewName

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

SET @SQLExec = 'SELECT TOP ' + CONVERT(varchar(25), @MaxResults) 
	+ ' * FROM ' + '(' + @SqlExecNew + ') SQLView ' + ' WHERE '
--print @ViewName

--SET @SQLExec = (select top 1 substring(view_definition,charindex(rtrim('[' + @ViewName + ']') + char(13) + char(10) + 'AS' ,view_definition,1) + len(rtrim('[' + @ViewName + ']') +char(13) + char(10) + 'AS' ) + 1,len(view_definition) - len(charindex(rtrim('[' + @ViewName + ']') +char(13) + char(10) + 'AS' ,view_definition,1))) from INFORMATION_SCHEMA.VIEWS where table_name = rtrim(@ViewName) order by table_schema desc) 
--set @SQLExec = 'SELECT TOP ' + CONVERT(varchar(25), @MaxResults)  + ' ' + substring(@SQLExec,10,len(@SQLExec)-10) + ' WHERE '

--print @sqlexec
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
--print 'dbo.ColumnAlreadyExistsInView(' + @ViewName + ' , ' + @KeywordName + ')'
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

			SELECT @OrderBy = 
				CASE @OrderBy
				WHEN '' THEN  @KeywordName
				ELSE  @OrderBy
			END

				SET @SQLExec = @SQLExec +  @KeywordName + ' LIKE ''' 
					+ @KeywordValue + '%''' + ' and '

	Fetch NEXT FROM CriteriaCursor INTO @itemKey, @itemValue
END
CLOSE CriteriaCursor
DEALLOCATE CriteriaCursor

set @SQLExec = substring(@SQLExec,1,len(@SQLExec)-4) + ' order by ' + @Orderby


--print @sqlexec
EXEC(@SQLExec)
end
