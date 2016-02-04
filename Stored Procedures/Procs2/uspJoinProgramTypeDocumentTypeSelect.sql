

----------------------------------------------------------------------------
-- Select a single record from JoinProgramTypeDocumentType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinProgramTypeDocumentTypeSelect]
(	@pkJoinProgramTypeDocumentType decimal(10, 0) = NULL,
	@fkProgramType decimal(18, 0) = NULL,
	@fkDocumentType varchar(50) = NULL
)
AS

SELECT	pkJoinProgramTypeDocumentType,
	fkProgramType,
	fkDocumentType
FROM	JoinProgramTypeDocumentType
WHERE 	(@pkJoinProgramTypeDocumentType IS NULL OR pkJoinProgramTypeDocumentType = @pkJoinProgramTypeDocumentType)
 AND 	(@fkProgramType IS NULL OR fkProgramType = @fkProgramType)
 AND 	(@fkDocumentType IS NULL OR fkDocumentType = @fkDocumentType)
 

