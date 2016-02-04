-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from JoinConnectTypeEventType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinConnectTypeEventTypeAssociatedDataDelete]
(	  @fkEventType decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine


	DELETE	JoinEventTypeConnectType
	WHERE	fkEventType = @fkEventType

	DELETE  JoinEventTypeDocumentTypeAudio
	WHERE	fkEventType = @fkEventType

	DELETE  JoinEventTypeDocumentTypeCapture
	WHERE	fkEventType = @fkEventType

	DELETE  JoinEventTypeFormName
	WHERE	fkEventType = @fkEventType
