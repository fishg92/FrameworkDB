----------------------------------------------------------------------------
-- Select a single record from PSPKeyword
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspPSPKeywordSelect]
(	@pkPSPKeyword decimal(18, 0) = NULL,
	@fkPSPPage decimal(18, 0) = NULL,
	@fkPSPDocType decimal(18, 0) = NULL,
	@KeywordName varchar(255) = NULL,
	@X1 decimal(9, 3) = NULL,
	@X2 decimal(9, 3) = NULL,
	@Y1 decimal(9, 3) = NULL,
	@Y2 decimal(9, 3) = NULL,
	@AdjustedX1 decimal(9, 3) = NULL,
	@AdjustedX2 decimal(9, 3) = NULL,
	@AdjustedY1 decimal(9, 3) = NULL,
	@AdjustedY2 decimal(9, 3) = NULL,
	@KeywordMask varchar(50) = NULL,
	@X1Inches decimal(9, 3) = NULL,
	@X2Inches decimal(9, 3) = NULL,
	@Y1Inches decimal(9, 3) = NULL,
	@Y2Inches decimal(9, 3) = NULL,
	@RemoveStartCharacters int = NULL,
	@RemoveEndCharacters int = NULL,
	@IsRouteKeyword bit = NULL
)
AS

SELECT	pkPSPKeyword,
	fkPSPPage,
	fkPSPDocType,
	KeywordName,
	X1,
	X2,
	Y1,
	Y2,
	AdjustedX1,
	AdjustedX2,
	AdjustedY1,
	AdjustedY2,
	KeywordMask,
	X1Inches,
	X2Inches,
	Y1Inches,
	Y2Inches,
	RemoveStartCharacters,
	RemoveEndCharacters,
	IsRouteKeyword
FROM	PSPKeyword
WHERE 	(@pkPSPKeyword IS NULL OR pkPSPKeyword = @pkPSPKeyword)
 AND 	(@fkPSPPage IS NULL OR fkPSPPage = @fkPSPPage)
 AND 	(@fkPSPDocType IS NULL OR fkPSPDocType = @fkPSPDocType)
 AND 	(@KeywordName IS NULL OR KeywordName LIKE @KeywordName + '%')
 AND 	(@X1 IS NULL OR X1 = @X1)
 AND 	(@X2 IS NULL OR X2 = @X2)
 AND 	(@Y1 IS NULL OR Y1 = @Y1)
 AND 	(@Y2 IS NULL OR Y2 = @Y2)
 AND 	(@AdjustedX1 IS NULL OR AdjustedX1 = @AdjustedX1)
 AND 	(@AdjustedX2 IS NULL OR AdjustedX2 = @AdjustedX2)
 AND 	(@AdjustedY1 IS NULL OR AdjustedY1 = @AdjustedY1)
 AND 	(@AdjustedY2 IS NULL OR AdjustedY2 = @AdjustedY2)
 AND 	(@KeywordMask IS NULL OR KeywordMask LIKE @KeywordMask + '%')
 AND 	(@X1Inches IS NULL OR X1Inches = @X1Inches)
 AND 	(@X2Inches IS NULL OR X2Inches = @X2Inches)
 AND 	(@Y1Inches IS NULL OR Y1Inches = @Y1Inches)
 AND 	(@Y2Inches IS NULL OR Y2Inches = @Y2Inches)
 AND 	(@RemoveStartCharacters IS NULL OR RemoveStartCharacters = @RemoveStartCharacters)
 AND 	(@RemoveEndCharacters IS NULL OR RemoveEndCharacters = @RemoveEndCharacters)
 AND	(@IsRouteKeyword IS NULL OR IsRouteKeyword = @IsRouteKeyword)


