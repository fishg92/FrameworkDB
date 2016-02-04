
CREATE PROCEDURE [dbo].[spPSPDeletePSPJoinDocSplitKeyword]
(
	@pkPSPJoinDocSplitKeyword decimal(18,0)
)
AS

	DELETE FROM PSPJoinDocSplitKeyword WHERE pkPSPJoinDocSplitKeyword = @pkPSPJoinDocSplitKeyword
