-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in ProfileSetting
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspProfileSettingUpdate]
(	  @pkProfileSetting int
	, @Grouping varchar(200) = NULL
	, @ItemKey varchar(200) = NULL
	, @ItemValue varchar(max) = NULL
	, @AppID int = NULL
	, @fkProfile decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	ProfileSetting
SET	Grouping = ISNULL(@Grouping, Grouping),
	ItemKey = ISNULL(@ItemKey, ItemKey),
	ItemValue = ISNULL(@ItemValue, ItemValue),
	AppID = ISNULL(@AppID, AppID),
	fkProfile = ISNULL(@fkProfile, fkProfile)
WHERE 	pkProfileSetting = @pkProfileSetting
