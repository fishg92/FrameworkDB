----------------------------------------------------------------------------
-- Select a single record from TaskGridProfileColumnSetting
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspTaskGridProfileColumnSettingSelect]
(	@pkTaskGridProfileColumnSetting decimal(18, 0) = NULL,
	@fkProfile decimal(18, 0) = NULL,
	@SettingsData varchar(MAX) = NULL
)
AS

SELECT	pkTaskGridProfileColumnSetting,
	fkProfile,
	SettingsData
FROM	TaskGridProfileColumnSetting
WHERE 	(@pkTaskGridProfileColumnSetting IS NULL OR pkTaskGridProfileColumnSetting = @pkTaskGridProfileColumnSetting)
 AND 	(@fkProfile IS NULL OR fkProfile = @fkProfile)
 AND 	(@SettingsData IS NULL OR SettingsData LIKE @SettingsData + '%')

