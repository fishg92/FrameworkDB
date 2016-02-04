----------------------------------------------------------------------------
-- Update a single record in TaskGridProfileColumnSetting
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspTaskGridProfileColumnSettingUpdate]
(	  @pkTaskGridProfileColumnSetting decimal(18, 0)
	, @fkProfile decimal(18, 0) = NULL
	, @SettingsData varchar(MAX) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	TaskGridProfileColumnSetting
SET	fkProfile = ISNULL(@fkProfile, fkProfile),
	SettingsData = ISNULL(@SettingsData, SettingsData)
WHERE 	pkTaskGridProfileColumnSetting = @pkTaskGridProfileColumnSetting
