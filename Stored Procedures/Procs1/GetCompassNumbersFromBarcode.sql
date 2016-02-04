CREATE PROCEDURE [dbo].[GetCompassNumbersFromBarcode]
(
	@fkDocumentPage decimal(18,0)
)
AS

SET NOCOUNT ON

SELECT   fkBarcodeDocument = ISNULL(bdp.fkBarcodeDocument, -1)
       , PageNumber = ISNULL(bdp.PageNumber, 1)
	   , BarcodePageCount = ISNULL(bd.[PageCount], 0)
	   , fkBarcodeDocumentType = 
	   
			CASE WHEN (ISNULL(fn.BarcodeDocType, 0) = '0') THEN
				CASE WHEN (ISNULL(pdt.BarcodeDocType, 0) = '0') THEN
					ISNULL(pdt.DMSDocType, 0)
				ELSE
					pdt.BarcodeDocType
				END
			ELSE
				fn.BarcodeDocType
			END
	   
	   , BarcodeDocTypeName = ISNULL(fn.BarcodeDocTypeName, '')
	   , FormDocType = ISNULL(fn.FormDocType, '')
	   , SystemName = ISNULL(fn.SystemName, '')
FROM BarcodeDocumentPage bdp
INNER JOIN BarcodeDocument bd WITH (NOLOCK) ON bd.pkBarcodeDocument = bdp.fkBarcodeDocument
LEFT OUTER JOIN FormName fn WITH (NOLOCK) ON fn.pkFormName = bd.fkFormName
LEFT OUTER JOIN PSPDocType pdt WITH (NOLOCK) ON bd.fkPSPDocType = pdt.pkPSPDocType
WHERE pkBarcodeDocumentPage = @fkDocumentPage

SELECT KeywordValue = ISNULL(bdk.KeywordValue, '')
FROM BarcodeDocumentPage bdp
INNER JOIN BarcodeDocumentKeyword bdk WITH (NOLOCK) ON bdk.fkBarcodeDocument = bdp.fkBarcodeDocument
WHERE bdp.pkBarcodeDocumentPage = @fkDocumentPage
--AND LOWER(RTRIM(LTRIM(bdk.KeywordName))) = 'compass number'





