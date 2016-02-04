----------------------------------------------------------------------------
-- Update a single record in refAutofillSchemaDataStoreType
----------------------------------------------------------------------------
CREATE PROC [dbo].[usprefAutofillSchemaDataStoreTypeUpdate]
(	  @pkrefAutofillSchemaDataStoreType decimal(18, 0)
	, @FriendlyName varchar(150) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	refAutofillSchemaDataStoreType
SET	FriendlyName = ISNULL(@FriendlyName, FriendlyName)
WHERE 	pkrefAutofillSchemaDataStoreType = @pkrefAutofillSchemaDataStoreType
