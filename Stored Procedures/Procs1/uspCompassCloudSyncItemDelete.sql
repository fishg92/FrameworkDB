----------------------------------------------------------------------------
-- Delete a single record from CompassCloudSyncItem
----------------------------------------------------------------------------
CREATE PROC uspCompassCloudSyncItemDelete
(	@pkCompassCloudSyncItem decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
)
AS

exec SetAuditDataContext @AuditUser = @LupUser, @AuditMachine = @LUPMachine

DELETE	CompassCloudSyncItem
WHERE 	pkCompassCloudSyncItem = @pkCompassCloudSyncItem