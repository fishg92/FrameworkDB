----------------------------------------------------------------------------
-- Update a single record in TaskGridColumnSetting
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspTaskGridColumnSettingUpdate]
(	  @pkTaskGridColumnSetting decimal(18, 0)
	, @fkApplicationUser decimal(18, 0) = NULL
	, @SettingsData varchar(MAX) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	TaskGridColumnSetting
SET	fkApplicationUser = ISNULL(@fkApplicationUser, fkApplicationUser),
	SettingsData = ISNULL(@SettingsData, SettingsData)
WHERE 	pkTaskGridColumnSetting = @pkTaskGridColumnSetting
