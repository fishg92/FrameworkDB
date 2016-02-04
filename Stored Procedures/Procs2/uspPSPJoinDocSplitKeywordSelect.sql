----------------------------------------------------------------------------
-- Select a single record from PSPJoinDocSplitKeyword
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspPSPJoinDocSplitKeywordSelect]
(	@pkPSPJoinDocSplitKeyword decimal(18, 0) = NULL,
	@fkPSPDocSplit decimal(18, 0) = NULL,
	@fkPSPKeyword decimal(18, 0) = NULL
)
AS

SELECT	pkPSPJoinDocSplitKeyword,
	fkPSPDocSplit,
	fkPSPKeyword
FROM	PSPJoinDocSplitKeyword
WHERE 	(@pkPSPJoinDocSplitKeyword IS NULL OR pkPSPJoinDocSplitKeyword = @pkPSPJoinDocSplitKeyword)
 AND 	(@fkPSPDocSplit IS NULL OR fkPSPDocSplit = @fkPSPDocSplit)
 AND 	(@fkPSPKeyword IS NULL OR fkPSPKeyword = @fkPSPKeyword)
 
