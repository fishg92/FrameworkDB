----------------------------------------------------------------------------
-- Select a single record from ScreenControl
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspScreenControlSelect]
(	@pkScreenControl decimal(18, 0) = NULL,
	@ControlName varchar(100) = NULL,
	@fkScreenName decimal(18, 0) = NULL,
	@Sequence int = NULL
)
AS

SELECT	pkScreenControl,
	ControlName,
	fkScreenName,
	Sequence
FROM	ScreenControl
WHERE 	(@pkScreenControl IS NULL OR pkScreenControl = @pkScreenControl)
 AND 	(@ControlName IS NULL OR ControlName LIKE @ControlName + '%')
 AND 	(@fkScreenName IS NULL OR fkScreenName = @fkScreenName)
 AND 	(@Sequence IS NULL OR Sequence = @Sequence)
