CREATE proc [dbo].[TaskGridColumnSettingDelete]
	@fkApplicationUser decimal
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)

as

declare @pkTaskGridColumnSetting decimal

select	@pkTaskGridColumnSetting = pkTaskGridColumnSetting
from	TaskGridColumnSetting
where	fkApplicationUser = @fkApplicationUser

if @pkTaskGridColumnSetting is not null
	begin
	exec dbo.uspTaskGridColumnSettingDelete
		@pkTaskGridColumnSetting = @pkTaskGridColumnSetting
		, @LUPUser = @LUPUser
		, @LUPMac = @LUPMac
		, @LUPIP = @LUPIP
		, @LUPMachine = @LUPMachine
	end
