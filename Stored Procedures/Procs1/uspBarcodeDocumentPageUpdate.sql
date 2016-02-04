----------------------------------------------------------------------------
-- Update a single record in BarcodeDocumentPage
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspBarcodeDocumentPageUpdate]
(	  @pkBarcodeDocumentPage decimal(18, 0)
	, @fkBarcodeDocument decimal(18, 0) = NULL
	, @PageNumber int = NULL
	, @PageScanned bit = NULL
	, @ReturnDate smalldatetime = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	BarcodeDocumentPage
SET	fkBarcodeDocument = ISNULL(@fkBarcodeDocument, fkBarcodeDocument),
	PageNumber = ISNULL(@PageNumber, PageNumber),
	PageScanned = ISNULL(@PageScanned, PageScanned),
	ReturnDate = ISNULL(@ReturnDate, ReturnDate)
WHERE 	pkBarcodeDocumentPage = @pkBarcodeDocumentPage
