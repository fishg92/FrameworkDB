----------------------------------------------------------------------------
-- Insert a single record into PSPSetting
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspPSPSettingInsert]
(	  @SettingName varchar(200)
	, @SettingValue varchar(500)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkPSPSetting decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT PSPSetting
(	  SettingName
	, SettingValue
)
VALUES 
(	  @SettingName
	, @SettingValue

)

SET @pkPSPSetting = SCOPE_IDENTITY()
