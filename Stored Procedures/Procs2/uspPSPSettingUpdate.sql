----------------------------------------------------------------------------
-- Update a single record in PSPSetting
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspPSPSettingUpdate]
(	  @pkPSPSetting decimal(18, 0)
	, @SettingName varchar(200) = NULL
	, @SettingValue varchar(500) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	PSPSetting
SET	SettingName = ISNULL(@SettingName, SettingName),
	SettingValue = ISNULL(@SettingValue, SettingValue)
WHERE 	pkPSPSetting = @pkPSPSetting
