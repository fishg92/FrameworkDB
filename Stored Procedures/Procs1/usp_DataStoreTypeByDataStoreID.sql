
/*
EXEC [usp_DataStoreTypeByDataStoreID] 1
*/

CREATE PROC [dbo].[usp_DataStoreTypeByDataStoreID]
(
	@pkAutofillSchemaDataStore decimal
)
AS
declare @returnValue decimal 

select  @returnValue = AutofillSchemaDataStore.fkrefAutofillSchemaDataSourceType   
	from AutofillSchemaDataStore
where pkAutofillSchemaDataStore = @pkAutofillSchemaDataStore

set @returnValue = isnull(@returnValue,1)

select @returnValue

SET ANSI_NULLS OFF
