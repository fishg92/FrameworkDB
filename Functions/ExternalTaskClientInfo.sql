create function [dbo].[ExternalTaskClientInfo]
	(
		@fkExternalTask varchar(50)
	)
returns varchar(255)
as
	begin

	declare @ClientInfo varchar(255)
			,@pkCPClient decimal

	select	@pkCPClient = j.fkCPClient
	from	JoinExternalTaskMetaDataCPClient j
	join	ExternalTaskMetadata e
		on e.pkExternalTaskMetaData = j.fkExternalTaskMetaData
	where	e.fkExternalTask = @fkExternalTask

	set @ClientInfo = dbo.TaskClientInfoFrompkClient(@pkCPClient)
	return @ClientInfo
	end
