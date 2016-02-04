
CREATE PROCEDURE [dbo].[spPSPDeletePSPPage]
(
	@pkPSPPage decimal(18,0)
)
AS

	DELETE FROM PSPPage 
	WHERE pkPSPPage = @pkPSPPage
