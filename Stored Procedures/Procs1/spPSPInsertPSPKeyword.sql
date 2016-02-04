
CREATE     Proc [dbo].[spPSPInsertPSPKeyword]
(	@fkPSPDocType decimal,
	@fkPSPPage decimal,
	@KeywordName varchar(255),
	@X1 decimal(9,3),
	@X2 decimal(9,3),
	@Y1 decimal(9,3),
	@Y2 decimal(9,3),
	@KeywordMask varchar(50),
	@X1Inches decimal(9,3),
	@X2Inches decimal(9,3),
	@Y1Inches decimal(9,3),
	@Y2Inches decimal(9,3),
	@AdjustedX1 decimal(9,3),
	@AdjustedX2 decimal(9,3),
	@AdjustedY1 decimal(9,3),
	@AdjustedY2 decimal(9,3),
	@StartCharactersToRemove int,
	@EndCharactersToRemove int,
	@pkPSPKeyword decimal Output
)
as

	Insert Into PSPKeyword
	(	fkPSPPage,
		fkPSPDocType,
		KeywordName,
		X1,
		X2,
		Y1,
		Y2,
		KeywordMask,
		X1Inches,
		X2Inches,
		Y1Inches,
		Y2Inches,
		AdjustedX1,
		AdjustedX2,
		AdjustedY1,
		AdjustedY2,
		RemoveStartCharacters,
		RemoveEndCharacters)
	values
	(	@fkPSPPage,
		@fkPSPDocType,
		@KeywordName,
		@X1,
		@X2,
		@Y1,
		@Y2,
		@KeywordMask,
		@X1Inches,
		@X2Inches,
		@Y1Inches,
		@Y2Inches,
		@AdjustedX1,
		@AdjustedX2,
		@AdjustedY1,
		@AdjustedY2,
		@StartCharactersToRemove,
		@EndCharactersToRemove)

	Set @pkPSPKeyword = Scope_Identity()

