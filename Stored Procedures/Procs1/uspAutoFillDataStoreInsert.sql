----------------------------------------------------------------------------
-- Insert a single record into AutoFillDataStore
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspAutoFillDataStoreInsert]
(	  @FriendlyName varchar(100)
	, @ConnectionType varchar(100) = NULL
	, @ConnectionString varchar(500) = NULL
	, @Enabled bit = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkAutoFillDataStore decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT AutoFillDataStore
(	  FriendlyName
	, ConnectionType
	, ConnectionString
	, Enabled
)
VALUES 
(	  @FriendlyName
	, @ConnectionType
	, @ConnectionString
	, @Enabled

)

SET @pkAutoFillDataStore = SCOPE_IDENTITY()
