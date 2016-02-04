----------------------------------------------------------------------------
-- Insert a single record into BarcodeDocument
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspBarcodeDocumentInsert]
(	  @fkFormName decimal(18, 0)
	, @PageCount int
	, @SendDate datetime
	, @fkPSPDocType decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkBarcodeDocument decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT BarcodeDocument
(	  fkFormName
	, [PageCount]
	, SendDate
	, fkPSPDocType
)
VALUES 
(	  @fkFormName
	, @PageCount
	, @SendDate
	, @fkPSPDocType
)

SET @pkBarcodeDocument = SCOPE_IDENTITY()
