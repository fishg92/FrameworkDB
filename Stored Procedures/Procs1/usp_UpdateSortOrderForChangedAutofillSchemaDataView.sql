
-- [UpdateSortOrderForChangedAutofillSchemaDataView]  '8/3/2010 8:00 AM', 13920
CREATE procedure [dbo].[usp_UpdateSortOrderForChangedAutofillSchemaDataView]
(@DateBeforeParentUpdated datetime
,@fkAutofillSchemaDataView decimal
)
as
set nocount on
set transaction isolation level read uncommitted


--set @DateBeforeParentUpdated = '8/3/2010 8:00 AM'
--set @fkAutofillSchemaDataView  = 13920
DECLARE @CurrentColumns TABLE 
( 
    pkAutofillSchemaDataViewColumns decimal
    ,fkAutofillSchemaColumns decimal
--	,SortOrder Integer
	,SortOrdernew Integer
	,FieldNameCurrent varchar(150)
	,FieldNamePrevious varchar(150)

)

insert into @CurrentColumns
select pkAutofillSchemaDataViewColumns
, fkAutofillSchemaColumns
--, SortOrder
, SortOrder 
, isnull((select FieldName from AutofillSchemaColumns where pkAutofillSchemaColumns = fkAutofillSchemaColumns),'')
, dbo.fnGetAutoFillSchemaColumnName (fkAutofillSchemaColumns ,@DateBeforeParentUpdated)
 from AutofillSchemaDataViewColumns
where fkAutofillSchemaDataView = @fkAutofillSchemaDataView 
order by pkAutofillSchemaDataViewColumns

DECLARE db_cursor CURSOR FOR 
select pkAutofillSchemaDataViewColumns
, fkAutofillSchemaColumns
--, SortOrder
, SortOrderNew
, FieldNameCurrent
,FieldNamePRevious
 from @CurrentColumns

declare @pkAutopkAutofillSchemaDataViewColumnsCURSOR decimal
declare @fkAutofillSchemaColumnsCURSOR decimal
--declare @SortOrderCURSOR integer
declare @SortOrderNewCursor integer
declare @FieldNameCurrentCursor varchar(150)
declare @FieldNamePreviousCURSOR varchar(16)
/* Re-establish original sort order for fields that existed previously */
/* FieldnameCurrent and FieldNamePrevious are necessary because fk-pk relationship may have changed */
/*
FETCH NEXT FROM db_cursor INTO  @pkAutopkAutofillSchemaDataViewColumnsCURSOR,@fkAutofillSchemaColumnsCURSOR, @SortOrderCURSOR, @SortOrderNewCURSOR, @FieldNameCurrentCURSOR, @FieldNamePreviousCURSOR 


WHILE @@FETCH_STATUS = 0  
BEGIN  
    declare @PreviousSortOrder integer
	set @PreviousSortOrder = dbo.fnGetAutoFillSchemaDataViewColumnSortOrderByName(@FieldNamePreviousCursor,@DateBeforeParentUpdated,@fkAutofillSchemaDataView)
	declare @NewSortOrder integer 
	set @NewSortOrder = @PreviousSortOrder
	
	update @CurrentColumns set SortOrderNew = @NewSortOrder
		where FieldNameCurrent = @FieldNamePreviousCursor

FETCH NEXT FROM db_cursor INTO  @pkAutopkAutofillSchemaDataViewColumnsCURSOR,@fkAutofillSchemaColumnsCURSOR, @SortOrderCURSOR, @SortOrderNewCURSOR, @FieldNameCurrentCURSOR, @FieldNamePreviousCURSOR 
END  
	
CLOSE db_cursor  
*/

declare @CurrentMax integer
select @CurrentMax = max(SortOrderNew) from @CurrentColumns

/* Assign sequential indexes to new columns (columns with default zero in sort order col*/
OPEN db_cursor  
FETCH NEXT FROM db_cursor INTO  @pkAutopkAutofillSchemaDataViewColumnsCURSOR,@fkAutofillSchemaColumnsCURSOR,  @SortOrderNewCURSOR, @FieldNameCurrentCURSOR, @FieldNamePreviousCURSOR 
WHILE @@FETCH_STATUS = 0  
BEGIN  
	set @CurrentMax = @CurrentMax + 1
	update @CurrentColumns set SortOrdernew = @CurrentMax
		where SortOrderNew = 0 
		and pkAutofillSchemaDataViewColumns = @pkAutopkAutofillSchemaDataViewColumnsCURSOR

FETCH NEXT FROM db_cursor INTO  @pkAutopkAutofillSchemaDataViewColumnsCURSOR,@fkAutofillSchemaColumnsCURSOR, @SortOrderNewCURSOR, @FieldNameCurrentCURSOR, @FieldNamePreviousCURSOR 

END  
CLOSE db_cursor  

DEALLOCATE db_cursor



declare @SortCounter int
set @SortCounter = 0
declare @TotalItems int

set @TotalItems = (select count(*) from @CurrentColumns)


/* fix holes in integer sequence */
While @SortCounter <= @TotalItems 
BEGIN
	set @SortCounter = @SortCounter + 1
	update @CurrentColumns set SortOrderNew  = @SortCounter
	where SortOrderNew = (
	 select min(SortOrderNew) from @CurrentColumns where
		SortOrderNew >= @SortCounter )
END

update AutofillSchemaDataViewColumns
set SortOrder = t2.SortOrderNew
from AutofillSchemaDataViewColumns t1 inner join @CurrentColumns t2
on t1.pkAutofillSchemaDataViewColumns =t2.pkAutofillSchemaDataViewColumns
