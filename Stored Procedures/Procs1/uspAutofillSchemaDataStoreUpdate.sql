----------------------------------------------------------------------------
-- Update a single record in AutofillSchemaDataStore
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspAutofillSchemaDataStoreUpdate]
(	  @pkAutofillSchemaDataStore decimal(18, 0)
	, @FriendlyName varchar(200) = NULL
	, @fkrefAutofillSchemaDataSourceType decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	AutofillSchemaDataStore
SET	FriendlyName = ISNULL(@FriendlyName, FriendlyName),
	fkrefAutofillSchemaDataSourceType = ISNULL(@fkrefAutofillSchemaDataSourceType, fkrefAutofillSchemaDataSourceType)
WHERE 	pkAutofillSchemaDataStore = @pkAutofillSchemaDataStore
