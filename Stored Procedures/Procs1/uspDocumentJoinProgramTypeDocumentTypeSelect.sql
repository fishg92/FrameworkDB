

----------------------------------------------------------------------------
-- Select a single record from DocumentJoinProgramTypeDocumentType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspDocumentJoinProgramTypeDocumentTypeSelect]
(	@pkDocumentJoinProgramTypeDocumentType decimal(18, 0) = NULL,
	@fkProgramType decimal(18, 0) = NULL,
	@fkDocumentType varchar(50) = NULL
)
AS

SELECT	pkDocumentJoinProgramTypeDocumentType,
	fkProgramType,
	fkDocumentType
    
FROM	DocumentJoinProgramTypeDocumentType
WHERE 	(@pkDocumentJoinProgramTypeDocumentType IS NULL OR pkDocumentJoinProgramTypeDocumentType = @pkDocumentJoinProgramTypeDocumentType)
 AND 	(@fkProgramType IS NULL OR fkProgramType = @fkProgramType)
 AND 	(@fkDocumentType IS NULL OR fkDocumentType = @fkDocumentType)
 


