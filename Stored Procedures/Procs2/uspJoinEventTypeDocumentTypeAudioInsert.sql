-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into JoinEventTypeDocumentTypeAudio
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspJoinEventTypeDocumentTypeAudioInsert]
(	  @fkEventType decimal(18, 0) = NULL
	, @fkDocumentType varchar(50) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkJoinEventTypeDocumentTypeAudio decimal(18, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT JoinEventTypeDocumentTypeAudio
(	  fkEventType
	, fkDocumentType
)
VALUES 
(	  @fkEventType
	, @fkDocumentType

)

SET @pkJoinEventTypeDocumentTypeAudio = SCOPE_IDENTITY()
