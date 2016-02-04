----------------------------------------------------------------------------
-- Update a single record in CPSmartFillKeywordMapping
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPSmartFillKeywordMappingUpdate]
(	  @pkCPSmartFillKeywordMapping decimal(18, 0)
	, @PeopleKeyword varchar(100) = NULL
	, @SmartFillAlias varchar(100) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	CPSmartFillKeywordMapping
SET	PeopleKeyword = ISNULL(@PeopleKeyword, PeopleKeyword),
	SmartFillAlias = ISNULL(@SmartFillAlias, SmartFillAlias)
WHERE 	pkCPSmartFillKeywordMapping = @pkCPSmartFillKeywordMapping
