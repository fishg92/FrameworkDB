----------------------------------------------------------------------------
-- Select a single record from ScreenName
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspScreenNameSelect]
(	@pkScreenName decimal(18, 0) = NULL,
	@Description varchar(50) = NULL,
	@AppID decimal(18, 0) = NULL,
	@FriendlyDescription varchar(100) = NULL,
	@Sequence int = NULL
)
AS

SELECT	pkScreenName,
	Description,
	AppID,
	FriendlyDescription,
	Sequence
FROM	ScreenName
WHERE 	(@pkScreenName IS NULL OR pkScreenName = @pkScreenName)
 AND 	(@Description IS NULL OR Description LIKE @Description + '%')
 AND 	(@AppID IS NULL OR AppID = @AppID)
 AND 	(@FriendlyDescription IS NULL OR FriendlyDescription LIKE @FriendlyDescription + '%')
 AND 	(@Sequence IS NULL OR Sequence = @Sequence)
