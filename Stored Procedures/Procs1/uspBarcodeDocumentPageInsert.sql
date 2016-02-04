----------------------------------------------------------------------------
-- Insert a single record into BarcodeDocumentPage
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspBarcodeDocumentPageInsert]
(	  @fkBarcodeDocument decimal(18, 0)
	, @PageNumber int
	, @PageScanned bit = NULL
	, @ReturnDate smalldatetime = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkBarcodeDocumentPage decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT BarcodeDocumentPage
(	  fkBarcodeDocument
	, PageNumber
	, PageScanned
	, ReturnDate
)
VALUES 
(	  @fkBarcodeDocument
	, @PageNumber
	, @PageScanned
	, @ReturnDate

)

SET @pkBarcodeDocumentPage = SCOPE_IDENTITY()
