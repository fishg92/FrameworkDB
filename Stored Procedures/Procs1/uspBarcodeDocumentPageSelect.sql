----------------------------------------------------------------------------
-- Select a single record from BarcodeDocumentPage
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspBarcodeDocumentPageSelect]
	@pkBarcodeDocumentPage decimal(18, 0) = NULL,
	@fkBarcodeDocument decimal(18, 0) = NULL,
	@PageNumber int = NULL,
	@PageScanned bit = NULL,
	@ReturnDate smalldatetime = NULL

AS

SELECT	pkBarcodeDocumentPage,
	fkBarcodeDocument,
	PageNumber,
	PageScanned,
	ReturnDate
FROM	BarcodeDocumentPage
WHERE 	(@pkBarcodeDocumentPage IS NULL OR pkBarcodeDocumentPage = @pkBarcodeDocumentPage)
 AND 	(@fkBarcodeDocument IS NULL OR fkBarcodeDocument = @fkBarcodeDocument)
 AND 	(@PageNumber IS NULL OR PageNumber = @PageNumber)
 AND 	(@PageScanned IS NULL OR PageScanned = @PageScanned)
 AND 	(@ReturnDate IS NULL OR ReturnDate = @ReturnDate)
 