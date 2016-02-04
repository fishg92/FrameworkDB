----------------------------------------------------------------------------
-- Update a single record in JoinEventTypeConnectType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinEventTypeConnectTypeUpdate]
(	  @pkJoinEventTypeConnectType decimal(18, 0)
	, @fkEventType decimal(18, 0) = NULL
	, @fkConnectType decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	JoinEventTypeConnectType
SET	fkEventType = ISNULL(@fkEventType, fkEventType),
	fkConnectType = ISNULL(@fkConnectType, fkConnectType)
WHERE 	pkJoinEventTypeConnectType = @pkJoinEventTypeConnectType
