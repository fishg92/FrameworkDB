-- Stored Procedure

CREATE PROCEDURE [dbo].[uspPSPSettingSave]
(
	  @SettingName varchar(200)
	, @SettingValue varchar(500)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

	IF EXISTS(SELECT * FROM PSPSetting WHERE SettingName = @SettingName)
	BEGIN
		UPDATE PSPSetting Set SettingValue = @SettingValue WHERE SettingName = @SettingName
	END
	ELSE
	BEGIN
		INSERT INTO PSPSetting(SettingName, SettingValue)  VALUES(@SettingName, @SettingValue)
	END
