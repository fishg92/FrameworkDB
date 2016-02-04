CREATE PROCEDURE [dbo].[uspBarcodeGetIndividualForm]
(
	  @pkBarcodeDocument decimal(18,0)
	, @TotalPages int OUTPUT
	, @PagesReturned int OUTPUT
	, @DateSent datetime OUTPUT
)
AS

	SELECT @TotalPages = COUNT(pkBarcodeDocumentPage)
	FROM BarcodeDocumentPage
	WHERE 
	fkBarcodeDocument = @pkBarcodeDocument

	SELECT @PagesReturned = COUNT(pkBarcodeDocumentPage)
	FROM BarcodeDocumentPage
	WHERE 
	PageScanned = 1
	AND
	fkBarcodeDocument = @pkBarcodeDocument

	SELECT @DateSent = SendDate
	FROM BarcodeDocument
	WHERE pkBarcodeDocument = @pkBarcodeDocument



	