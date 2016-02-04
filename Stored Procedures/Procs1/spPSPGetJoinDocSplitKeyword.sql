
CREATE PROCEDURE [dbo].[spPSPGetJoinDocSplitKeyword]
(
	@fkPSPDocSplit decimal(18,0)
)
AS

	SELECT * FROM PSPJoinDocSplitKeyword WHERE fkPSPDocSplit = @fkPSPDocSplit
