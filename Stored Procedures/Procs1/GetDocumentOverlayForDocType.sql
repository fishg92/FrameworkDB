CREATE proc [dbo].[GetDocumentOverlayForDocType]
	@fkDocumentType varchar(50)
	,@fkDocumentOverlay decimal = null output
as

select	@fkDocumentOverlay = fkDocumentOverlay
from	DocumentTypeDisplaySetting
where	fkDocumentType = @fkDocumentType

set @fkDocumentOverlay = isnull(@fkDocumentOverlay,-1)

