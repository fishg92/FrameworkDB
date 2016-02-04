CREATE proc [dbo].[GetDocumentOverlayImageData]
	@pkDocumentOverlay decimal
	,@Description varchar(50) = null output
	,@ImageLength int = null output
as

select	@Description = Description
		,@ImageLength = datalength(OverlayImage)
from	DocumentOverlay
where	pkDocumentOverlay = @pkDocumentOverlay