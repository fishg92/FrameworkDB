----------------------------------------------------------------------------
-- Select a single record from AutofillSchemaColumns
----------------------------------------------------------------------------
CREATE PROC uspAutofillSchemaColumnsSelect
(	@pkAutofillSchemaColumns decimal(18, 0) = NULL,
	@fkAutofillSchema decimal(18, 0) = NULL,
	@FieldName varchar(150) = NULL,
	@FieldOrder int = NULL,
	@CompassPeopleField varchar(50) = NULL
)
AS

SELECT	pkAutofillSchemaColumns,
	fkAutofillSchema,
	FieldName,
	FieldOrder,
	CompassPeopleField
FROM	AutofillSchemaColumns
WHERE 	(@pkAutofillSchemaColumns IS NULL OR pkAutofillSchemaColumns = @pkAutofillSchemaColumns)
 AND 	(@fkAutofillSchema IS NULL OR fkAutofillSchema = @fkAutofillSchema)
 AND 	(@FieldName IS NULL OR FieldName LIKE @FieldName + '%')
 AND 	(@FieldOrder IS NULL OR FieldOrder = @FieldOrder)
 AND 	(@CompassPeopleField IS NULL OR CompassPeopleField LIKE @CompassPeopleField + '%')

