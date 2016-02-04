----------------------------------------------------------------------------
-- Update a single record in CompassCloudSyncItem
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCompassCloudSyncItemUpdate]
(	  @pkCompassCloudSyncItem decimal(18, 0)
	, @fkSyncItem varchar(50) = NULL
	, @SyncItemType decimal(18, 0) = NULL
	, @FormallyKnownAs varchar(50) = NULL
	, @fkApplicationUser decimal(18, 0) = NULL
	, @CloudItemID varchar(250) = NULL
	, @TimeStamp float = NULL
	, @ItemPageNumber int = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS

exec SetAuditDataContext @AuditUser = @LupUser, @AuditMachine = @LUPMachine

UPDATE	CompassCloudSyncItem
SET	fkSyncItem = ISNULL(@fkSyncItem, fkSyncItem),
	SyncItemType = ISNULL(@SyncItemType, SyncItemType),
	FormallyKnownAs = ISNULL(@FormallyKnownAs, FormallyKnownAs),
	fkApplicationUser = ISNULL(@fkApplicationUser, fkApplicationUser),
	CloudItemID = ISNULL(@CloudItemID, CloudItemID),
	TimeStamp = ISNULL(@TimeStamp, TimeStamp),
	ItemPageNumber = ISNULL(@ItemPageNumber, ItemPageNumber)
WHERE 	pkCompassCloudSyncItem = @pkCompassCloudSyncItem
