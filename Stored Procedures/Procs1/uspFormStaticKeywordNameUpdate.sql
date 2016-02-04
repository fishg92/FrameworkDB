-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in FormStaticKeywordName
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormStaticKeywordNameUpdate]
(	  @pkFormStaticKeywordName int
	, @fkKeywordType varchar(50) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	FormStaticKeywordName
SET	fkKeywordType = ISNULL(UPPER(@fkKeywordType), fkKeywordType)
WHERE 	pkFormStaticKeywordName = @pkFormStaticKeywordName
