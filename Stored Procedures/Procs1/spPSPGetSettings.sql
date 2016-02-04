
CREATE PROCEDURE [dbo].[spPSPGetSettings]
(
	@SettingName varchar(200)
)
AS

	IF (LEN(@SettingName) = 0)
	BEGIN
		SELECT * FROM PSPSetting
	END
	ELSE
	BEGIN	
		SELECT * FROM PSPSetting WHERE SettingName = @SettingName
	END
