
CREATE PROCEDURE [dbo].[spPSPUpdatePSPKeyword]
(
	  @pkPSPKeyword decimal(18,0)
	, @KeywordName varchar(255)
	, @X1 decimal(9,3)
	, @X2 decimal(9,3)
	, @Y1 decimal(9,3)
	, @Y2 decimal(9,3)
	, @KeywordMask varchar(50)
	, @X1Inches decimal(9,3)
	, @X2Inches decimal(9,3)
	, @Y1Inches decimal(9,3)
	, @Y2Inches decimal(9,3)
	, @AdjustedX1 decimal(9,3)
	, @AdjustedX2 decimal(9,3)
	, @AdjustedY1 decimal(9,3)
	, @AdjustedY2 decimal(9,3)
	, @StartCharactersToRemove int
	, @EndCharactersToRemove int
)
AS

	UPDATE PSPKeyword SET
	  KeywordName =  @KeywordName
	, X1 =  @X1
	, X2 = @X2
	, Y1 = @Y1
	, Y2 = @Y2
	, KeywordMask = @KeywordMask
	, X1Inches = @X1Inches
	, X2Inches = @X2Inches
	, Y1Inches = @Y1Inches
	, Y2Inches = @Y2Inches
	, AdjustedX1 = @AdjustedX1
	, AdjustedX2 = @AdjustedX2
	, AdjustedY1 = @AdjustedY1
	, AdjustedY2 = @AdjustedY2
	, RemoveStartCharacters = @StartCharactersToRemove
	, RemoveEndCharacters = @EndCharactersToRemove
	WHERE pkPSPKeyword = @pkPSPKeyword
