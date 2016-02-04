
CREATE PROCEDURE [dbo].[spPSPDeletePSPJoinDocSplitKeywordByDoc]
(
	@fkPSPDocSplit decimal(18,0)
)
AS

	DELETE FROM PSPJoinDocSplitKeyword WHERE fkPSPDocSplit = @fkPSPDocSplit
