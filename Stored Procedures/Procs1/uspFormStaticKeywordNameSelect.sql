

----------------------------------------------------------------------------
-- Select a single record from FormStaticKeywordName
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormStaticKeywordNameSelect]
(	@pkFormStaticKeywordName decimal(10, 0) = NULL,
	@fkKeywordType varchar(50) = NULL
)
AS

SELECT	pkFormStaticKeywordName,
	fkKeywordType
FROM	FormStaticKeywordName
WHERE 	(@pkFormStaticKeywordName IS NULL OR pkFormStaticKeywordName = @pkFormStaticKeywordName)
 AND 	(@fkKeywordType IS NULL OR UPPER(fkKeywordType) = UPPER(@fkKeywordType))


