----------------------------------------------------------------------------
-- Insert a single record into AutofillSchemaColumns
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspAutofillSchemaColumnsInsert]
(	  @fkAutofillSchema decimal(18, 0)
	, @FieldName varchar(150)
	, @FieldOrder int
	, @CompassPeopleField varchar(50) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkAutofillSchemaColumns decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT AutofillSchemaColumns
(	  fkAutofillSchema
	, FieldName
	, FieldOrder
	, CompassPeopleField
)
VALUES 
(	  @fkAutofillSchema
	, @FieldName
	, @FieldOrder
	, COALESCE(@CompassPeopleField, '')

)

SET @pkAutofillSchemaColumns = SCOPE_IDENTITY()
