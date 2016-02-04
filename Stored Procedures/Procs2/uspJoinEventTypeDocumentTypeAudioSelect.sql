----------------------------------------------------------------------------
-- Select a single record from JoinEventTypeDocumentTypeAudio
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinEventTypeDocumentTypeAudioSelect]
(	@pkJoinEventTypeDocumentTypeAudio decimal(18, 0) = NULL,
	@fkEventType decimal(18, 0) = NULL,
	@fkDocumentType varchar(50) = NULL
)
AS

SELECT	pkJoinEventTypeDocumentTypeAudio,
	fkEventType,
	fkDocumentType
FROM	JoinEventTypeDocumentTypeAudio
WHERE 	(@pkJoinEventTypeDocumentTypeAudio IS NULL OR pkJoinEventTypeDocumentTypeAudio = @pkJoinEventTypeDocumentTypeAudio)
 AND 	(@fkEventType IS NULL OR fkEventType = @fkEventType)
 AND 	(@fkDocumentType IS NULL OR fkDocumentType LIKE @fkDocumentType + '%')
