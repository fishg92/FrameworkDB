CREATE proc [dbo].[GetDocumentOverlayList]
as

select	pkDocumentOverlay
		,Description
from	DocumentOverlay