
----------------------------------------------------------------------------
-- Select a single record from FormJoinFormStaticKeywordNameFormStaticKeywordValue
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormJoinFormStaticKeywordNameFormStaticKeywordValueSelect]
(	@pkFormJoinFormStaticKeywordNameFormStaticKeywordValue decimal(10, 0) = NULL,
	@fkFormStaticKeywordName decimal(10, 0) = NULL,
	@fkFormStaticKeywordValue decimal(10, 0) = NULL,
	@fkFormName decimal(10, 0) = NULL
)
AS

SELECT	pkFormJoinFormStaticKeywordNameFormStaticKeywordValue,
	fkFormStaticKeywordName,
	fkFormStaticKeywordValue,
	fkFormName
FROM	FormJoinFormStaticKeywordNameFormStaticKeywordValue
WHERE 	(@pkFormJoinFormStaticKeywordNameFormStaticKeywordValue IS NULL OR pkFormJoinFormStaticKeywordNameFormStaticKeywordValue = @pkFormJoinFormStaticKeywordNameFormStaticKeywordValue)
 AND 	(@fkFormStaticKeywordName IS NULL OR fkFormStaticKeywordName = @fkFormStaticKeywordName)
 AND 	(@fkFormStaticKeywordValue IS NULL OR fkFormStaticKeywordValue = @fkFormStaticKeywordValue)
 AND 	(@fkFormName IS NULL OR fkFormName = @fkFormName)




