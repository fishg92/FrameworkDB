----------------------------------------------------------------------------
-- Update a single record in JoinEventTypeDocumentTypeAudio
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinEventTypeDocumentTypeAudioUpdate]
(	  @pkJoinEventTypeDocumentTypeAudio decimal(18, 0)
	, @fkEventType decimal(18, 0) = NULL
	, @fkDocumentType varchar(50) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	JoinEventTypeDocumentTypeAudio
SET	fkEventType = ISNULL(@fkEventType, fkEventType),
	fkDocumentType = ISNULL(@fkDocumentType, fkDocumentType)
WHERE 	pkJoinEventTypeDocumentTypeAudio = @pkJoinEventTypeDocumentTypeAudio
