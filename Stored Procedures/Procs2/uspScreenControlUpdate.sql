----------------------------------------------------------------------------
-- Update a single record in ScreenControl
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspScreenControlUpdate]
(	  @pkScreenControl decimal(18, 0)
	, @ControlName varchar(100) = NULL
	, @fkScreenName decimal(18, 0) = NULL
	, @Sequence int = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	ScreenControl
SET	ControlName = ISNULL(@ControlName, ControlName),
	fkScreenName = ISNULL(@fkScreenName, fkScreenName),
	Sequence = ISNULL(@Sequence, Sequence)
WHERE 	pkScreenControl = @pkScreenControl
