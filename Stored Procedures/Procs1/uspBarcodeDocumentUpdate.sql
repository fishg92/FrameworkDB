----------------------------------------------------------------------------
-- Update a single record in BarcodeDocument
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspBarcodeDocumentUpdate]
(	  @pkBarcodeDocument decimal(18, 0)
	, @fkFormName decimal(18, 0) = NULL
	, @PageCount int = NULL
	, @SendDate datetime = NULL
	, @fkPSPDocType decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	BarcodeDocument
SET	fkFormName = ISNULL(@fkFormName, fkFormName),
	[PageCount] = ISNULL(@PageCount, [PageCount]),
	SendDate = ISNULL(@SendDate, SendDate),
	fkPSPDocType = ISNULL(@fkPSPDocType, fkPSPDocType)
WHERE 	pkBarcodeDocument = @pkBarcodeDocument
