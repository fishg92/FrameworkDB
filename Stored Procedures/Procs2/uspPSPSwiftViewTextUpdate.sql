----------------------------------------------------------------------------
-- Update a single record in PSPSwiftViewText
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspPSPSwiftViewTextUpdate]
(	  @pkPSPSwiftViewText decimal(18, 0)
	, @SwiftViewText varchar(100) = NULL
	, @PageNumber int = NULL
	, @Xpos decimal(9, 3) = NULL
	, @Ypos decimal(9, 3) = NULL
	, @fkPSPDocument decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	PSPSwiftViewText
SET	SwiftViewText = ISNULL(@SwiftViewText, SwiftViewText),
	PageNumber = ISNULL(@PageNumber, PageNumber),
	Xpos = ISNULL(@Xpos, Xpos),
	Ypos = ISNULL(@Ypos, Ypos),
	fkPSPDocument = ISNULL(@fkPSPDocument, fkPSPDocument)
WHERE 	pkPSPSwiftViewText = @pkPSPSwiftViewText
