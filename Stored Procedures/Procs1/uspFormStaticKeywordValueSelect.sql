
----------------------------------------------------------------------------
-- Select a single record from FormStaticKeywordValue
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormStaticKeywordValueSelect]
(	@pkFormStaticKeywordValue decimal(10, 0) = NULL,
	@StaticKeywordValue varchar(100) = NULL
)
AS

SELECT	pkFormStaticKeywordValue,
	StaticKeywordValue
FROM	FormStaticKeywordValue
WHERE 	(@pkFormStaticKeywordValue IS NULL OR pkFormStaticKeywordValue = @pkFormStaticKeywordValue)
 AND 	(@StaticKeywordValue IS NULL OR StaticKeywordValue LIKE @StaticKeywordValue + '%')