



CREATE PROCEDURE [dbo].[spPSPGetDocType]
(
	@pkPSPDocType decimal(18, 0)
)
AS

	IF (@pkPSPDocType <> 0)
	BEGIN
		SELECT dt.*, di.FullImage 
		FROM PSPDocType dt 
		JOIN PSPDocImage di ON di.fkPSPDocType = dt.pkPSPDocType
		WHERE pkPSPDocType = @pkPSPDocType
	END
	ELSE
	BEGIN
		SELECT dt.*
		FROM PSPDocType dt
		WHERE dt.Deleted = 0
		ORDER BY dt.DocName
	END



