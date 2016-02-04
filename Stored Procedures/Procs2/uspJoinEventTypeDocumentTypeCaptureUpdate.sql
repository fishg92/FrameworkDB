----------------------------------------------------------------------------
-- Update a single record in JoinEventTypeDocumentTypeCapture
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinEventTypeDocumentTypeCaptureUpdate]
(	  @pkJoinEventTypeDocumentTypeCapture decimal(18, 0)
	, @fkEventType decimal(18, 0) = NULL
	, @fkDocumentType varchar(50) = NULL
	, @SystemGeneratedCaption bit = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	JoinEventTypeDocumentTypeCapture
SET	fkEventType = ISNULL(@fkEventType, fkEventType),
	fkDocumentType = ISNULL(@fkDocumentType, fkDocumentType),
	SystemGeneratedCaption = ISNULL(@SystemGeneratedCaption, SystemGeneratedCaption)
WHERE 	pkJoinEventTypeDocumentTypeCapture = @pkJoinEventTypeDocumentTypeCapture
