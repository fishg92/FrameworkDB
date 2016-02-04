----------------------------------------------------------------------------
-- Insert a single record into PSPKeyword
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspPSPKeywordInsert]
(	  @fkPSPPage decimal(18, 0)
	, @fkPSPDocType decimal(18, 0)
	, @KeywordName varchar(255)
	, @X1 decimal(9, 3)
	, @X2 decimal(9, 3)
	, @Y1 decimal(9, 3)
	, @Y2 decimal(9, 3)
	, @AdjustedX1 decimal(9, 3)
	, @AdjustedX2 decimal(9, 3)
	, @AdjustedY1 decimal(9, 3)
	, @AdjustedY2 decimal(9, 3)
	, @KeywordMask varchar(50) = NULL
	, @X1Inches decimal(9, 3)
	, @X2Inches decimal(9, 3)
	, @Y1Inches decimal(9, 3)
	, @Y2Inches decimal(9, 3)
	, @RemoveStartCharacters int
	, @RemoveEndCharacters int
	, @IsRouteKeyword bit
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkPSPKeyword decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT PSPKeyword
(	  fkPSPPage
	, fkPSPDocType
	, KeywordName
	, X1
	, X2
	, Y1
	, Y2
	, AdjustedX1
	, AdjustedX2
	, AdjustedY1
	, AdjustedY2
	, KeywordMask
	, X1Inches
	, X2Inches
	, Y1Inches
	, Y2Inches
	, RemoveStartCharacters
	, RemoveEndCharacters
	, IsRouteKeyword
)
VALUES 
(	  @fkPSPPage
	, @fkPSPDocType
	, @KeywordName
	, @X1
	, @X2
	, @Y1
	, @Y2
	, @AdjustedX1
	, @AdjustedX2
	, @AdjustedY1
	, @AdjustedY2
	, @KeywordMask
	, @X1Inches
	, @X2Inches
	, @Y1Inches
	, @Y2Inches
	, @RemoveStartCharacters
	, @RemoveEndCharacters
	, @IsRouteKeyword
)

SET @pkPSPKeyword = SCOPE_IDENTITY()
