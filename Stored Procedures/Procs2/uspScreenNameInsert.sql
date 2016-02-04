----------------------------------------------------------------------------
-- Insert a single record into ScreenName
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspScreenNameInsert]
(	  @Description varchar(50)
	, @AppID decimal(18, 0)
	, @FriendlyDescription varchar(100) = NULL
	, @Sequence int = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkScreenName decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT ScreenName
(	  pkScreenName
	, Description
	, AppID
	, FriendlyDescription
	, Sequence
)
VALUES 
(	  @pkScreenName
	, @Description
	, @AppID
	, @FriendlyDescription
	, COALESCE(@Sequence, (0))

)

SET @pkScreenName = SCOPE_IDENTITY()
