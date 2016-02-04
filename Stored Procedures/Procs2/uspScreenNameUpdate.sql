----------------------------------------------------------------------------
-- Update a single record in ScreenName
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspScreenNameUpdate]
(	  @pkScreenName decimal(18, 0)
	, @Description varchar(50) = NULL
	, @AppID decimal(18, 0) = NULL
	, @FriendlyDescription varchar(100) = NULL
	, @Sequence int = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	ScreenName
SET	Description = ISNULL(@Description, Description),
	AppID = ISNULL(@AppID, AppID),
	FriendlyDescription = ISNULL(@FriendlyDescription, FriendlyDescription),
	Sequence = ISNULL(@Sequence, Sequence)
WHERE 	pkScreenName = @pkScreenName
