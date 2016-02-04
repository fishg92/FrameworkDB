

CREATE PROCEDURE [dbo].[spPSPUpdateSetting]
(
	  @SettingName varchar(200)
	, @SettingValue varchar(500)
)
AS

	IF EXISTS(SELECT TOP 1 pkPSPSetting FROM PSPSetting WHERE RTRIM(LTRIM(UPPER(SettingName))) = RTRIM(LTRIM(UPPER(@SettingName))))
	BEGIN
		UPDATE PSPSetting SET
		SettingValue = @SettingValue
		WHERE RTRIM(LTRIM(UPPER(SettingName))) = RTRIM(LTRIM(UPPER(@SettingName)))
	END
	ELSE
	BEGIN
		INSERT INTO PSPSetting
		(
			  SettingName
			, SettingValue
		)
		VALUES
		(
			  @SettingName
			, @SettingValue
		)
	END

