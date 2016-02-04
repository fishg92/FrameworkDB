----------------------------------------------------------------------------
-- Insert a single record into BarcodeDocumentKeyword
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspBarcodeDocumentKeywordInsert]
(	  @fkBarcodeDocument decimal(18, 0)
	, @KeywordGroup int
	, @KeywordName varchar(50)
	, @KeywordValue varchar(255)
	, @KeywordID varchar(50)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkBarcodeDocumentKeyword decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT BarcodeDocumentKeyword
(	  fkBarcodeDocument
	, KeywordGroup
	, KeywordName
	, KeywordValue
	, KeywordID
)
VALUES 
(	  @fkBarcodeDocument
	, @KeywordGroup
	, @KeywordName
	, @KeywordValue
	, @KeywordID

)

SET @pkBarcodeDocumentKeyword = SCOPE_IDENTITY()
