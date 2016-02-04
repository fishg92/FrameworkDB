----------------------------------------------------------------------------
-- Insert a single record into JoinEventTypeConnectType
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspJoinEventTypeConnectTypeInsert]
(	  @fkEventType decimal(18, 0) = NULL
	, @fkConnectType decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkJoinEventTypeConnectType decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT JoinEventTypeConnectType
(	  fkEventType
	, fkConnectType
)
VALUES 
(	  @fkEventType
	, @fkConnectType

)

SET @pkJoinEventTypeConnectType = SCOPE_IDENTITY()
