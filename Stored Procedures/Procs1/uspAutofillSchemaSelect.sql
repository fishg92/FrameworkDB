----------------------------------------------------------------------------
-- Select a single record from AutofillSchema
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspAutofillSchemaSelect]
(	@pkAutofillSchema decimal(18, 0) = NULL,
	@QueryText varchar(MAX) = NULL,
	@FriendlyName varchar(150) = NULL,
	@fkAutofillSchemaDataStore decimal(18, 0) = NULL
)
AS

SELECT	pkAutofillSchema,
	QueryText,
	FriendlyName,
	fkAutofillSchemaDataStore
FROM	AutofillSchema
WHERE 	(@pkAutofillSchema IS NULL OR pkAutofillSchema = @pkAutofillSchema)
 AND 	(@QueryText IS NULL OR QueryText LIKE @QueryText + '%')
 AND 	(@FriendlyName IS NULL OR FriendlyName LIKE @FriendlyName + '%')
 AND 	(@fkAutofillSchemaDataStore IS NULL OR fkAutofillSchemaDataStore = @fkAutofillSchemaDataStore)
