

----------------------------------------------------------------------------
-- Select a single record from DocumentTypeGroupKeywordTypeTabDisplaySetting
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspDocumentTypeGroupKeywordTypeTabDisplaySettingSelect]
(	@pkDocumentTypeGroupKeywordTypeTabDisplaySetting decimal(18, 0) = NULL,
	@fkDocumentTypeGroup decimal(18, 0) = NULL,
	@fkKeywordType varchar(50) = NULL,
	@Sequence int = NULL
)
AS

SELECT	pkDocumentTypeGroupKeywordTypeTabDisplaySetting,
	fkDocumentTypeGroup,
	fkKeywordType,
	Sequence
FROM	DocumentTypeGroupKeywordTypeTabDisplaySetting
WHERE 	(@pkDocumentTypeGroupKeywordTypeTabDisplaySetting IS NULL OR pkDocumentTypeGroupKeywordTypeTabDisplaySetting = @pkDocumentTypeGroupKeywordTypeTabDisplaySetting)
 AND 	(@fkDocumentTypeGroup IS NULL OR fkDocumentTypeGroup = @fkDocumentTypeGroup)
 AND 	(@fkKeywordType IS NULL OR fkKeywordType = @fkKeywordType)
 AND 	(@Sequence IS NULL OR Sequence = @Sequence)
 

