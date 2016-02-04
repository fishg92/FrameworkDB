----------------------------------------------------------------------------
-- Select a single record from PSPDocImage
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspPSPDocImageSelect]
(	@pkPSPDocImage decimal(18, 0) = NULL,
	@fkPSPDocType decimal(18, 0) = NULL,
	@FullImage varbinary(MAX) = NULL	
)
AS

SELECT	pkPSPDocImage,
	fkPSPDocType,
	FullImage
FROM	PSPDocImage
WHERE 	(@pkPSPDocImage IS NULL OR pkPSPDocImage = @pkPSPDocImage)
 AND 	(@fkPSPDocType IS NULL OR fkPSPDocType = @fkPSPDocType)
 

