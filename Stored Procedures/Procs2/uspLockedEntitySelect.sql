----------------------------------------------------------------------------
-- Select a single record from LockedEntity
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspLockedEntitySelect]
(	@pkLockedEntity decimal(18, 0) = NULL,
	@fkCPClient decimal(18, 0) = NULL,
	@fkProgramType decimal(18, 0) = NULL
)
AS

SELECT	pkLockedEntity,
	fkCPClient,
	fkProgramType
	
FROM	LockedEntity
WHERE 	(@pkLockedEntity IS NULL OR pkLockedEntity = @pkLockedEntity)
 AND 	(@fkCPClient IS NULL OR fkCPClient = @fkCPClient)
 AND 	(@fkProgramType IS NULL OR fkProgramType = @fkProgramType)

