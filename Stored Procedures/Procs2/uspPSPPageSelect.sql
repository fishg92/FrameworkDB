----------------------------------------------------------------------------
-- Select a single record from PSPPage
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspPSPPageSelect]
(	@pkPSPPage decimal(18, 0) = NULL,
	@fkPSPDocType decimal(18, 0) = NULL,
	@PageNumber int = NULL
)
AS

SELECT	pkPSPPage,
	fkPSPDocType,
	PageNumber
FROM	PSPPage
WHERE 	(@pkPSPPage IS NULL OR pkPSPPage = @pkPSPPage)
 AND 	(@fkPSPDocType IS NULL OR fkPSPDocType = @fkPSPDocType)
 AND 	(@PageNumber IS NULL OR PageNumber = @PageNumber)

