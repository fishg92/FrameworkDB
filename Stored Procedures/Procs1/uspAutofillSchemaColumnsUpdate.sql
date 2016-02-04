----------------------------------------------------------------------------
-- Update a single record in AutofillSchemaColumns
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspAutofillSchemaColumnsUpdate]
(	  @pkAutofillSchemaColumns decimal(18, 0)
	, @fkAutofillSchema decimal(18, 0) = NULL
	, @FieldName varchar(150) = NULL
	, @FieldOrder int = NULL
	, @CompassPeopleField varchar(50) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	AutofillSchemaColumns
SET	fkAutofillSchema = ISNULL(@fkAutofillSchema, fkAutofillSchema),
	FieldName = ISNULL(@FieldName, FieldName),
	FieldOrder = ISNULL(@FieldOrder, FieldOrder),
	CompassPeopleField = ISNULL(@CompassPeopleField, CompassPeopleField)
WHERE 	pkAutofillSchemaColumns = @pkAutofillSchemaColumns
