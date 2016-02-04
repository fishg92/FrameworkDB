----------------------------------------------------------------------------
-- Insert a single record into PSPJoinDocSplitKeyword
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspPSPJoinDocSplitKeywordInsert]
(	  @fkPSPDocSplit decimal(18, 0)
	, @fkPSPKeyword decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkPSPJoinDocSplitKeyword decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT PSPJoinDocSplitKeyword
(	  fkPSPDocSplit
	, fkPSPKeyword
)
VALUES 
(	  @fkPSPDocSplit
	, @fkPSPKeyword

)

SET @pkPSPJoinDocSplitKeyword = SCOPE_IDENTITY()
