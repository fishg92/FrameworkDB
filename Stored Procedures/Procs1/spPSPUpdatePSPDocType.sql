
CREATE PROCEDURE [dbo].[spPSPUpdatePSPDocType] 
(
	  @pkPSPDocType decimal(18,0)
	, @FormName varchar(50) = NULL
	, @MatchString varchar(50) = NULL
	, @SendToOnBase bit = NULL
	, @DMSDocType varchar(50) = NULL
	, @DMSDocTypeName varchar(500) = NULL
	, @X1 decimal(9,3) = NULL
	, @X2 decimal(9,3) = NULL
	, @Y1 decimal(9,3) = NULL
	, @Y2 decimal(9,3) = NULL
	, @X1Inches decimal(9,3) = NULL
	, @X2Inches decimal(9,3) = NULL
	, @Y1Inches decimal(9,3) = NULL
	, @Y2Inches decimal(9,3) = NULL
	, @AdjustedX1 decimal(9,3) = NULL
	, @AdjustedX2 decimal(9,3) = NULL
	, @AdjustedY1 decimal(9,3) = NULL
	, @AdjustedY2 decimal(9,3) = NULL
	, @StartCharactersToRemove int = NULL
	, @EndCharactersToRemove int = NULL
	, @IncludeAsKeyword bit = NULL
)
AS

	UPDATE PSPDocType SET
		  DocName = ISNULL(@FormName, DocName)
		, MatchString = ISNULL(@MatchString, MatchString)
		, SendToOnBase = ISNULL(@SendToOnBase, SendToOnBase)
		, DMSDocType = ISNULL(@DMSDocType, DMSDocType)
		, DMSDocTypeName = ISNULL(@DMSDocTypeName, DMSDocTypeName)
		, X1 = ISNULL(@X1, X1)
		, X2 = ISNULL(@X2, X2)
		, Y1 = ISNULL(@Y1, Y1)
		, Y2 = ISNULL(@Y2, Y2)
		, X1Inches = ISNULL(@X1Inches, X1Inches)
		, X2Inches = ISNULL(@X2Inches, X2Inches)
		, Y1Inches = ISNULL(@Y1Inches, Y1Inches)
		, Y2Inches = ISNULL(@Y2Inches, Y2Inches)
		, AdjustedX1 = ISNULL(@AdjustedX1, AdjustedX1)
		, AdjustedX2 = ISNULL(@AdjustedX2, AdjustedX2)
		, AdjustedY1 = ISNULL(@AdjustedY1, AdjustedY1)
		, AdjustedY2 = ISNULL(@AdjustedY2, AdjustedY2)
		, RemoveStartCharacters = ISNULL(@StartCharactersToRemove, RemoveStartCharacters)
		, RemoveEndCharacters = ISNULL(@EndCharactersToRemove, RemoveEndCharacters)
		, IncludeAsKeyword = ISNULL(@IncludeAsKeyword, IncludeAsKeyword)
	WHERE pkPSPDocType = @pkPSPDocType
