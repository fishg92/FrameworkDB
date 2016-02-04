----------------------------------------------------------------------------
-- Select a single record from ConnectType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspConnectTypeSelect]
(	@pkConnectType decimal(18, 0) = NULL,
	@Description varchar(250) = NULL,
	@EnableCloudSync bit = NULL,
	@SyncInterval int = NULL,
	@SyncProviderType varchar(50) = NULL,
	@LUPUser varchar(50) = NULL,
	@LUPDate datetime = NULL,
	@CreateUser varchar(50) = NULL,
	@CreateDate datetime = NULL
)
AS

SELECT	pkConnectType,
	Description,
	EnableCloudSync,
	SyncInterval,
	SyncProviderType,
	LUPUser,
	LUPDate,
	CreateUser,
	CreateDate
FROM	ConnectType
WHERE 	(@pkConnectType IS NULL OR pkConnectType = @pkConnectType)
 AND 	(@Description IS NULL OR Description LIKE @Description + '%')
 AND 	(@EnableCloudSync IS NULL OR EnableCloudSync = @EnableCloudSync)
 AND	(@SyncInterval IS NULL OR SyncInterval = @SyncInterval)
 AND	(@SyncProviderType IS NULL OR SyncProviderType = @SyncProviderType)
 AND 	(@LUPUser IS NULL OR LUPUser LIKE @LUPUser + '%')
 AND 	(@LUPDate IS NULL OR LUPDate = @LUPDate)
 AND 	(@CreateUser IS NULL OR CreateUser LIKE @CreateUser + '%')
 AND 	(@CreateDate IS NULL OR CreateDate = @CreateDate)
