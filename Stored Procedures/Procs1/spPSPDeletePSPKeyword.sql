
CREATE PROCEDURE [dbo].[spPSPDeletePSPKeyword]
(
	@pkPSPKeyword decimal(18,0)
)
AS

	DELETE FROM PSPKeyword
	WHERE pkPSPKeyword = @pkPSPKeyword
