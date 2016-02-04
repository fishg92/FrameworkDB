











--drop table ##Result_Final
--select * from ##result_final

/*
exec FindRefIntegrityErrors '%ActiveApplication%'
select * from ##Cursortemp
*/

Create PROC [dbo].[FindRefIntegrityErrors]
@PickTable varchar (100) = null
as
set nocount OFF
--Setup
If Object_Id('tempdb.dbo.##cursortemp') is Not Null
BEGIN	
	drop table ##cursortemp
END

If Object_Id('tempdb.dbo.##result_final') is Not Null
BEGIN	
	drop table ##result_final
END

If Object_Id('tempdb.dbo.#temptableNulls') is Not Null
BEGIN	
	drop table #temptableNulls
END

If Object_Id('tempdb.dbo.#Result_Test') is Not Null
BEGIN	
	drop table #Result_Test
END

If Object_Id('tempdb.dbo.#Error') is Not Null
BEGIN	
	drop table #Result_Test
END

--create temp table to house the temporary info


Create table #Error 
(
Error_Message  varchar (500)
)


Create table #Result_Test 
(
Result_Test  varchar (100)
,ColumnName varchar (250)
,TableName  varchar (250)
)

Create table ##Result_Final 
(
Result_Test  varchar (100)
,ColumnName varchar (250)
,TableName  varchar (250)
)

--get all tables and views 
SELECT 
name as TableName
, 0 as ColumnCount -- initialized to 0
into #temptableNulls
FROM sys.Tables (nolock)
where is_ms_shipped = 0 --dont care about ms crap

union

select  
name as TableName
, 0 as ColumnCount --initialized to 0
FROM sysobjects so (nolock) 
INNER JOIN syscomments sc (nolock) ON so.id = sc.id
where xtype = 'V' --views only
order by Tablename

--Optional Argument now handles %
If @Picktable is not null
	begin
		set @Picktable = REPLACE ( @Picktable , 'dbo.' , '' )
		select * into #temp2 from #temptablenulls
		where Tablename like @Picktable
		delete from #temptableNulls
		Insert into #temptableNulls (tableName, ColumnCount)
		select tableName, ColumnCount from #temp2 
	End
--get number of columns in each table
update #temptableNulls
set Columncount = 
 (select count(*)  from SYSCOLUMNS (nolock) where id=
	(select id from SYSOBJECTS (nolock) where name= TableName))

declare @TableName as varchar(250)
declare TableList cursor for
  select TableName from #temptableNulls
	OPEN TableList
	FETCH NEXT FROM TableList 
	INTO @TableName
	WHILE @@FETCH_STATUS = 0
	BEGIN

---Looping Cursor to work through each table and column

	declare @tempColumnName as varchar (250)
	declare @tempTableName as varchar (250)
	declare @counter int
	set @counter = 0
	--while we have columns left in the table, keep looping
	while @counter <= (Select ColumnCount from #tempTableNulls where TableName = @TableName)
		begin
			set @counter = @counter + 1
			
			--Obtain column name from column position 
			declare @Columnname as varchar (250)
			select @Columnname = sc.name 
			from sys.objects as so inner join sys.syscolumns as sc on so.object_id = sc.id
			inner join #temptableNulls t on t.TableName = so.name
			where so.name = t.TableName and sc.colid = @counter
			and t.tableName = @TableName
			
			--Can you believe people still use spaces in their column names? I'm looking at you EZFormLookup! =)
			set @tempColumnName = '[' + @ColumnName + ']'


			declare @tempTableNameNoBrackets varchar (250)
			set @tempColumnName = '[' + @ColumnName + ']'
			set @tempTableName = Replace(@TempColumnName, '[fk', '[')
			set @tempTableNameNoBrackets = Replace(@tempTableName, '[', '')
			set @tempTableNameNoBrackets = Replace(@tempTableNameNoBrackets, ']', '')
			
			declare @Test as varchar (250)
			declare @ScheduleItemTest as varchar (15)
			set @scheduleItemTest = substring(@tempColumnName, 2,14)
-------------This section tries to handle situations that dont play nice with the pkTABLENAME /fkTABLENAME setup
--We use fkDept instead of fkrefDepartment as a key
If @tempColumnName = '[fkDept]' or @TempTableName = '[refDepartmentFilter]'
	Begin
	set @TempTableName = '[refDepartment]' 
	set @tempTableNameNoBrackets = 'refDepartment'
	End
If @tempColumnName = '[fkRole]'
	Begin
		set @TempTableName = '[refRole]'
		set @tempTableNameNoBrackets = 'refRole'
	End
If @tempColumnName = '[fkCase]'
	Begin
		set @TempTableName = '[ClientCase]'
		set @tempTableNameNoBrackets = 'ClientCase'
	End
If @tempColumnName = '[fkAppointmentType]' or @tempColumnName = '[fkrefAppointmentTypeOverride]' or @tempColumnName = '[fkAppointmentTypeRRRMSecondary]' or  @tempColumnName = '[fkAppointmentTypeSecondary]' or @tempColumnName = '[fkrefAppointmentTypeSecondary]' or @tempColumnName = '[fkrefAppointmentTypeRRRMSecondary]'
	Begin
		set @TempTableName = '[refAppointmentType]'
		set @tempTableNameNoBrackets = 'refAppointmentType'
	End
If @tempColumnName = '[fkUser]' or @tempColumnName = '[fkApplicationUserSelect]' or @tempColumnName = '[fkApplicationUserLikely]' or @tempColumnName = '[fkApplicationUserLoggedOn]' or @tempColumnName = '[fkApplicationUserProxy]' or @tempColumnName = '[fkProxyUser]' or @TempTableName = '[ApplicationUserFilter]' or @TempTableName = '[fkApplicationUserRepresentingThisDepartment]' 
	Begin
		set @TempTableName = '[ApplicationUser]' 
		set @tempTableNameNoBrackets = 'ApplicationUser'
	End
If @tempColumnName = '[fkJITGroup]' or @tempColumnName = '[fkGroup]' or @TempTableName = '[refGroupFilter]'
	Begin
		set @TempTableName = '[refGroup]'
		set @tempTableNameNoBrackets = 'refGroup'
	End
If @tempColumnName = '[fkCalendarEvent]' 
	Begin
		set @TempTableName = '[CalendarEvents]'
		set @tempTableNameNoBrackets = 'CalendarEvents'
	End
If @tempColumnName = '[fkQueueItemType]' or @tempColumnName = '[fkQueueItemTypeRepresentingThisDepartment]' 
	Begin
		set @TempTableName = '[refQueueItemType]'
		set @tempTableNameNoBrackets = 'refQueueItemType'
	End

If @tempColumnName = '[fkScheduleItem]' 
	Begin
		set @TempTableName = '[Scheduleitem] si union  select pkscheduleitem from [asDeletedScheduleItem]   '
		set @tempTableNameNoBrackets = 'scheduleitem'
	End
-------------------------------------------------------------------------------------------------------------			
			set @Test = substring(@tempColumnName,2,2)
			If  @Test = 'fk' and @scheduleItemTest <> 'fkScheduleItem' --We are only Testing foriegn keys
					begin
					declare @sql as varchar (1200)
					set @sql = 
					'select distinct '+ @TempColumnName + 'as Result_test 
					into ##CursorTemp 
					from ' + @tableName + ' 
					where '+ @TempcolumnName + ' ' + ' not in 
						(select [pk'+ @tempTableNameNoBrackets +'] from '+  @tempTableName+ ')

					INSERT INTO #Result_Test (Result_Test, ColumnName, TableName)
					select Result_test as Result_test
					, ''' + @TableName + ''' as TableColumn
					, ''' + @tempColumnname + ''' as ColumnName
					from ##CursorTemp'

					BEGIN TRY
						exec (@SQL)
					END TRY
					BEGIN CATCH
						declare @Error As varchar (500)
						set @Error = (Select 'I looked in the "' + @TableName + '" table, with the column name ' + @TempColumnName + '.  I could not find table '+ @tempTableName +' to key this column against in this database.')
						Insert Into #Error (Error_Message)
							Select @Error
					END CATCH

					
					If Object_Id('tempdb.dbo.##cursortemp') is Not Null
						BEGIN	
							drop table ##cursortemp
						END
					end					
			end

			--Drop this crap into the final results table, then kill the temp table, advance to the next table
			Insert Into ##Result_Final (Result_Test, ColumnName, Tablename)
				Select distinct Result_Test, TableName, ColumnName from #Result_Test
	
	truncate table #result_Test
	
	
	FETCH NEXT FROM TableList 
	    INTO @TableName
	END
	CLOSE TableList
	DEALLOCATE TableList
--Tidy up our dataset
update ##Result_Final
set Columnname = Replace(ColumnName, ']', ''),
TableName = Replace(TableName, ']', '')
update ##Result_Final
set Columnname = Replace(ColumnName, '[', ''),
TableName = Replace(TableName, '[', '')
Select * from ##Result_Final (nolock)
--drop table ##result_final
Select * from #Error

If Object_Id('tempdb.dbo.##result_final') is Not Null
BEGIN	
	drop table ##result_final
END








