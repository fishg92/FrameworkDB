CREATE PROCEDURE [dbo].[uspFormGetPageCount]
(
	  @pkFormName decimal(18,0)
	, @PageCount int OUTPUT
)
AS

SELECT @PageCount = COUNT(ip.pkFormImagePage)
FROM FormImagePage ip
WHERE ip.fkFormName = @pkFormName