----------------------------------------------------------------------------
-- Select a single record from AutofillSchemaDataStore
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspAutofillSchemaDataStoreSelect]
(	@pkAutofillSchemaDataStore decimal(18, 0) = NULL,
	@FriendlyName varchar(200) = NULL,
	@fkrefAutofillSchemaDataSourceType decimal(18, 0) = NULL
)
AS

SELECT	pkAutofillSchemaDataStore,
	FriendlyName,
	fkrefAutofillSchemaDataSourceType
FROM	AutofillSchemaDataStore
WHERE 	(@pkAutofillSchemaDataStore IS NULL OR pkAutofillSchemaDataStore = @pkAutofillSchemaDataStore)
 AND 	(@FriendlyName IS NULL OR FriendlyName LIKE @FriendlyName + '%')
 AND 	(@fkrefAutofillSchemaDataSourceType IS NULL OR fkrefAutofillSchemaDataSourceType = @fkrefAutofillSchemaDataSourceType)
