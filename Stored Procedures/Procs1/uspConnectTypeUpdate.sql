----------------------------------------------------------------------------
-- Update a single record in ConnectType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspConnectTypeUpdate]
(	  @pkConnectType decimal(18, 0)
	, @Description varchar(250) = NULL
	, @EnableCloudSync bit = NULL
	, @SyncInterval int = NULL
	, @SyncProviderType varchar(50) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	ConnectType
SET	Description = ISNULL(@Description, Description),
	EnableCloudSync = ISNULL(@EnableCloudSync, EnableCloudSync),
	SyncInterval = ISNULL(@SyncInterval, SyncInterval),
	SyncProviderType = ISNULL(@SyncProviderType, SyncProviderType)
WHERE 	pkConnectType = @pkConnectType
