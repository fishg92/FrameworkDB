
CREATE PROCEDURE [dbo].[spPSPGetDocTypeSplit]
(
	@fkPSPDocType decimal(18,0)
)
AS

	SELECT * FROM PSPDocTypeSplit WHERE fkPSPDocType = @fkPSPDocType
