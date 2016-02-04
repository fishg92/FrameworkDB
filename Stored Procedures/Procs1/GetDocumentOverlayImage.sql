CREATE proc [dbo].[GetDocumentOverlayImage]
	@pkDocumentOverlay decimal
as

select	OverlayImage
from	DocumentOverlay
where	pkDocumentOverlay = @pkDocumentOverlay