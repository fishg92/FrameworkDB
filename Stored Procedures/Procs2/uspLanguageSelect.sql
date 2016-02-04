----------------------------------------------------------------------------
-- Select a single record from Language
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspLanguageSelect]
(	@pkLanguage decimal(18, 0) = NULL,
	@Description varchar(50) = NULL,
	@Active bit = NULL,
	@DisplayText nvarchar(100) = NULL
)
AS

SELECT	pkLanguage,
	Description,
	Active,
	DisplayText
FROM	Language
WHERE 	(@pkLanguage IS NULL OR pkLanguage = @pkLanguage)
 AND 	(@Description IS NULL OR Description LIKE @Description + '%')
 AND 	(@Active IS NULL OR Active = @Active)
 AND 	(@DisplayText IS NULL OR DisplayText LIKE @DisplayText + '%')
