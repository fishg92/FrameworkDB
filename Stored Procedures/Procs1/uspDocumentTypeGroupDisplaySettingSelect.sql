

----------------------------------------------------------------------------
-- Select a single record from DocumentTypeGroupDisplaySetting
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspDocumentTypeGroupDisplaySettingSelect]
(	@pkDocumentTypeGroupDisplaySetting decimal(18, 0) = NULL,
	@fkDocumentTypeGroup varchar(50) = NULL,
	@DisplayColor int = NULL,
	@Sequence int = NULL
)
AS

SELECT	pkDocumentTypeGroupDisplaySetting,
	fkDocumentTypeGroup,
	DisplayColor,
	Sequence
FROM	DocumentTypeGroupDisplaySetting
WHERE 	(@pkDocumentTypeGroupDisplaySetting IS NULL OR pkDocumentTypeGroupDisplaySetting = @pkDocumentTypeGroupDisplaySetting)
 AND 	(@fkDocumentTypeGroup IS NULL OR fkDocumentTypeGroup = @fkDocumentTypeGroup)
 AND 	(@DisplayColor IS NULL OR DisplayColor = @DisplayColor)
 AND 	(@Sequence IS NULL OR Sequence = @Sequence)



