----------------------------------------------------------------------------
-- Select a single record from BarcodeDocumentKeyword
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspBarcodeDocumentKeywordSelect]
	@pkBarcodeDocumentKeyword decimal(18, 0) = NULL,
	@fkBarcodeDocument decimal(18, 0) = NULL,
	@KeywordGroup int = NULL,
	@KeywordName varchar(50) = NULL,
	@KeywordValue varchar(255) = NULL,
	@KeywordID varchar(50) = NULL

AS

SELECT	pkBarcodeDocumentKeyword,
	fkBarcodeDocument,
	KeywordGroup,
	KeywordName,
	KeywordValue,
	KeywordID
FROM	BarcodeDocumentKeyword
WHERE 	(@pkBarcodeDocumentKeyword IS NULL OR pkBarcodeDocumentKeyword = @pkBarcodeDocumentKeyword)
 AND 	(@fkBarcodeDocument IS NULL OR fkBarcodeDocument = @fkBarcodeDocument)
 AND 	(@KeywordGroup IS NULL OR KeywordGroup = @KeywordGroup)
 AND 	(@KeywordName IS NULL OR KeywordName LIKE @KeywordName + '%')
 AND 	(@KeywordValue IS NULL OR KeywordValue LIKE @KeywordValue + '%')
 AND 	(@KeywordID IS NULL OR KeywordID LIKE @KeywordID + '%')
 
