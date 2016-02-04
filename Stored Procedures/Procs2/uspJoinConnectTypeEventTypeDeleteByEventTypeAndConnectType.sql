-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from JoinConnectTypeEventType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinConnectTypeEventTypeDeleteByEventTypeAndConnectType]
(	  @fkEventType decimal(18, 0) = NULL
	, @fkConnectType decimal (18,0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

If @fkConnectType IS NOT NULL OR @fkEventType IS NOT NULL
	BEGIN
		DELETE	JoinEventTypeConnectType
		WHERE 	fkConnectType = ISNULL(@fkConnectType, fkConnectType)
		AND		fkEventType = ISNULL(@fkEventType, fkEventType)
	END
