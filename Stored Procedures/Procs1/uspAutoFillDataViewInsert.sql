----------------------------------------------------------------------------
-- Insert a single record into AutoFillDataView
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspAutoFillDataViewInsert]
(	  @fkAutoFillDataSource decimal(18, 0)
	, @FriendlyName varchar(100)
	, @TSql varchar(MAX)
	, @IgnoreProgramTypeSecurity tinyint = NULL
	, @IgnoreSecuredClientSecurity tinyint = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkAutoFillDataView decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT AutoFillDataView
(	  fkAutoFillDataSource
	, FriendlyName
	, TSql
	, IgnoreProgramTypeSecurity
	, IgnoreSecuredClientSecurity
)
VALUES 
(	  @fkAutoFillDataSource
	, @FriendlyName
	, @TSql
	, @IgnoreProgramTypeSecurity
	, @IgnoreSecuredClientSecurity

)

SET @pkAutoFillDataView = SCOPE_IDENTITY()
