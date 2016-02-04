----------------------------------------------------------------------------
-- Insert a single record into ProfileStaticKeywords
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspProfileStaticKeywordsInsert]
(	  @fkProfile decimal(18, 0)
	, @fkKeywordType varchar(50)
	, @KeywordValue varchar(100)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkProfileStaticKeywords decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT ProfileStaticKeywords
(	  fkProfile
	, fkKeywordType
	, KeywordValue
)
VALUES 
(	  @fkProfile
	, @fkKeywordType
	, @KeywordValue

)

SET @pkProfileStaticKeywords = SCOPE_IDENTITY()
