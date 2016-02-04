
CREATE Procedure [dbo].[uspFormQuickListGetAutofillMatchRanking]
@AutofillTable varchar(50),
@MaxNumberOfRowsToReturn varchar(2) = '3',
@Rank1Name varchar(50),
@Rank1Value varchar(2000),
@Rank2Name varchar(50) = '',
@Rank2Value varchar(2000) = '',
@Rank3Name varchar(50) = '',
@Rank3Value varchar(2000) = '',
@Rank4Name varchar(50) = '',
@Rank4Value varchar(2000) = '',
@Rank5Name varchar(50) = '',
@Rank5Value varchar(2000) = '',
@Rank6Name varchar(50) = '',
@Rank6Value varchar(2000) = ''

as

Declare @CaseStatement varchar(1000),
	@OrStatement varchar(1000),
	@OrderByStatement varchar(1000),
	@SQL varchar(4000),
	@Quote varchar(3)

Set @SQL = ''
Set @CaseStatement = ''
Set @OrStatement = ''
Set @OrderByStatement = ''
Set @Quote = Char(39) 

If Len(LTRim(RTrim(@Rank1Name))) > 0 
begin

	If Exists(	Select 	[ID] 
			From	syscolumns
			where 	[ID] = Object_ID(@AutofillTable)
			and	RTrim(LTrim(Upper([Name]))) = RTrim(LTrim(Upper(@Rank1Name))))
	begin

		/* Begin building our internal rank value to show all of the matches with a point score */
		Set @CaseStatement = ' , Rank1 = Case When ISNULL([' + @Rank1Name + '], '''') = ' + @Quote + @Rank1Value + @Quote + ' then 10 else 0 end ' + Char(13)
	
		/* Build an order by statement to create a hitlist in order of matching variables */
		Set @OrderByStatement = 'Rank1 '
	
		/* Build the end of our query string so that we will have a match on the actual autofill info */
		Set @OrStatement = 'or [' + @Rank1Name + '] = ' + @Quote + @Rank1Value + @Quote + ' ' + Char(13)
	end
end

If Len(LTRim(RTrim(@Rank2Name))) > 0 
begin

	If Exists(	Select 	[ID] 
			From	syscolumns
			where 	[ID] = Object_ID(@AutofillTable)
			and	RTrim(LTrim(Upper([Name]))) = RTrim(LTrim(Upper(@Rank2Name))))
	begin

		Set @CaseStatement = @CaseStatement + ' , Rank2 = Case When ISNULL([' + @Rank2Name + '], '''') = ' + @Quote + @Rank2Value + @Quote + ' then 9 else 0 end ' + Char(13)
		
		If Len(@OrderByStatement) = 0 
		begin
			Set @OrderByStatement = @OrderByStatement + ' Rank2 '
		end
		Else
		begin
			Set @OrderByStatement = @OrderByStatement + '+ Rank2 '
		end
	
		Set @OrStatement = @OrStatement + 'or [' + @Rank2Name + '] = ' + @Quote + @Rank2Value + @Quote + ' ' + Char(13)
	end
end

If Len(LTRim(RTrim(@Rank3Name))) > 0 
begin

	If Exists(	Select 	[ID] 
			From	syscolumns
			where 	[ID] = Object_ID(@AutofillTable)
			and	RTrim(LTrim(Upper([Name]))) = RTrim(LTrim(Upper(@Rank3Name))))
	begin	
		Set @CaseStatement = @CaseStatement + ' , Rank3 = Case When ISNULL([' + @Rank3Name + '], '''') = ' + @Quote + @Rank3Value + @Quote + ' then 8 else 0 end ' + Char(13)
		
		If Len(@OrderByStatement) = 0 
		begin
			Set @OrderByStatement = @OrderByStatement + ' Rank3 '
		end
		Else
		begin
			Set @OrderByStatement = @OrderByStatement + '+ Rank3 '
		end
	
		Set @OrStatement = @OrStatement + 'or [' + @Rank3Name + '] = ' + @Quote + @Rank3Value + @Quote + ' ' + Char(13)
	end
end

--If Len(LTRim(RTrim(@Rank4Name))) > 0 
--begin
--	If Exists(	Select 	[ID] 
--			From	syscolumns
--			where 	[ID] = Object_ID(@AutofillTable)
--			and	RTrim(LTrim(Upper([Name]))) = RTrim(LTrim(Upper(@Rank4Name))))
--	begin

--		Set @CaseStatement = @CaseStatement + ' , Rank4 = Case When ISNULL([' + @Rank4Name + '], '''') = ' + @Quote + @Rank4Value + @Quote + ' then 7 else 0 end ' + Char(13)
	
--		If Len(@OrderByStatement) = 0 
--		begin
--			Set @OrderByStatement = @OrderByStatement + ' Rank4 '
--		end
--		Else
--		begin
--			Set @OrderByStatement = @OrderByStatement + '+ Rank4 '
--		end
	
--		Set @OrStatement = @OrStatement + 'or [' + @Rank4Name + '] = ' + @Quote + @Rank4Value + @Quote + ' ' + Char(13)
--	end
--end


--If Len(LTRim(RTrim(@Rank5Name))) > 0 
--begin
--	If Exists(	Select 	[ID] 
--			From	syscolumns
--			where 	[ID] = Object_ID(@AutofillTable)
--			and	RTrim(LTrim(Upper([Name]))) = RTrim(LTrim(Upper(@Rank5Name))))
--	begin
--		Set @CaseStatement = @CaseStatement + ' , Rank5 = Case When ISNULL([' + @Rank5Name + '], '''') = ' + @Quote + @Rank5Value + @Quote + ' then 6 else 0 end ' + Char(13)
	
--		If Len(@OrderByStatement) = 0 
--		begin
--			Set @OrderByStatement = @OrderByStatement + ' Rank5 '
--		end
--		Else
--		begin
--			Set @OrderByStatement = @OrderByStatement + '+ Rank5 '
--		end
	
--		Set @OrStatement = @OrStatement + 'or [' + @Rank5Name + '] = ' + @Quote + @Rank5Value + @Quote + ' ' + Char(13)
--	end
--end

--If Len(LTRim(RTrim(@Rank6Name))) > 0 
--begin

--	If Exists(	Select 	[ID] 
--			From	syscolumns
--			where 	[ID] = Object_ID(@AutofillTable)
--			and	RTrim(LTrim(Upper([Name]))) = RTrim(LTrim(Upper(@Rank6Name))))
--	begin
--		Set @CaseStatement = @CaseStatement + ' , Rank6 = Case When ISNULL([' + @Rank6Name + '], '''') = ' + @Quote + @Rank6Value + @Quote + ' then 5 else 0 end ' + Char(13)
	
--		If Len(@OrderByStatement) = 0 
--		begin
--			Set @OrderByStatement = @OrderByStatement + ' Rank6 '
--		end
--		Else
--		begin
--			Set @OrderByStatement = @OrderByStatement + '+ Rank6 '
--		end
	
--		Set @OrStatement = @OrStatement + 'or [' + @Rank6Name + '] = ' + @Quote + @Rank6Value + @Quote + ' ' + Char(13)
--	end
--end

Set @SQL =  'Select Top '  + @MaxNumberOfRowsToReturn + ' * , ' + Char(13)
Set @SQL = @SQL + ' TotalRanking = ' + @OrderByStatement + Char(13)
Set @SQL = @SQL + ' from (' + Char(13)
Set @SQL = @SQL + ' select ' + @AutofillTable + '.* ' + Char(13)
Set @SQL = @SQL + @CaseStatement
Set @SQL = @SQL + ' From ' + @AutofillTable + Char(13) + ' with (nolock) '
Set @SQL = @SQL + ' Where 1 = 2 ' + Char(13)
Set @SQL = @SQL + @OrStatement
Set @SQL = @SQL + ') innerds ' + Char(13)
--Set @SQL = @SQL + 'inner join ' + gsAutofillKeywordTable + ' on ' + gsAutofillKeywordTable + '.[' + pkField + '] = innerds.[' + pkField + ']' + Char(13)
Set @SQL = @SQL + ' order by (' + @OrderByStatement + ') desc'
exec (@SQL)








