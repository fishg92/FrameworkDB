----------------------------------------------------------------------------
-- Select a single record from PSPDocType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspPSPDocTypeSelect]
(	@pkPSPDocType decimal(18, 0) = NULL,
	@DocName varchar(255) = NULL,
	@MatchString varchar(255) = NULL,
	@SendToOnBase bit = NULL,
	@DMSDocType varchar(50) = NULL,
	@DMSDocTypeName varchar(500) = NULL,
	@Snapshot varbinary(MAX) = NULL,
	@X1 decimal(9, 3) = NULL,
	@X2 decimal(9, 3) = NULL,
	@Y1 decimal(9, 3) = NULL,
	@Y2 decimal(9, 3) = NULL,
	@AdjustedX1 decimal(9, 3) = NULL,
	@AdjustedX2 decimal(9, 3) = NULL,
	@AdjustedY1 decimal(9, 3) = NULL,
	@AdjustedY2 decimal(9, 3) = NULL,
	@X1Inches decimal(9, 3) = NULL,
	@Y1Inches decimal(9, 3) = NULL,
	@X2Inches decimal(9, 3) = NULL,
	@Y2Inches decimal(9, 3) = NULL,
	@RemoveStartCharacters int = NULL,
	@RemoveEndCharacters int = NULL,
	@IncludeAsKeyword bit = NULL,
	@Deleted bit = NULL,
	@BarcodeDocType varchar(50) = null,
	@PrintBarcode smallint = null,
	@RouteDocument smallint = null
)
AS

SELECT	pkPSPDocType,
	DocName,
	MatchString,
	SendToOnBase,
	DMSDocType,
	DMSDocTypeName,
	[Snapshot],
	X1,
	X2,
	Y1,
	Y2,
	AdjustedX1,
	AdjustedX2,
	AdjustedY1,
	AdjustedY2,
	X1Inches,
	Y1Inches,
	X2Inches,
	Y2Inches,
	RemoveStartCharacters,
	RemoveEndCharacters,
	IncludeAsKeyword,
	Deleted,
	BarcodeDocType,
	PrintBarcode,
	RouteDocument

FROM	PSPDocType
WHERE 	(@pkPSPDocType IS NULL OR pkPSPDocType = @pkPSPDocType)
 AND 	(@DocName IS NULL OR DocName LIKE @DocName + '%')
 AND 	(@MatchString IS NULL OR MatchString LIKE @MatchString + '%')
 AND 	(@SendToOnBase IS NULL OR SendToOnBase = @SendToOnBase)
 AND 	(@DMSDocType IS NULL OR UPPER(DMSDocType) = UPPER(@DMSDocType))
 AND 	(@DMSDocTypeName IS NULL OR DMSDocTypeName LIKE @DMSDocTypeName + '%')
 AND 	(@X1 IS NULL OR X1 = @X1)
 AND 	(@X2 IS NULL OR X2 = @X2)
 AND 	(@Y1 IS NULL OR Y1 = @Y1)
 AND 	(@Y2 IS NULL OR Y2 = @Y2)
 AND 	(@AdjustedX1 IS NULL OR AdjustedX1 = @AdjustedX1)
 AND 	(@AdjustedX2 IS NULL OR AdjustedX2 = @AdjustedX2)
 AND 	(@AdjustedY1 IS NULL OR AdjustedY1 = @AdjustedY1)
 AND 	(@AdjustedY2 IS NULL OR AdjustedY2 = @AdjustedY2)
 AND 	(@X1Inches IS NULL OR X1Inches = @X1Inches)
 AND 	(@Y1Inches IS NULL OR Y1Inches = @Y1Inches)
 AND 	(@X2Inches IS NULL OR X2Inches = @X2Inches)
 AND 	(@Y2Inches IS NULL OR Y2Inches = @Y2Inches)
 AND 	(@RemoveStartCharacters IS NULL OR RemoveStartCharacters = @RemoveStartCharacters)
 AND 	(@RemoveEndCharacters IS NULL OR RemoveEndCharacters = @RemoveEndCharacters)
 AND 	(@IncludeAsKeyword IS NULL OR IncludeAsKeyword = @IncludeAsKeyword)
 AND 	(@Deleted IS NULL OR Deleted = @Deleted)
 AND 	(@BarcodeDocType IS NULL OR BarcodeDocType LIKE @BarcodeDocType + '%')
 AND 	(@PrintBarcode IS NULL OR PrintBarcode = @PrintBarcode)
 AND	(@RouteDocument IS NULL OR RouteDocument = @RouteDocument)

