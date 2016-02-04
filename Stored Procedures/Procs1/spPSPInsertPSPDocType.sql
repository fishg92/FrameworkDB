


CREATE PROCEDURE [dbo].[spPSPInsertPSPDocType] 
(
	  @FormName varchar(50)
	, @MatchString varchar(50)
	, @Snapshot image
	, @SendToOnBase bit
	, @DMSDocType varchar(50)
	, @DMSDocTypeName varchar(500)
	, @X1 decimal(9,3)
	, @X2 decimal(9,3)
	, @Y1 decimal(9,3)
	, @Y2 decimal(9,3)
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
	, @FullImage image
	, @IncludeAsKeyword bit
	, @pkPSPDocType decimal(18,0) OUTPUT
	, @pkPSPDocImage decimal(18,0) OUTPUT
) AS

	INSERT INTO PSPDocType
	(	
		  DocName
		, MatchString
		, [Snapshot]
		, SendToOnBase
		, DMSDocType
		, DMSDocTypeName
		, X1
		, X2
		, Y1
		, Y2
		, X1Inches
		, X2Inches
		, Y1Inches
		, Y2Inches
		, AdjustedX1
		, AdjustedX2
		, AdjustedY1
		, AdjustedY2
		, RemoveStartCharacters
		, RemoveEndCharacters
		, IncludeAsKeyword
		, Deleted
	) 	
	VALUES
	(	
		  @FormName 
		, @MatchString
		, @Snapshot
		, @SendToOnBase
		, @DMSDocType
		, @DMSDocTypeName
		, @X1
		, @X2
		, @Y1
		, @Y2
		, @X1Inches
		, @X2Inches
		, @Y1Inches
		, @Y2Inches
		, @AdjustedX1
		, @AdjustedX2
		, @AdjustedY1
		, @AdjustedY2
		, @StartCharactersToRemove
		, @EndCharactersToRemove
		, @IncludeAsKeyword
		, 0
	)

	SET @pkPSPDocType = SCOPE_IDENTITY()

	IF (@pkPSPDocType <> 0)
	BEGIN

		INSERT INTO PSPDocImage
		(
			  fkPSPDocType
			, FullImage
		)
		VALUES
		(
			  @pkPSPDocType
			, @FullImage
		)

		SET @pkPSPDocImage = SCOPE_IDENTITY()

	END

