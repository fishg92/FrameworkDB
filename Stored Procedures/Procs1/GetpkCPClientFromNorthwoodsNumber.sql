CREATE proc [dbo].[GetpkCPClientFromNorthwoodsNumber]
	@NorthwoodsNumber varchar(50)
as

select	pkCPClient
from	CPClient
where	NorthwoodsNumber = @NorthwoodsNumber