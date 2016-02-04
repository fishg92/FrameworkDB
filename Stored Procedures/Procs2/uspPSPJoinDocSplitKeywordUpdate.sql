----------------------------------------------------------------------------
-- Update a single record in PSPJoinDocSplitKeyword
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspPSPJoinDocSplitKeywordUpdate]
(	  @pkPSPJoinDocSplitKeyword decimal(18, 0)
	, @fkPSPDocSplit decimal(18, 0) = NULL
	, @fkPSPKeyword decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	PSPJoinDocSplitKeyword
SET	fkPSPDocSplit = ISNULL(@fkPSPDocSplit, fkPSPDocSplit),
	fkPSPKeyword = ISNULL(@fkPSPKeyword, fkPSPKeyword)
WHERE 	pkPSPJoinDocSplitKeyword = @pkPSPJoinDocSplitKeyword
