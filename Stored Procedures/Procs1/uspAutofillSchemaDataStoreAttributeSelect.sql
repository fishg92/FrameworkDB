----------------------------------------------------------------------------
-- Select a single record from AutofillSchemaDataStoreAttribute
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspAutofillSchemaDataStoreAttributeSelect]
(	@pkAutofillSchemaDataStoreAttribute decimal(18, 0) = NULL,
	@fkAutofillSchemaDataStore decimal(18, 0) = NULL,
	@ItemKey varchar(100) = NULL,
	@ItemValue varchar(500) = NULL
)
AS

SELECT	pkAutofillSchemaDataStoreAttribute,
	fkAutofillSchemaDataStore,
	ItemKey,
	ItemValue
FROM	AutofillSchemaDataStoreAttribute
WHERE 	(@pkAutofillSchemaDataStoreAttribute IS NULL OR pkAutofillSchemaDataStoreAttribute = @pkAutofillSchemaDataStoreAttribute)
 AND 	(@fkAutofillSchemaDataStore IS NULL OR fkAutofillSchemaDataStore = @fkAutofillSchemaDataStore)
 AND 	(@ItemKey IS NULL OR ItemKey LIKE @ItemKey + '%')
 AND 	(@ItemValue IS NULL OR ItemValue LIKE @ItemValue + '%')
