CREATE PROCEDURE [dbo].[uspBarcodeGetOutstandingForms]
(
	  @fkFormName decimal(18,0)
)
AS

SELECT ISNULL(COUNT(bd.pkBarcodeDocument),0) AS 'Total Number of Documents'
FROM BarcodeDocument bd
WHERE bd.fkFormName = @fkFormName

SELECT ISNULL(COUNT(DISTINCT bd.pkBarcodeDocument),0) AS 'Returned Documents'
FROM BarcodeDocument bd
JOIN BarcodeDocumentPage bp ON bd.pkBarcodeDocument = bp.fkBarcodeDocument
WHERE 
bd.fkFormName = @fkFormName
AND
bp.PageScanned = 1

SELECT ISNULL(AVG(DATEDIFF(day, bd.SendDate, bp.ReturnDate)),0) AS 'Average Turnaround'
FROM BarcodeDocument bd
JOIN BarcodeDocumentPage bp ON bd.pkBarcodeDocument = bp.fkBarcodeDocument
WHERE
bd.fkFormName = @fkFormName
AND
bp.PageScanned = 1
AND
bp.ReturnDate IS NOT NULL

DECLARE @Keywords TABLE
(
	  pk int IDENTITY
	, pkBarcodeDocument decimal(18,0)
	, KeywordName varchar(255)
	, KeywordValue varchar(255)
)
DECLARE @CompassNumber varchar(255)
DECLARE @fkBarcodeDocument decimal(18,0)
DECLARE outstandingcursor cursor
FOR
SELECT DISTINCT bd.pkBarcodeDocument
FROM BarcodeDocument bd
JOIN BarcodeDocumentPage bp ON bd.pkBarcodeDocument = bp.fkBarcodeDocument
WHERE
bd.fkFormName = @fkFormName
AND
bd.PageCount <> 
(
	SELECT COUNT(pkBarcodeDocumentPage)
	FROM BarcodeDocumentPage
	WHERE 
	PageScanned = 1
	AND
	fkBarcodeDocument = bd.pkBarcodeDocument
)

OPEN outstandingcursor

FETCH outstandingcursor INTO @fkBarcodeDocument

WHILE @@FETCH_STATUS = 0
BEGIN

	INSERT INTO @Keywords
	SELECT TOP 3 fkBarcodeDocument, KeywordName, KeywordValue
	FROM BarcodeDocumentKeyword
	WHERE
	KeywordGroup = 0
	AND 
	fkBarcodeDocument = @fkBarcodeDocument

	SET @CompassNumber = (
		SELECT TOP 1 KeywordValue 
		FROM @Keywords 
		WHERE 
		pkBarcodeDocument = @fkBarcodeDocument 
		AND 
		KeywordName = 'Compass Number'
	)

	IF @CompassNumber <> ''
	BEGIN

		DELETE FROM @Keywords WHERE pkBarcodeDocument = @fkBarcodeDocument

		INSERT INTO @Keywords
		SELECT @fkBarcodeDocument, 'First Name', FirstName FROM CPClient WHERE NorthwoodsNumber = @CompassNumber

		INSERT INTO @Keywords
		SELECT @fkBarcodeDocument, 'Last Name', LastName FROM CPClient WHERE NorthwoodsNumber = @CompassNumber

		INSERT INTO @Keywords
		SELECT @fkBarcodeDocument, 'SSN', FormattedSSN FROM CPClient WHERE NorthwoodsNumber = @CompassNumber

	END

	FETCH outstandingcursor INTO @fkBarcodeDocument

END

CLOSE outstandingcursor
DEALLOCATE outstandingcursor

SELECT    pkBarcodeDocument
		, KeywordName
		, KeywordValue
FROM @Keywords