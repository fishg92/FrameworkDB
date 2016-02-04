CREATE proc [dbo].[TaskOriginAllowDelete]
	@pkrefTaskOrigin decimal
	,@AllowDelete bit = null output
	
as

set @AllowDelete = 1

if exists (	select	*
			from	Task
			where	fkrefTaskOrigin = @pkrefTaskOrigin)
	set @AllowDelete = 0

if @AllowDelete = 1
	begin
	if exists (	select	*
				from	TaskAudit
				where	fkrefTaskOrigin = @pkrefTaskOrigin)
		set @AllowDelete = 0
	end
	
if @AllowDelete = 1
	begin
	if exists (	select	*
				from	[Profile]
				where	fkrefTaskOrigin = @pkrefTaskOrigin)
		set @AllowDelete = 0
	end
