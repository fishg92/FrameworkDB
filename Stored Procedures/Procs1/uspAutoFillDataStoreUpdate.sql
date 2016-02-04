----------------------------------------------------------------------------
-- Update a single record in AutoFillDataStore
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspAutoFillDataStoreUpdate]
(	  @pkAutoFillDataStore decimal(18, 0)
	, @FriendlyName varchar(100) = NULL
	, @ConnectionType varchar(100) = NULL
	, @ConnectionString varchar(500) = NULL
	, @Enabled bit = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	AutoFillDataStore
SET	FriendlyName = ISNULL(@FriendlyName, FriendlyName),
	ConnectionType = ISNULL(@ConnectionType, ConnectionType),
	ConnectionString = ISNULL(@ConnectionString, ConnectionString),
	Enabled = ISNULL(@Enabled, Enabled)
WHERE 	pkAutoFillDataStore = @pkAutoFillDataStore
