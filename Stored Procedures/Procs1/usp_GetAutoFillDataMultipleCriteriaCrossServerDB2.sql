
/*
[usp_GetAutoFillDataMultipleCriteriaCrossServerDB2] 3, '<row itemKey="Last Name" itemValue="n" /><row itemKey="First Name" itemValue="t" />', 25
*/
create PROC [dbo].[usp_GetAutoFillDataMultipleCriteriaCrossServerDB2]
(
	@DataViewID int
	, @KeywordNameValuePairs as XML
	, @MaxResults int
	, @OrderBy varchar(100) = ''
	, @pkApplicationUser decimal = -1
)
AS

declare @UserCriteriaWhereClause varchar(max)
set @UserCriteriaWhereClause = ''
declare @KeywordName varchar(max)
declare @KeywordValue varchar(max)
set @KeyWordValue = ''

DECLARE @ViewName varchar(255)
DECLARE @SQLExecComplete varchar(max)
DECLARE @IgnoreProgramTypeSecurity tinyint
DECLARE @IgnoreSecuredClientSecurity tinyint
set  @IgnoreProgramTypeSecurity = 0
set @IgnoreSecuredClientSecurity = 0

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

DECLARE @SQLExecInner varchar(max)
--print @ViewName

set @SQLExecInner = (select top 1 substring(view_definition,charindex(rtrim('[' + @ViewName + ']') + char(13) + char(10) + 'AS' ,view_definition,1) + len(rtrim('[' + @ViewName + ']') +char(13) + char(10) + 'AS' ) + 1,len(view_definition) - len(charindex(rtrim('[' + @ViewName + ']') +char(13) + char(10) + 'AS' ,view_definition,1))) from INFORMATION_SCHEMA.VIEWS where table_name = rtrim(@ViewName) order by table_schema desc) 


/* Do we already have a WHERE clause in this view? Note, the need to do this will go away when autofill views are converted to being table-driven */
if charindex('WHERE',substring(@SQLExecInner,charindex('FROM ',@SQLExecInner,1),len(@SQLExecInner)-charindex('FROM ',@SQLExecInner,1)+1)) = 0 BEGIN
	set @SQLExecInner = @SQLExecInner + ' where 1=1 and'
END ELSE BEGIN
	set @SQLExecInner = @SQLExecInner + ' and'
END

if @IgnoreProgramTypeSecurity <> 1 BEGIN
	set @SQLExecInner = @SQLExecInner + ' ProgramTypeID in (select -1 union select fkProgramType from JoinApplicationUserProgramType where fkApplicationUser =  ' + cast(@pkApplicationUser as varchar(10)) + ') and'
END

if @IgnoreSecuredClientSecurity <> 1 BEGIN

set @SQLExecInner = @SQLExecInner + 
' 1 = case when 
		 not exists (select * from LockedEntity where fkCpClient = pkcpClient
					and fkProgramtype in (-1,ProgramTypeID))
			then 1
		when 
			exists ( Select *
								from 
									dbo.JoinApplicationUserSecureGroup JASG (nolock)
										inner join 
											(select * from LockedEntity where LockedEntity.fkCpClient = pkcpClient  
										and LockedEntity.fkProgramtype in (-1,ProgramTypeID)) ICL 
									on ICL.pkLockedEntity = JASG.fkLockedEntity
									Where JASG.fkApplicationUser = ' + cast(@pkApplicationUser as varchar(15)) + '
							   )
			then 1
		else
			0
	end and'

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


				set @UserCriteriaWhereClause = @UserCriteriaWhereClause + @KeywordName + ' LIKE ''' 
					+ @KeywordValue + '%''' + ' and '

	Fetch NEXT FROM CriteriaCursor INTO @itemKey, @itemValue
END
CLOSE CriteriaCursor
DEALLOCATE CriteriaCursor

set @SQLExecInner = @SQLExecInner + ' ' + @UserCriteriaWhereClause 

set @SQLExecInner = substring(@SQLExecInner,1,len(@SQLExecInner)-4) 

SET @SQLExecComplete = 'SELECT TOP ' + CONVERT(varchar(25), @MaxResults) 
	+ ' * FROM ' + '(' + @SQLExecInner + ') SQLView ' 

set @SQLExecComplete = @SQLExecComplete + ' order by ' + @Orderby


print @sqlexecComplete
EXEC(@SQLExecComplete)
