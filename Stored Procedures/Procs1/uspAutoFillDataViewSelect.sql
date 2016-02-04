----------------------------------------------------------------------------
-- Select a single record from AutoFillDataView
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspAutoFillDataViewSelect]
(	@pkAutoFillDataView decimal(18, 0) = NULL,
	@fkAutoFillDataSource decimal(18, 0) = NULL,
	@FriendlyName varchar(100) = NULL,
	@TSql varchar(MAX) = NULL,
	@IgnoreProgramTypeSecurity tinyint = NULL,
	@IgnoreSecuredClientSecurity tinyint = NULL
)
AS

SELECT	pkAutoFillDataView,
	fkAutoFillDataSource,
	FriendlyName,
	TSql,
	IgnoreProgramTypeSecurity,
	IgnoreSecuredClientSecurity
FROM	AutoFillDataView
WHERE 	(@pkAutoFillDataView IS NULL OR pkAutoFillDataView = @pkAutoFillDataView)
 AND 	(@fkAutoFillDataSource IS NULL OR fkAutoFillDataSource = @fkAutoFillDataSource)
 AND 	(@FriendlyName IS NULL OR FriendlyName LIKE @FriendlyName + '%')
 AND 	(@TSql IS NULL OR TSql LIKE @TSql + '%')
 AND 	(@IgnoreProgramTypeSecurity IS NULL OR IgnoreProgramTypeSecurity = @IgnoreProgramTypeSecurity)
 AND 	(@IgnoreSecuredClientSecurity IS NULL OR IgnoreSecuredClientSecurity = @IgnoreSecuredClientSecurity)

