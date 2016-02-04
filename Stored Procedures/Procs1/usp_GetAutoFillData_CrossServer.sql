
--usp_GetAutoFillData_CrossServer 3,'Last Name','t',25

CREATE PROC [dbo].[usp_GetAutoFillData_CrossServer]
(
	@DataViewID int
	, @KeywordName varchar(100)
	, @KeywordValue varchar(100)
	, @MaxResults int
	, @OrderBy varchar(100) = ''
	, @pkApplicationUser decimal = -1
)
AS
DECLARE @IgnoreProgramTypeSecurity tinyint
DECLARE @IgnoreSecuredClientSecurity tinyint
DECLARE @WhereClause nvarchar(max)
DECLARE @SecurityWhereClause varchar(max)
Declare @ParseLeft varchar(max)
DECLARE @SQLExec varchar(max)
DECLARE @SqlViewText varchar(max)
Declare @LastOccurance int

set @SecurityWhereClause = ''
set @IgnoreProgramTypeSecurity = 0
set @IgnoreSecuredClientSecurity = 0

if exists (select * from AutoFillDataView where pkAutoFillDataView = @DataViewID) BEGIN
	select @IgnoreProgramTypeSecurity = isnull(IgnoreProgramTypeSecurity,0)
		,@IgnoreSecuredClientSecurity = isnull(IgnoreSecuredClientSecurity,0)
			from AutoFillDataView where
		pkAutoFillDataView = @DataViewID
END

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

	--Cannot apply security if ProgramTypeID is not part of select list
	IF dbo.ColumnAlreadyExistsInView(@ViewName, 'ProgramTypeID') <> 1 BEGIN
		set	@IgnoreProgramTypeSecurity = 1
		set @IgnoreSecuredClientSecurity = 1
	END
	IF dbo.ColumnAlreadyExistsInView(@ViewName, 'pkCpClient') <> 1 BEGIN
		set @IgnoreSecuredClientSecurity = 1
	END
	
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
	WHEN '' THEN ' ORDER BY ' + @KeywordName
	ELSE ' ORDER BY ' + @OrderBy
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

--set @SqlViewText = (select top 1 substring(view_definition,charindex(rtrim('[' + @ViewName + ']') + char(13) + char(10) + 'AS' ,view_definition,1) + len(rtrim('[' + @ViewName + ']') +char(13) + char(10) + 'AS' ) + 1,len(view_definition) - len(charindex(rtrim('[' + @ViewName + ']') +char(13) + char(10) + 'AS' ,view_definition,1))) from INFORMATION_SCHEMA.VIEWS where table_name = rtrim(@ViewName) order by table_schema desc) 

-- moved the where clause into the select statement passed to openquery to handle the filtering on the link server.
-- otherwise result set could be very large and cause performance issues as well as consume bandwidth unnecessarily
set @LastOccurance = charindex(')''', reverse(@SqlViewText))
set @ParseLeft = substring(@SqlViewText, 1, len(@SqlViewText)-@LastOccurance-1)
set @WhereClause =  'Where ' + @KeywordName + ' LIKE ''' + @KeywordValue + '%'''

if len(ltrim(rtrim(@KeywordValue))) = 0 BEGIN
	SET @WhereClause = @WhereClause + ' and 1 = 2 '
END

set @SqlViewText = @ParseLeft + ' ' + replace(@WhereClause,'''' , '''''' ) + ''')'

set @SqlViewText = @SqlViewText + ' where 1=1 and'

-- extracted text of underlyng security filtering into separate function for portability to other procs
set @SecurityWhereClause = dbo.fnGetAutoFillSecurityWhereClause(@IgnoreProgramTypeSecurity, @IgnoreSecuredClientSecurity, @pkApplicationUser)

if @SecurityWhereClause <> '' 
begin
	set @SqlViewText = @SqlViewText + @SecurityWhereClause	
end

set @SqlViewText = substring(@SqlViewText,1,len(@SqlViewText)-4) 

SET @SQLExec = 'SELECT TOP ' + CONVERT(varchar(100), @MaxResults) 
	+ ' * FROM ' + '(' + @SqlViewText + ') SQLViewAlias '

SET @SQLExec = @SQLExec + @OrderBy

--print @sqlexec

EXEC(@SQLExec)
