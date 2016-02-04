
----------------------------------------------------------------------------
-- Select a single record from FormJoinStaticKeywordNameFormName
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormJoinStaticKeywordNameFormNameSelect]
(	@pkFormJoinStaticKeywordNameFormName decimal(10, 0) = NULL,
	@fkFormName decimal(10, 0) = NULL,
	@fkFormStaticKeywordName decimal(10, 0) = NULL
)
AS

SELECT	pkFormJoinStaticKeywordNameFormName,
	fkFormName,
	fkFormStaticKeywordName
FROM	FormJoinStaticKeywordNameFormName
WHERE 	(@pkFormJoinStaticKeywordNameFormName IS NULL OR pkFormJoinStaticKeywordNameFormName = @pkFormJoinStaticKeywordNameFormName)
 AND 	(@fkFormName IS NULL OR fkFormName = @fkFormName)
 AND 	(@fkFormStaticKeywordName IS NULL OR fkFormStaticKeywordName = @fkFormStaticKeywordName)



