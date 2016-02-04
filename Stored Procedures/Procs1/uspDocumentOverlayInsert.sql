----------------------------------------------------------------------------
-- Insert a single record into DocumentOverlay
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspDocumentOverlayInsert]
(	  @Description varchar(50)
	, @OverlayImage image
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkDocumentOverlay decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT DocumentOverlay
(	  Description
	, OverlayImage
)
VALUES 
(	  @Description
	, @OverlayImage

)

SET @pkDocumentOverlay = SCOPE_IDENTITY()
