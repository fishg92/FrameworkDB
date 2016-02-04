-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into UserSettings
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspUserSettingsInsert]
(	  @fkApplicationUser decimal(18, 0)
	, @Grouping varchar(200)
	, @ItemKey varchar(200)
	, @ItemValue varchar(600)
	, @ItemDescription varchar(300)
	, @AppID int
	, @Sequence bigint = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkUserSettings decimal(10, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT UserSettings
(	  fkApplicationUser
	, Grouping
	, ItemKey
	, ItemValue
	, ItemDescription
	, AppID
	, Sequence
)
VALUES 
(	  @fkApplicationUser
	, @Grouping
	, @ItemKey
	, @ItemValue
	, @ItemDescription
	, @AppID
	, COALESCE(@Sequence, (1))

)

SET @pkUserSettings = SCOPE_IDENTITY()
