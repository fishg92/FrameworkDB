CREATE PROCEDURE [dbo].[uspPSPSettingGet]
(
	  @SettingName varchar(200)
	, @SettingValue varchar(500) output
)
AS

	SET @SettingValue = (SELECT TOP 1 SettingValue FROM PSPSetting WHERE SettingName = @SettingName)