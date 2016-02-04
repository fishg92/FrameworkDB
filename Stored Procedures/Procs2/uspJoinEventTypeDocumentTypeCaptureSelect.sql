----------------------------------------------------------------------------
-- Select a single record from JoinEventTypeDocumentTypeCapture
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinEventTypeDocumentTypeCaptureSelect]
(	@pkJoinEventTypeDocumentTypeCapture decimal(18, 0) = NULL,
	@fkEventType decimal(18, 0) = NULL,
	@fkDocumentType varchar(50) = NULL,
	@SystemGeneratedCaption bit = NULL,
	@LUPUser varchar(50) = NULL,
	@LUPDate datetime = NULL,
	@CreateUser varchar(50) = NULL,
	@CreateDate datetime = NULL
)
AS

SELECT	pkJoinEventTypeDocumentTypeCapture,
	fkEventType,
	fkDocumentType,
	SystemGeneratedCaption,
	LUPUser,
	LUPDate,
	CreateUser,
	CreateDate
FROM	JoinEventTypeDocumentTypeCapture
WHERE 	(@pkJoinEventTypeDocumentTypeCapture IS NULL OR pkJoinEventTypeDocumentTypeCapture = @pkJoinEventTypeDocumentTypeCapture)
 AND 	(@fkEventType IS NULL OR fkEventType = @fkEventType)
 AND 	(@fkDocumentType IS NULL OR fkDocumentType LIKE @fkDocumentType + '%')
 AND 	(@SystemGeneratedCaption IS NULL OR SystemGeneratedCaption = @SystemGeneratedCaption)
 AND 	(@LUPUser IS NULL OR LUPUser LIKE @LUPUser + '%')
 AND 	(@LUPDate IS NULL OR LUPDate = @LUPDate)
 AND 	(@CreateUser IS NULL OR CreateUser LIKE @CreateUser + '%')
 AND 	(@CreateDate IS NULL OR CreateDate = @CreateDate)

