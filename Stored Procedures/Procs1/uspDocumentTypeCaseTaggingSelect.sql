----------------------------------------------------------------------------
-- Select a single record from DocumentTypeCaseTagging
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspDocumentTypeCaseTaggingSelect]
(	@pkDocumentTypeCaseTagging decimal(18, 0) = NULL,
	@fkDocumentType varchar(50) = NULL
)
AS

SELECT	pkDocumentTypeCaseTagging,
	fkDocumentType
FROM	DocumentTypeCaseTagging
WHERE 	(@pkDocumentTypeCaseTagging IS NULL OR pkDocumentTypeCaseTagging = @pkDocumentTypeCaseTagging)
 AND 	(@fkDocumentType IS NULL OR fkDocumentType LIKE @fkDocumentType + '%')


