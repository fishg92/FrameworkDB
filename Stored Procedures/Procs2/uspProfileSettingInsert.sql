-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into ProfileSetting
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspProfileSettingInsert]
(	  @Grouping varchar(200)
	, @ItemKey varchar(200)
	, @ItemValue varchar(max)
	, @AppID int
	, @fkProfile decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkProfileSetting decimal(10, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT ProfileSetting
(	  Grouping
	, ItemKey
	, ItemValue
	, AppID
	, fkProfile
)
VALUES 
(	  @Grouping
	, @ItemKey
	, @ItemValue
	, @AppID
	, @fkProfile

)

SET @pkProfileSetting = SCOPE_IDENTITY()
