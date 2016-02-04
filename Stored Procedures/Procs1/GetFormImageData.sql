
CREATE PROCEDURE [dbo].[GetFormImageData]
(
	@pkFormImagePage decimal
)

AS

select fip.ImageData
from FormImagePage fip
where fip.pkFormImagePage = @pkFormImagePage
