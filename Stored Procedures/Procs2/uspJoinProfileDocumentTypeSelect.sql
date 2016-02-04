----------------------------------------------------------------------------
-- Select a single record from JoinProfileDocumentType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinProfileDocumentTypeSelect]
(	@pkJoinProfileDocumentType decimal(18, 0) = NULL,
	@fkProfile decimal(18, 0) = NULL,
	@fkDocumentType varchar(50) = NULL
)
AS

SELECT	pkJoinProfileDocumentType,
	fkProfile,
	fkDocumentType
	
FROM	JoinProfileDocumentType
WHERE 	(@pkJoinProfileDocumentType IS NULL OR pkJoinProfileDocumentType = @pkJoinProfileDocumentType)
 AND 	(@fkProfile IS NULL OR fkProfile = @fkProfile)
 AND 	(@fkDocumentType IS NULL OR fkDocumentType LIKE @fkDocumentType + '%')


