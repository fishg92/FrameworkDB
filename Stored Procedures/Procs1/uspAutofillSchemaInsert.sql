----------------------------------------------------------------------------
-- Insert a single record into AutofillSchema
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspAutofillSchemaInsert]
(	  @QueryText varchar(MAX)
	, @FriendlyName varchar(150) = NULL
	, @fkAutofillSchemaDataStore decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkAutofillSchema decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT AutofillSchema
(	  QueryText
	, FriendlyName
	, fkAutofillSchemaDataStore
)
VALUES 
(	  @QueryText
	, @FriendlyName
	, @fkAutofillSchemaDataStore

)

SET @pkAutofillSchema = SCOPE_IDENTITY()
