----------------------------------------------------------------------------
-- Insert a single record into TaskGridProfileColumnSetting
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspTaskGridProfileColumnSettingInsert]
(	  @fkProfile decimal(18, 0)
	, @SettingsData varchar(MAX)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkTaskGridProfileColumnSetting decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT TaskGridProfileColumnSetting
(	  fkProfile
	, SettingsData
)
VALUES 
(	  @fkProfile
	, @SettingsData

)

SET @pkTaskGridProfileColumnSetting = SCOPE_IDENTITY()
