----------------------------------------------------------------------------
-- Insert a single record into KeywordTypeCPKeywordName
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspKeywordTypeCPKeywordNameInsert]
(	  @fkKeywordType varchar(50)
	, @CPKeywordName varchar(50)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkKeywordTypeCPKeywordName decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT KeywordTypeCPKeywordName
(	  fkKeywordType
	, CPKeywordName
)
VALUES 
(	  @fkKeywordType
	, @CPKeywordName

)

SET @pkKeywordTypeCPKeywordName = SCOPE_IDENTITY()
