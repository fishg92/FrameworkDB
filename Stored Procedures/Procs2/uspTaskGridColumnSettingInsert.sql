----------------------------------------------------------------------------
-- Insert a single record into TaskGridColumnSetting
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspTaskGridColumnSettingInsert]
(	  @fkApplicationUser decimal(18, 0)
	, @SettingsData varchar(MAX)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkTaskGridColumnSetting decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT TaskGridColumnSetting
(	  fkApplicationUser
	, SettingsData
)
VALUES 
(	  @fkApplicationUser
	, @SettingsData

)

SET @pkTaskGridColumnSetting = SCOPE_IDENTITY()
