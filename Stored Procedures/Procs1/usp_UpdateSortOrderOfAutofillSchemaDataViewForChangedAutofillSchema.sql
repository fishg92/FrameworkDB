-- [UpdateSortOrderOfAutofillSchemaDataViewForChangedAutofillSchema]  '8/3/2010 8:00 AM',971
CREATE procedure [dbo].[usp_UpdateSortOrderOfAutofillSchemaDataViewForChangedAutofillSchema]
(@DateBeforeParentUpdated datetime
,@fkAutofillSchema decimal
)
as
set nocount on
set transaction isolation level read uncommitted

--set @DateBeforeParentUpdated = '8/3/2010 8:00 AM'
--set @fkAutofillSchemaDataView  = 13920
DECLARE db_cursorOuter CURSOR FOR 
select pkAutofillSchemaDataView
 from AutofillSchemaDataView
where fkAutofillSchema = @fkAutofillSchema

OPEN db_cursorOuter  
declare @pkAutopkAutofillSchema decimal
FETCH NEXT FROM db_cursorOuter INTO  @pkAutopkAutofillSchema

WHILE @@FETCH_STATUS = 0  
BEGIN  
	exec [usp_UpdateSortOrderForChangedAutofillSchemaDataView] @DateBeforeParentUpdated, @pkAutopkAutofillSchema
FETCH NEXT FROM db_cursorOuter INTO  @pkAutopkAutofillSchema
END  
	
CLOSE db_cursorOuter
DEALLOCATE db_cursorOuter

