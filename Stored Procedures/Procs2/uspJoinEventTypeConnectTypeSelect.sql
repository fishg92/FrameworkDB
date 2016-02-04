----------------------------------------------------------------------------
-- Select a single record from JoinEventTypeConnectType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinEventTypeConnectTypeSelect]
(	@pkJoinEventTypeConnectType decimal(18, 0) = NULL,
	@fkEventType decimal(18, 0) = NULL,
	@fkConnectType decimal(18, 0) = NULL
)
AS

SELECT	pkJoinEventTypeConnectType,
	fkEventType,
	fkConnectType
FROM	JoinEventTypeConnectType
WHERE 	(@pkJoinEventTypeConnectType IS NULL OR pkJoinEventTypeConnectType = @pkJoinEventTypeConnectType)
 AND 	(@fkEventType IS NULL OR fkEventType = @fkEventType)
 AND 	(@fkConnectType IS NULL OR fkConnectType = @fkConnectType)
