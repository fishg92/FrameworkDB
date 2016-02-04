----------------------------------------------------------------------------
-- Select a single record from AutofillSchemaDataView
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspAutofillSchemaDataViewSelect]
(	@pkAutofillSchemaDataView decimal(18, 0) = NULL,
	@fkAutofillSchema decimal(18, 0) = NULL,
	@FriendlyName varchar(150) = NULL,
	@IgnoreProgramTypeSecurity tinyint = NULL,
	@IgnoreSecuredClientSecurity tinyint = NULL
)
AS

SELECT	pkAutofillSchemaDataView,
	fkAutofillSchema,
	FriendlyName,
	IgnoreProgramTypeSecurity,
	IgnoreSecuredClientSecurity
FROM	AutofillSchemaDataView
WHERE 	(@pkAutofillSchemaDataView IS NULL OR pkAutofillSchemaDataView = @pkAutofillSchemaDataView)
 AND 	(@fkAutofillSchema IS NULL OR fkAutofillSchema = @fkAutofillSchema)
 AND 	(@FriendlyName IS NULL OR FriendlyName LIKE @FriendlyName + '%')
 AND 	(@IgnoreProgramTypeSecurity IS NULL OR IgnoreProgramTypeSecurity = @IgnoreProgramTypeSecurity)
 AND 	(@IgnoreSecuredClientSecurity IS NULL OR IgnoreSecuredClientSecurity = @IgnoreSecuredClientSecurity)
