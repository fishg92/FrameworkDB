create function [dbo].[TaskClientInfoFrompkClient]
	(
		@pkCPClient decimal
	)
returns varchar(255)
as
	begin

	declare @ClientInfo varchar(255)

	set @ClientInfo = ''

	if @pkCPClient is not null
		begin
		select @ClientInfo = 
			dbo.FormatSSN(SSN)
			+ ' - ' 
			+ isnull(LastName,'')
			+ ', '
			+ isnull(FirstName,'')
		from CPClient
		where pkCPClient = @pkCPClient
		end

	return @ClientInfo
	end
