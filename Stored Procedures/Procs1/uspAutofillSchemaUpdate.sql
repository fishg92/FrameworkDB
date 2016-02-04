----------------------------------------------------------------------------
-- Update a single record in AutofillSchema
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspAutofillSchemaUpdate]
(	  @pkAutofillSchema decimal(18, 0)
	, @QueryText varchar(MAX) = NULL
	, @FriendlyName varchar(150) = NULL
	, @fkAutofillSchemaDataStore decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	AutofillSchema
SET	QueryText = ISNULL(@QueryText, QueryText),
	FriendlyName = ISNULL(@FriendlyName, FriendlyName),
	fkAutofillSchemaDataStore = ISNULL(@fkAutofillSchemaDataStore, fkAutofillSchemaDataStore)
WHERE 	pkAutofillSchema = @pkAutofillSchema
