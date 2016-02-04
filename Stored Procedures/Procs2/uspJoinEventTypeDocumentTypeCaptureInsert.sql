----------------------------------------------------------------------------
-- Insert a single record into JoinEventTypeDocumentTypeCapture
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspJoinEventTypeDocumentTypeCaptureInsert]
(	  @fkEventType decimal(18, 0) = NULL
	, @fkDocumentType varchar(50) = NULL
	, @SystemGeneratedCaption bit = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkJoinEventTypeDocumentTypeCapture decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT JoinEventTypeDocumentTypeCapture
(	  fkEventType
	, fkDocumentType
	, SystemGeneratedCaption
)
VALUES 
(	  @fkEventType
	, @fkDocumentType
	, COALESCE(@SystemGeneratedCaption, (0))

)

SET @pkJoinEventTypeDocumentTypeCapture = SCOPE_IDENTITY()
