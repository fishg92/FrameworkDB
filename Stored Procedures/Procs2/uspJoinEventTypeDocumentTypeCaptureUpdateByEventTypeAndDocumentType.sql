-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record from JoinTransferTypeEventType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinEventTypeDocumentTypeCaptureUpdateByEventTypeAndDocumentType]
(	  @fkEventType decimal(18, 0) = NULL
	, @fkDocumentType varchar(50) = NULL
	, @SystemGeneratedCaption bit = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

		update	JoinEventTypeDocumentTypeCapture
		set SystemGeneratedCaption = ISNULL(@SystemGeneratedCaption,0)
		WHERE 	fkDocumentType = ISNULL(@fkDocumentType, fkDocumentType)
		AND		fkEventType = ISNULL(@fkEventType, fkEventType)
