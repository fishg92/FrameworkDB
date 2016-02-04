CREATE proc [dbo].[TaskGridColumnSettingSave]
	@fkApplicationUser decimal
	,@SettingsData varchar(max)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)

as

declare @pkTaskGridColumnSetting decimal

select	@pkTaskGridColumnSetting = pkTaskGridColumnSetting
from	TaskGridColumnSetting
where	fkApplicationUser = @fkApplicationUser

if @pkTaskGridColumnSetting is null
	begin
	exec dbo.uspTaskGridColumnSettingInsert
		@fkApplicationUser = @fkApplicationUser
		, @SettingsData = @SettingsData
		, @LUPUser = @LUPUser
		, @LUPMac = @LUPMac
		, @LUPIP = @LUPIP
		, @LUPMachine = @LUPMachine
	end
else
	begin
	exec dbo.uspTaskGridColumnSettingUpdate
		@pkTaskGridColumnSetting = @pkTaskGridColumnSetting
		, @fkApplicationUser = @fkApplicationUser
		, @SettingsData = @SettingsData
		, @LUPUser = @LUPUser
		, @LUPMac = @LUPMac
		, @LUPIP = @LUPIP
		, @LUPMachine = @LUPMachine
	end