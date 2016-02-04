----------------------------------------------------------------------------
-- Update a single record in DocumentOverlay
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspDocumentOverlayUpdate]
(	  @pkDocumentOverlay decimal(18, 0)
	, @Description varchar(50) = NULL
	, @OverlayImage image = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	DocumentOverlay
SET	Description = ISNULL(@Description, Description),
	OverlayImage = ISNULL(@OverlayImage, OverlayImage)
WHERE 	pkDocumentOverlay = @pkDocumentOverlay
