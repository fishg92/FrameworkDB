
/*
[usp_GetAutoFillDataMultipleCriteria_CrossServer] 5, '<row itemKey="Last Name" itemValue="t" /><row itemKey="First Name" itemValue="k" />', 25
*/
CREATE PROC [dbo].[usp_GetAutoFillDataMultipleCriteria_CrossServer]
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
DECLARE @ViewName varchar(255)
DECLARE @SQLExec varchar(max)
DECLARE @WhereClause nvarchar(max)
DECLARE @IgnoreProgramTypeSecurity tinyint
DECLARE @IgnoreSecuredClientSecurity tinyint
DECLARE @SecurityWhereClause varchar(max)
DECLARE @SqlViewText varchar(max)
DECLARE @LastOccurance int
Declare @ParseLeft varchar(max)

set @KeyWordValue = ''
set @SQLExec = ''
set @WhereClause = ''
set @IgnoreProgramTypeSecurity = 0
set @IgnoreSecuredClientSecurity = 0
set @SecurityWhereClause = ''

If @Maxresults < 0
	BEGIN
		SET @Maxresults = 100
	END

-- Get View Name
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

				SET @WhereClause = @WhereClause +  @KeywordName + ' LIKE ''' 
					+ @KeywordValue + '%''' + ' and '

	Fetch NEXT FROM CriteriaCursor INTO @itemKey, @itemValue
END
CLOSE CriteriaCursor
DEALLOCATE CriteriaCursor

set @WhereClause = substring(@WhereClause,1,len(@WhereClause)-4) 

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

--set @SqlViewText = (select top 1 substring(view_definition,charindex(rtrim('[' + @ViewName + ']') + char(13) + char(10) + 'AS' ,view_definition,1) + len(rtrim('[' + @ViewName + ']') +char(13) + char(10) + 'AS' ) + 1,len(view_definition) - len(charindex(rtrim('[' + @ViewName + ']') +char(13) + char(10) + 'AS' ,view_definition,1))) from INFORMATION_SCHEMA.VIEWS where table_name = rtrim(@ViewName) order by table_schema desc) 

-- moved the where clause into the select statement passed to openquery to handle the filtering on the link server.
-- otherwise result set could be very large and cause performance issues as well as consume bandwidth unnecessarily
set @LastOccurance = charindex(')''', reverse(@SqlViewText))
set @ParseLeft = substring(@SqlViewText, 1, len(@SqlViewText)-@LastOccurance-1)
set @SqlViewText = @ParseLeft + ' WHERE ' + replace(@WhereClause,'''' , '''''' ) + ''')'

set @SqlViewText = @SqlViewText + ' where 1=1 and'

-- extracted text of underlyng security filtering into separate function for portability to other procs
set @SecurityWhereClause = dbo.fnGetAutoFillSecurityWhereClause(@IgnoreProgramTypeSecurity, @IgnoreSecuredClientSecurity, @pkApplicationUser)

if @SecurityWhereClause <> '' 
begin
	set @SqlViewText = @SqlViewText + @SecurityWhereClause	
end

set @SqlViewText = substring(@SqlViewText,1,len(@SqlViewText)-4) 

SET @SQLExec = 'SELECT TOP ' + CONVERT(varchar(25), @MaxResults) 
	+ ' * FROM ' + '(' + @SqlViewText + ') SQLView order by ' + @Orderby

--print @sqlexec

EXEC(@SQLExec)
