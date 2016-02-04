-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in UserSettings
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspUserSettingsUpdate]
(	  @pkUserSettings decimal(10, 0)
	, @fkApplicationUser decimal(18, 0) = NULL
	, @Grouping varchar(200) = NULL
	, @ItemKey varchar(200) = NULL
	, @ItemValue varchar(600) = NULL
	, @ItemDescription varchar(300) = NULL
	, @AppID int = NULL
	, @Sequence bigint = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	UserSettings
SET	fkApplicationUser = ISNULL(@fkApplicationUser, fkApplicationUser),
	Grouping = ISNULL(@Grouping, Grouping),
	ItemKey = ISNULL(@ItemKey, ItemKey),
	ItemValue = ISNULL(@ItemValue, ItemValue),
	ItemDescription = ISNULL(@ItemDescription, ItemDescription),
	AppID = ISNULL(@AppID, AppID),
	Sequence = ISNULL(COALESCE(@Sequence, (1)), Sequence)
WHERE 	pkUserSettings = @pkUserSettings
