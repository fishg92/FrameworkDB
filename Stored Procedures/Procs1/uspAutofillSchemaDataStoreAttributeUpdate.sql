----------------------------------------------------------------------------
-- Update a single record in AutofillSchemaDataStoreAttribute
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspAutofillSchemaDataStoreAttributeUpdate]
(	  @pkAutofillSchemaDataStoreAttribute decimal(18, 0)
	, @fkAutofillSchemaDataStore decimal(18, 0) = NULL
	, @ItemKey varchar(100) = NULL
	, @ItemValue varchar(500) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	AutofillSchemaDataStoreAttribute
SET	fkAutofillSchemaDataStore = ISNULL(@fkAutofillSchemaDataStore, fkAutofillSchemaDataStore),
	ItemKey = ISNULL(@ItemKey, ItemKey),
	ItemValue = ISNULL(@ItemValue, ItemValue)
WHERE 	pkAutofillSchemaDataStoreAttribute = @pkAutofillSchemaDataStoreAttribute
