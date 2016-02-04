----------------------------------------------------------------------------
-- Select a single record from ProfileStaticKeywords
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspProfileStaticKeywordsSelect]
(	@pkProfileStaticKeywords decimal(18, 0) = NULL,
	@fkProfile decimal(18, 0) = NULL,
	@fkKeywordType varchar(50) = NULL,
	@KeywordValue varchar(100) = NULL,
	@LUPUser varchar(50) = NULL,
	@LUPDate datetime = NULL,
	@CreateUser varchar(50) = NULL,
	@CreateDate datetime = NULL
)
AS

SELECT	pkProfileStaticKeywords,
	fkProfile,
	fkKeywordType,
	KeywordValue,
	LUPUser,
	LUPDate,
	CreateUser,
	CreateDate
FROM	ProfileStaticKeywords
WHERE 	(@pkProfileStaticKeywords IS NULL OR pkProfileStaticKeywords = @pkProfileStaticKeywords)
 AND 	(@fkProfile IS NULL OR fkProfile = @fkProfile)
 AND 	(@fkKeywordType IS NULL OR fkKeywordType LIKE @fkKeywordType + '%')
 AND 	(@KeywordValue IS NULL OR KeywordValue LIKE @KeywordValue + '%')
 AND 	(@LUPUser IS NULL OR LUPUser LIKE @LUPUser + '%')
 AND 	(@LUPDate IS NULL OR LUPDate = @LUPDate)
 AND 	(@CreateUser IS NULL OR CreateUser LIKE @CreateUser + '%')
 AND 	(@CreateDate IS NULL OR CreateDate = @CreateDate)

