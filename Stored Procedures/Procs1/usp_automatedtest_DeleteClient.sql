

--exec usp_automatedtest_DeleteClient 'OH123000000025'
CREATE proc [dbo].[usp_automatedtest_DeleteClient]
	@CompassNumber as varchar (50)
as

set nocount on
Declare @pkCPClient as decimal (18,0)

set @pkCPClient = (select pkCPClient from cpclient
where NorthwoodsNumber = @CompassNumber)

delete from dbo.CPClientCustomAttribute
where fkCPClient = @pkCPClient

delete from dbo.CPClientMarriageRecord
where fkCPClient = @pkCPClient

delete from dbo.CPClientMilitaryRecord
where fkCPClient = @pkCPClient

delete from dbo.CPClientTHT
where pkCPClient = @pkCPClient

delete from dbo.CPJoinClientAlertFlagTypeNT
where fkCPClient = @pkCPClient

delete from dbo.CPJoinClientClientAddress
where fkCPClient = @pkCPClient

delete from dbo.CPJoinClientClientCase
where fkCPClient = @pkCPClient

delete from dbo.CPJoinClientClientPhone
where fkCPClient = @pkCPClient

delete from dbo.CPJoinClientEmployer
where fkCPClient = @pkCPClient

delete from dbo.CPJoinClientNarrativeNT
where fkCPClient = @pkCPClient

delete from dbo.CPJoinCPClientCPClientrefRelationship
where fkCPClientParent = @pkCPClient

delete from dbo.CPJoinCPClientCPClientrefRelationship 
where fkCPClientChild= @pkCPClient

delete from dbo.CPClient
where pkCPClient = @pkCPClient