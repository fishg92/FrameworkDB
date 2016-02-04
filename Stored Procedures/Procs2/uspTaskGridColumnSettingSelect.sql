----------------------------------------------------------------------------
-- Select a single record from TaskGridColumnSetting
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspTaskGridColumnSettingSelect]
(	@pkTaskGridColumnSetting decimal(18, 0) = NULL,
	@fkApplicationUser decimal(18, 0) = NULL,
	@SettingsData varchar(MAX) = NULL
)
AS

SELECT	pkTaskGridColumnSetting,
	fkApplicationUser,
	SettingsData
FROM	TaskGridColumnSetting
WHERE 	(@pkTaskGridColumnSetting IS NULL OR pkTaskGridColumnSetting = @pkTaskGridColumnSetting)
 AND 	(@fkApplicationUser IS NULL OR fkApplicationUser = @fkApplicationUser)
 AND 	(@SettingsData IS NULL OR SettingsData LIKE @SettingsData + '%')
