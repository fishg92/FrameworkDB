----------------------------------------------------------------------------
-- Select a single record from PSPSwiftViewText
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspPSPSwiftViewTextSelect]
(	@pkPSPSwiftViewText decimal(18, 0) = NULL,
	@SwiftViewText varchar(100) = NULL,
	@PageNumber int = NULL,
	@Xpos decimal(9, 3) = NULL,
	@Ypos decimal(9, 3) = NULL,
	@fkPSPDocument decimal(18, 0) = NULL
)
AS

SELECT	pkPSPSwiftViewText,
	SwiftViewText,
	PageNumber,
	Xpos,
	Ypos,
	fkPSPDocument
FROM	PSPSwiftViewText
WHERE 	(@pkPSPSwiftViewText IS NULL OR pkPSPSwiftViewText = @pkPSPSwiftViewText)
 AND 	(@SwiftViewText IS NULL OR SwiftViewText LIKE @SwiftViewText + '%')
 AND 	(@PageNumber IS NULL OR PageNumber = @PageNumber)
 AND 	(@Xpos IS NULL OR Xpos = @Xpos)
 AND 	(@Ypos IS NULL OR Ypos = @Ypos)
 AND 	(@fkPSPDocument IS NULL OR fkPSPDocument = @fkPSPDocument)


