----------------------------------------------------------------------------
-- Delete a single record from ProfileStaticKeywords
----------------------------------------------------------------------------
CREATE PROC [dbo].[ProfileStaticKeywordsDeleteByProfileAndKeywordType]
(	@fkProfile decimal(18, 0)
	, @fkKeywordType varchar(50)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

DELETE	ProfileStaticKeywords
WHERE 	fkProfile = @fkProfile
AND		fkKeywordType = @fkKeywordType
