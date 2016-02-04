----------------------------------------------------------------------------
-- Insert a single record into ConnectType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspConnectTypeInsert]
(	  @Description varchar(250) = NULL
	, @EnableCloudSync bit = NULL
	, @SyncInterval int = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkConnectType decimal(18, 0) = NULL OUTPUT 
	, @SyncProviderType varchar(50) = NULL
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT ConnectType
(	  Description
	, EnableCloudSync
	, SyncInterval
	, SyncProviderType
)
VALUES 
(	  @Description
	, @EnableCloudSync
	, @SyncInterval
	, @SyncProviderType
)

SET @pkConnectType = SCOPE_IDENTITY()
