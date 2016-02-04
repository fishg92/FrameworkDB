CREATE proc [dbo].[GetClientListForCase]
	@pkCPClientCase as decimal
as

select	fkCPClient
from	dbo.CPJoinClientClientCase
where	fkCPClientCase = @pkCPClientCase