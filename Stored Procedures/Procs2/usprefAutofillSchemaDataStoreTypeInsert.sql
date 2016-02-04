----------------------------------------------------------------------------
-- Insert a single record into refAutofillSchemaDataStoreType
----------------------------------------------------------------------------
CREATE Proc [dbo].[usprefAutofillSchemaDataStoreTypeInsert]
(	  @FriendlyName varchar(150)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkrefAutofillSchemaDataStoreType decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT refAutofillSchemaDataStoreType
(	  pkrefAutofillSchemaDataStoreType
	, FriendlyName
)
VALUES 
(	  @pkrefAutofillSchemaDataStoreType
	, @FriendlyName

)

SET @pkrefAutofillSchemaDataStoreType = SCOPE_IDENTITY()
