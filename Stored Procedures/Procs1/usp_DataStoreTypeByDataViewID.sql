
/*
EXEC [usp_DataStoreTypeByDataViewID] 1
*/

CREATE PROC [dbo].[usp_DataStoreTypeByDataViewID]
(
	@pkAutofillSchemaDataView decimal
)
AS
declare @returnValue decimal 

select  @returnValue = AutofillSchemaDataStore.fkrefAutofillSchemaDataSourceType   
	from AutofillSchemaDataView
inner join AutofillSchema on
	fkAutofillSchema = pkAutofillSchema

inner join AutofillSchemadataStore on
	fkAutofillSchemaDataStore = pkAutofillSchemaDataStore 


where pkAutofillSchemaDataView = @pkAutofillSchemaDataView

set @returnValue = isnull(@returnValue,1)

select @returnValue

SET ANSI_NULLS OFF
