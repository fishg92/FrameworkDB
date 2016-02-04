

CREATE  PROCEDURE [dbo].[spPSPDeletePSPDocType]
(	
	@pkPSPDocType decimal(18,0)
)
AS

	UPDATE PSPDocType SET
	Deleted = 1
	WHERE pkPSPDocType = @pkPSPDocType

