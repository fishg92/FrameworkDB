

CREATE PROCEDURE [dbo].[spPSPInsertPSPJoinDocSplitKeyword]
(
	  @fkPSPDocSplit decimal(18,0)
	, @fkPSPKeyword decimal(18,0)
	, @pkPSPJoinDocSplitKeyword decimal(18,0) OUTPUT
)
AS

	SET @pkPSPJoinDocSplitKeyword = (SELECT pkPSPJoinDocSplitKeyword FROM PSPJoinDocSplitKeyword WHERE fkPSPDocSplit = @fkPSPDocSplit AND fkPSPKeyword = @fkPSPKeyword)
	
	IF ISNULL(@pkPSPJoinDocSplitKeyword,0) = 0
	BEGIN
		INSERT INTO PSPJoinDocSplitKeyword
		(
			  fkPSPDocSplit
			, fkPSPKeyword
		)
		VALUES
		(
			  @fkPSPDocSplit
			, @fkPSPKeyword
		)
		SET @pkPSPJoinDocSplitKeyword = SCOPE_IDENTITY()
	END

