----------------------------------------------------------------------------
-- Update a single record in AutoFillDataView
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspAutoFillDataViewUpdate]
(	  @pkAutoFillDataView decimal(18, 0)
	, @fkAutoFillDataSource decimal(18, 0) = NULL
	, @FriendlyName varchar(100) = NULL
	, @TSql varchar(MAX) = NULL
	, @IgnoreProgramTypeSecurity tinyint = NULL
	, @IgnoreSecuredClientSecurity tinyint = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	AutoFillDataView
SET	fkAutoFillDataSource = ISNULL(@fkAutoFillDataSource, fkAutoFillDataSource),
	FriendlyName = ISNULL(@FriendlyName, FriendlyName),
	TSql = ISNULL(@TSql, TSql),
	IgnoreProgramTypeSecurity = ISNULL(@IgnoreProgramTypeSecurity, IgnoreProgramTypeSecurity),
	IgnoreSecuredClientSecurity = ISNULL(@IgnoreSecuredClientSecurity, IgnoreSecuredClientSecurity)
WHERE 	pkAutoFillDataView = @pkAutoFillDataView
