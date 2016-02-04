----------------------------------------------------------------------------
-- Update a single record in KeywordTypeCPKeywordName
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspKeywordTypeCPKeywordNameUpdate]
(	  @pkKeywordTypeCPKeywordName decimal(18, 0)
	, @fkKeywordType varchar(50) = NULL
	, @CPKeywordName varchar(50) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	KeywordTypeCPKeywordName
SET	fkKeywordType = ISNULL(@fkKeywordType, fkKeywordType),
	CPKeywordName = ISNULL(@CPKeywordName, CPKeywordName)
WHERE 	pkKeywordTypeCPKeywordName = @pkKeywordTypeCPKeywordName
