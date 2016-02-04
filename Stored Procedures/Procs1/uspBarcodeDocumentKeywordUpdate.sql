----------------------------------------------------------------------------
-- Update a single record in BarcodeDocumentKeyword
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspBarcodeDocumentKeywordUpdate]
(	  @pkBarcodeDocumentKeyword decimal(18, 0)
	, @fkBarcodeDocument decimal(18, 0) = NULL
	, @KeywordGroup int = NULL
	, @KeywordName varchar(50) = NULL
	, @KeywordValue varchar(255) = NULL
	, @KeywordID varchar(50) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	BarcodeDocumentKeyword
SET	fkBarcodeDocument = ISNULL(@fkBarcodeDocument, fkBarcodeDocument),
	KeywordGroup = ISNULL(@KeywordGroup, KeywordGroup),
	KeywordName = ISNULL(@KeywordName, KeywordName),
	KeywordValue = ISNULL(@KeywordValue, KeywordValue),
	KeywordID = ISNULL(@KeywordID, KeywordID)
WHERE 	pkBarcodeDocumentKeyword = @pkBarcodeDocumentKeyword
