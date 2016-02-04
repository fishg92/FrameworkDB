create proc [dbo].[GetNorthwoodsNumberFrompkCPClient]
	@pkCPClient decimal
as

select	NorthwoodsNumber
from	CPClient
where	pkCPClient = @pkCPClient
