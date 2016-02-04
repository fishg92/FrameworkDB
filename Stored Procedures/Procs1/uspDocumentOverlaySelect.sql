----------------------------------------------------------------------------
-- Select a single record from DocumentOverlay
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspDocumentOverlaySelect]
(	@pkDocumentOverlay decimal(18, 0) = NULL,
	@Description varchar(50) = NULL,
	@OverlayImage image = NULL
)
AS

SELECT	pkDocumentOverlay,
	Description,
	OverlayImage
FROM	DocumentOverlay
WHERE 	(@pkDocumentOverlay IS NULL OR pkDocumentOverlay = @pkDocumentOverlay)
 AND 	(@Description IS NULL OR Description LIKE @Description + '%')

