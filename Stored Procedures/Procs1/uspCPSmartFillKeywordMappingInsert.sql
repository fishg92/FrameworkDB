----------------------------------------------------------------------------
-- Insert a single record into CPSmartFillKeywordMapping
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspCPSmartFillKeywordMappingInsert]
(	  @PeopleKeyword varchar(100) = NULL
	, @SmartFillAlias varchar(100) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkCPSmartFillKeywordMapping decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT CPSmartFillKeywordMapping
(	  PeopleKeyword
	, SmartFillAlias
)
VALUES 
(	  @PeopleKeyword
	, @SmartFillAlias

)

SET @pkCPSmartFillKeywordMapping = SCOPE_IDENTITY()
