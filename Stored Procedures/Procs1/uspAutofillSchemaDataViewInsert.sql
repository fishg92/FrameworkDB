----------------------------------------------------------------------------
-- Insert a single record into AutofillSchemaDataView
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspAutofillSchemaDataViewInsert]
(	  @fkAutofillSchema decimal(18, 0)
	, @FriendlyName varchar(150)
	, @IgnoreProgramTypeSecurity tinyint = NULL
	, @IgnoreSecuredClientSecurity tinyint = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkAutofillSchemaDataView decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT AutofillSchemaDataView
(	  fkAutofillSchema
	, FriendlyName
	, IgnoreProgramTypeSecurity
	, IgnoreSecuredClientSecurity
)
VALUES 
(	  @fkAutofillSchema
	, @FriendlyName
	, COALESCE(@IgnoreProgramTypeSecurity, (0))
	, COALESCE(@IgnoreSecuredClientSecurity, (0))

)

SET @pkAutofillSchemaDataView = SCOPE_IDENTITY()
