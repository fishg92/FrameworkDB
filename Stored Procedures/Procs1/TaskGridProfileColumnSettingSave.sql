CREATE proc [dbo].[TaskGridProfileColumnSettingSave]
	@fkprofile decimal
	,@SettingsData varchar(max)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)

as

declare @pkTaskGridProfileColumnSetting decimal

select	@pkTaskGridProfileColumnSetting = pkTaskGridProfileColumnSetting
from	TaskGridProfileColumnSetting
where	fkProfile = @fkProfile

if @pkTaskGridProfileColumnSetting is null
	begin
	exec dbo.uspTaskGridProfileColumnSettingInsert
		@fkProfile = @fkProfile
		, @SettingsData = @SettingsData
		, @LUPUser = @LUPUser
		, @LUPMac = @LUPMac
		, @LUPIP = @LUPIP
		, @LUPMachine = @LUPMachine
	end
else
	begin
	exec dbo.uspTaskGridProfileColumnSettingUpdate
		@pkTaskGridProfileColumnSetting = @pkTaskGridProfileColumnSetting
		, @fkProfile = @fkProfile
		, @SettingsData = @SettingsData
		, @LUPUser = @LUPUser
		, @LUPMac = @LUPMac
		, @LUPIP = @LUPIP
		, @LUPMachine = @LUPMachine
	end