----------------------------------------------------------------------------
-- Update a single record in AutofillSchemaDataView
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspAutofillSchemaDataViewUpdate]
(	  @pkAutofillSchemaDataView decimal(18, 0)
	, @fkAutofillSchema decimal(18, 0) = NULL
	, @FriendlyName varchar(150) = NULL
	, @IgnoreProgramTypeSecurity tinyint = NULL
	, @IgnoreSecuredClientSecurity tinyint = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	AutofillSchemaDataView
SET	fkAutofillSchema = ISNULL(@fkAutofillSchema, fkAutofillSchema),
	FriendlyName = ISNULL(@FriendlyName, FriendlyName),
	IgnoreProgramTypeSecurity = ISNULL(@IgnoreProgramTypeSecurity, IgnoreProgramTypeSecurity),
	IgnoreSecuredClientSecurity = ISNULL(@IgnoreSecuredClientSecurity, IgnoreSecuredClientSecurity)
WHERE 	pkAutofillSchemaDataView = @pkAutofillSchemaDataView
