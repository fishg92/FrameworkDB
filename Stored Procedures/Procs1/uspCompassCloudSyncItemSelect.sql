----------------------------------------------------------------------------
-- Select a single record from CompassCloudSyncItem
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCompassCloudSyncItemSelect]
(	@pkCompassCloudSyncItem decimal(18, 0) = NULL,
	@fkSyncItem varchar(50) = NULL,
	@SyncItemType decimal(18, 0) = NULL,
	@FormallyKnownAs varchar(50) = NULL,
	@fkApplicationUser decimal(18, 0) = NULL,
	@CloudItemID varchar(250) = NULL,
	@TimeStamp float = NULL,
	@ItemPageNumber int = NULL,
	@LUPUser varchar(50) = NULL,
	@LUPDate datetime = NULL,
	@CreateUser varchar(50) = NULL,
	@CreateDate datetime = NULL
)
AS

SELECT	pkCompassCloudSyncItem,
	fkSyncItem,
	SyncItemType,
	FormallyKnownAs,
	fkApplicationUser,
	CloudItemID,
	TimeStamp,
	ItemPageNumber,
	LUPUser,
	LUPDate,
	CreateUser,
	CreateDate
FROM	CompassCloudSyncItem
WHERE 	(@pkCompassCloudSyncItem IS NULL OR pkCompassCloudSyncItem = @pkCompassCloudSyncItem)
 AND 	(@fkSyncItem IS NULL OR fkSyncItem = @fkSyncItem)
 AND 	(@SyncItemType IS NULL OR SyncItemType = @SyncItemType)
 AND 	(@FormallyKnownAs IS NULL OR FormallyKnownAs LIKE @FormallyKnownAs + '%')
 AND 	(@fkApplicationUser IS NULL OR fkApplicationUser = @fkApplicationUser)
 AND 	(@CloudItemID IS NULL OR CloudItemID = @CloudItemID)
 AND 	(@TimeStamp IS NULL OR TimeStamp = @TimeStamp)
 AND 	(@ItemPageNumber IS NULL OR ItemPageNumber = @ItemPageNumber)
 AND 	(@LUPUser IS NULL OR LUPUser LIKE @LUPUser + '%')
 AND 	(@LUPDate IS NULL OR LUPDate = @LUPDate)
 AND 	(@CreateUser IS NULL OR CreateUser LIKE @CreateUser + '%')
 AND 	(@CreateDate IS NULL OR CreateDate = @CreateDate)
