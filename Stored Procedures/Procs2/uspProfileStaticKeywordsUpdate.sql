----------------------------------------------------------------------------
-- Update a single record in ProfileStaticKeywords
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspProfileStaticKeywordsUpdate]
(	  @pkProfileStaticKeywords decimal(18, 0)
	, @fkProfile decimal(18, 0) = NULL
	, @fkKeywordType varchar(50) = NULL
	, @KeywordValue varchar(100) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	ProfileStaticKeywords
SET	fkProfile = ISNULL(@fkProfile, fkProfile),
	fkKeywordType = ISNULL(@fkKeywordType, fkKeywordType),
	KeywordValue = ISNULL(@KeywordValue, KeywordValue)
WHERE 	pkProfileStaticKeywords = @pkProfileStaticKeywords
