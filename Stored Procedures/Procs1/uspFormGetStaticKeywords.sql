CREATE PROCEDURE [dbo].[uspFormGetStaticKeywords]
(	
	@pkFormName decimal(18,0)
)
AS

SELECT 	  UPPER(RTRIM(LTRIM(n.fkKeywordType))) AS fkKeywordType
		, RTRIM(LTRIM(v.StaticKeywordValue)) AS StaticKeywordValue
FROM 	FormJoinFormStaticKeywordNameFormStaticKeywordValue j
JOIN	FormStaticKeywordName n ON j.fkFormStaticKeywordName = n.pkFormStaticKeywordName
JOIN	FormStaticKeywordValue v ON j.fkFormStaticKeywordValue = v.pkFormStaticKeywordValue
WHERE	fkFormName = @pkFormName
