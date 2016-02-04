----------------------------------------------------------------------------
-- Select a single record from JoinEventTypeFormName
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinEventTypeFormNameSelect]
(	@pkJoinEventTypeFormName decimal(18, 0) = NULL,
	@fkEventType decimal(18, 0) = NULL,
	@fkFormName decimal(18, 0) = NULL
)
AS

SELECT	pkJoinEventTypeFormName,
	fkEventType,
	fkFormName
FROM	JoinEventTypeFormName
WHERE 	(@pkJoinEventTypeFormName IS NULL OR pkJoinEventTypeFormName = @pkJoinEventTypeFormName)
 AND 	(@fkEventType IS NULL OR fkEventType = @fkEventType)
 AND 	(@fkFormName IS NULL OR fkFormName = @fkFormName)
