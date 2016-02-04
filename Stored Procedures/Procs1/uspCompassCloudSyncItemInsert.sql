----------------------------------------------------------------------------
-- Insert a single record into CompassCloudSyncItem
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCompassCloudSyncItemInsert]
(	  @fkSyncItem varchar(50)
	, @SyncItemType decimal(18, 0)
	, @FormallyKnownAs varchar(50)
	, @fkApplicationUser decimal(18, 0)
	, @CloudItemID varchar(250) = NULL
	, @TimeStamp float
	, @ItemPageNumber int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkCompassCloudSyncItem decimal(18, 0) = NULL OUTPUT 
)
AS

exec SetAuditDataContext @AuditUser = @LupUser, @AuditMachine = @LUPMachine

INSERT CompassCloudSyncItem
(	  fkSyncItem
	, SyncItemType
	, FormallyKnownAs
	, fkApplicationUser
	, CloudItemID
	, TimeStamp
	, ItemPageNumber
)
VALUES 
(	  @fkSyncItem
	, @SyncItemType
	, @FormallyKnownAs
	, @fkApplicationUser
	, COALESCE(@CloudItemID, ('-1'))
	, @TimeStamp
	, @ItemPageNumber

)

SET @pkCompassCloudSyncItem = SCOPE_IDENTITY()
