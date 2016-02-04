CREATE function [dbo].[TaskClientInfo]
	(
		@pkTask decimal
	)
returns varchar(255)
as
	begin

	declare @ClientInfo varchar(255)
			,@pkCPClient decimal

	select	@pkCPClient = fkCPClient
	from	JoinTaskCPClient
	where	fkTask = @pkTask

	set @ClientInfo = dbo.TaskClientInfoFrompkClient(@pkCPClient)
	return @ClientInfo
	end