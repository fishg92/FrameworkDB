-- Stored Procedure

----------------------------------------------------------------------------
-- Delete a single record from JoinTransferTypeEventType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinEventTypeDocumentTypeAudioDeleteByEventTypeAndDocumentType]
(	  @fkEventType decimal(18, 0) = NULL
	, @fkDocumentType varchar(50) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

		DELETE	JoinEventTypeDocumentTypeAudio
		WHERE 	fkDocumentType = ISNULL(@fkDocumentType, fkDocumentType)
		AND		fkEventType = ISNULL(@fkEventType, fkEventType)
