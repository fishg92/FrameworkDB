----------------------------------------------------------------------------
-- Update a single record in PSPKeyword
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspPSPKeywordUpdate]
(	  @pkPSPKeyword decimal(18, 0)
	, @fkPSPPage decimal(18, 0) = NULL
	, @fkPSPDocType decimal(18, 0) = NULL
	, @KeywordName varchar(255) = NULL
	, @X1 decimal(9, 3) = NULL
	, @X2 decimal(9, 3) = NULL
	, @Y1 decimal(9, 3) = NULL
	, @Y2 decimal(9, 3) = NULL
	, @AdjustedX1 decimal(9, 3) = NULL
	, @AdjustedX2 decimal(9, 3) = NULL
	, @AdjustedY1 decimal(9, 3) = NULL
	, @AdjustedY2 decimal(9, 3) = NULL
	, @KeywordMask varchar(50) = NULL
	, @X1Inches decimal(9, 3) = NULL
	, @X2Inches decimal(9, 3) = NULL
	, @Y1Inches decimal(9, 3) = NULL
	, @Y2Inches decimal(9, 3) = NULL
	, @RemoveStartCharacters int = NULL
	, @RemoveEndCharacters int = NULL
	, @IsRouteKeyword bit = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	PSPKeyword
SET	fkPSPPage = ISNULL(@fkPSPPage, fkPSPPage),
	fkPSPDocType = ISNULL(@fkPSPDocType, fkPSPDocType),
	KeywordName = ISNULL(@KeywordName, KeywordName),
	X1 = ISNULL(@X1, X1),
	X2 = ISNULL(@X2, X2),
	Y1 = ISNULL(@Y1, Y1),
	Y2 = ISNULL(@Y2, Y2),
	AdjustedX1 = ISNULL(@AdjustedX1, AdjustedX1),
	AdjustedX2 = ISNULL(@AdjustedX2, AdjustedX2),
	AdjustedY1 = ISNULL(@AdjustedY1, AdjustedY1),
	AdjustedY2 = ISNULL(@AdjustedY2, AdjustedY2),
	KeywordMask = ISNULL(@KeywordMask, KeywordMask),
	X1Inches = ISNULL(@X1Inches, X1Inches),
	X2Inches = ISNULL(@X2Inches, X2Inches),
	Y1Inches = ISNULL(@Y1Inches, Y1Inches),
	Y2Inches = ISNULL(@Y2Inches, Y2Inches),
	RemoveStartCharacters = ISNULL(@RemoveStartCharacters, RemoveStartCharacters),
	RemoveEndCharacters = ISNULL(@RemoveEndCharacters, RemoveEndCharacters),
	IsRouteKeyword = ISNULL(@IsRouteKeyword,IsRouteKeyword)
WHERE 	pkPSPKeyword = @pkPSPKeyword
