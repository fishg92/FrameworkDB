----------------------------------------------------------------------------
-- Select a single record from PSPSetting
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspPSPSettingSelect]
(	@pkPSPSetting decimal(18, 0) = NULL,
	@SettingName varchar(200) = NULL,
	@SettingValue varchar(500) = NULL
)
AS

SELECT	pkPSPSetting,
	SettingName,
	SettingValue
FROM	PSPSetting
WHERE 	(@pkPSPSetting IS NULL OR pkPSPSetting = @pkPSPSetting)
 AND 	(@SettingName IS NULL OR SettingName LIKE @SettingName + '%')
 AND 	(@SettingValue IS NULL OR SettingValue LIKE @SettingValue + '%')

