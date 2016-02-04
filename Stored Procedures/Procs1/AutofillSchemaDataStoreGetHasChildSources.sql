
-- [AutofillSchemaDataStoreGetHasChildSources] 10

create PROCEDURE [dbo].[AutofillSchemaDataStoreGetHasChildSources] 
(	
	@pkAutofillSchemaDataStore decimal = 0
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	select	count (*) from autofillschema where fkAutofillSchemaDataStore
		= @pkAutofillSchemaDataStore
	
END
