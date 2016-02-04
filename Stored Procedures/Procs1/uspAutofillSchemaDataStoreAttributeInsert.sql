----------------------------------------------------------------------------
-- Insert a single record into AutofillSchemaDataStoreAttribute
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspAutofillSchemaDataStoreAttributeInsert]
(	  @fkAutofillSchemaDataStore decimal(18, 0)
	, @ItemKey varchar(100)
	, @ItemValue varchar(500)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkAutofillSchemaDataStoreAttribute decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT AutofillSchemaDataStoreAttribute
(	  fkAutofillSchemaDataStore
	, ItemKey
	, ItemValue
)
VALUES 
(	  @fkAutofillSchemaDataStore
	, @ItemKey
	, @ItemValue

)

SET @pkAutofillSchemaDataStoreAttribute = SCOPE_IDENTITY()
