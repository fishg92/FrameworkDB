----------------------------------------------------------------------------
-- Select a single record from KeywordTypeCPKeywordName
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspKeywordTypeCPKeywordNameSelect]
(	@pkKeywordTypeCPKeywordName decimal(18, 0) = NULL,
	@fkKeywordType varchar(50) = NULL,
	@CPKeywordName varchar(50) = NULL
)
AS

SELECT	pkKeywordTypeCPKeywordName,
	fkKeywordType,
	CPKeywordName
FROM	KeywordTypeCPKeywordName
WHERE 	(@pkKeywordTypeCPKeywordName IS NULL OR pkKeywordTypeCPKeywordName = @pkKeywordTypeCPKeywordName)
 AND 	(@fkKeywordType IS NULL OR fkKeywordType LIKE @fkKeywordType + '%')
 AND 	(@CPKeywordName IS NULL OR CPKeywordName LIKE @CPKeywordName + '%')

