
-- [uspAutofillSchemaDataStoreComplete] 1

CREATE PROCEDURE [dbo].[uspAutofillSchemaDataStoreComplete] 
(	
	@pkAutofillSchemaDataStore decimal = 0
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	select	
		pkAutofillSchemaDataStore
		,FriendlyName
		,fkrefAutofillSchemaDataSourceType
	from
		autofillSchemaDataStore
	where
		pkAutofillSchemaDataStore = @pkAutofillSchemaDataStore
	
	select 
		pkAutofillSchemaDataStoreAttribute
		,fkAutofillSchemaDataStore
		,ItemKey
		,ItemValue
	from
		autofillschemadataStoreAttribute
	where 
		fkAutofillSchemaDataStore = @pkAutofillSchemaDataStore
	
END
