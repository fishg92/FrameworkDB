----------------------------------------------------------------------------
-- Select a single record from BarcodeDocument
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspBarcodeDocumentSelect]
(	@pkBarcodeDocument decimal(18, 0) = NULL,
	@fkFormName decimal(18, 0) = NULL,
	@PageCount int = NULL,
	@SendDate datetime = NULL,
	@fkPSPDocType decimal(18, 0) = NULL
)
AS

SELECT	pkBarcodeDocument,
	fkFormName,
	[PageCount],
	SendDate
FROM	BarcodeDocument
WHERE 	(@pkBarcodeDocument IS NULL OR pkBarcodeDocument = @pkBarcodeDocument)
 AND 	(@fkFormName IS NULL OR fkFormName = @fkFormName)
 AND 	(@PageCount IS NULL OR PageCount = @PageCount)
 AND 	(@SendDate IS NULL OR SendDate = @SendDate)
 AND	(@fkPSPDocType IS NULL OR fkPSPDocType = @fkPSPDocType)

