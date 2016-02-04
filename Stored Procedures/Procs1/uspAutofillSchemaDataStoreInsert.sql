----------------------------------------------------------------------------
-- Insert a single record into AutofillSchemaDataStore
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspAutofillSchemaDataStoreInsert]
(	  @FriendlyName varchar(200)
	, @fkrefAutofillSchemaDataSourceType decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkAutofillSchemaDataStore decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT AutofillSchemaDataStore
(	  FriendlyName
	, fkrefAutofillSchemaDataSourceType
)
VALUES 
(	  @FriendlyName
	, @fkrefAutofillSchemaDataSourceType

)

SET @pkAutofillSchemaDataStore = SCOPE_IDENTITY()
