----------------------------------------------------------------------------
-- Insert a single record into ScreenControl
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspScreenControlInsert]
(	  @ControlName varchar(100)
	, @fkScreenName decimal(18, 0)
	, @Sequence int = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkScreenControl decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT ScreenControl
(	  pkScreenControl
	, ControlName
	, fkScreenName
	, Sequence
)
VALUES 
(	  @pkScreenControl
	, @ControlName
	, @fkScreenName
	, COALESCE(@Sequence, (0))

)

SET @pkScreenControl = SCOPE_IDENTITY()
