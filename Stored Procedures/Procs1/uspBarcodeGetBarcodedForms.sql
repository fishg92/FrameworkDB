CREATE PROCEDURE [dbo].[uspBarcodeGetBarcodedForms]
AS

	SELECT DISTINCT   ISNULL(bd.fkFormName, 0) AS 'fkFormName'
					, CASE WHEN (ISNULL(bd.fkFormName,0) = 0) THEN
							pdt.DocName
					  ELSE
							fn.FriendlyName
					  END AS 'FriendlyName'
					, ISNULL(bd.fkPSPDocType, 0) AS 'fkPSPDocType'
	FROM BarcodeDocument bd
	LEFT OUTER JOIN FormName fn ON bd.fkFormName = fn.pkFormName
	LEFT OUTER JOIN PSPDocType pdt ON bd.fkPSPDocType = pdt.pkPSPDocType