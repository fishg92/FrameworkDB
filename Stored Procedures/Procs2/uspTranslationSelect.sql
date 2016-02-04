----------------------------------------------------------------------------
-- Select a single record from Translation
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspTranslationSelect]
(	@pkTranslation decimal(18, 0) = NULL,
	@fkScreenControl decimal(18, 0) = NULL,
	@fkLanguage decimal(18, 0) = NULL,
	@Description varchar(500) = NULL,
	@DisplayText nvarchar(1000) = NULL,
	@Context varchar(50) = NULL,
	@Sequence int = NULL,
	@ItemKey varchar(200) = NULL
)
AS

SELECT	pkTranslation,
	fkScreenControl,
	fkLanguage,
	Description,
	DisplayText,
	Context,
	Sequence,
	ItemKey
FROM	Translation
WHERE 	(@pkTranslation IS NULL OR pkTranslation = @pkTranslation)
 AND 	(@fkScreenControl IS NULL OR fkScreenControl = @fkScreenControl)
 AND 	(@fkLanguage IS NULL OR fkLanguage = @fkLanguage)
 AND 	(@Description IS NULL OR Description LIKE @Description + '%')
 AND 	(@DisplayText IS NULL OR DisplayText LIKE @DisplayText + '%')
 AND 	(@Context IS NULL OR Context LIKE @Context + '%')
 AND 	(@Sequence IS NULL OR Sequence = @Sequence)
 AND 	(@ItemKey IS NULL OR ItemKey LIKE @ItemKey + '%')
