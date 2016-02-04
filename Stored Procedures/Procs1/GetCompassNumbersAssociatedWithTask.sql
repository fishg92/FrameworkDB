CREATE proc [dbo].[GetCompassNumbersAssociatedWithTask]
	@pkTask decimal
	,@IncludeIndirectAssociations bit = 1
as

select CompassNumber = CPClient.NorthwoodsNumber
from CPClient
join JoinTaskCPClient
	on JoinTaskCPClient.fkCPClient = CPClient.pkCPClient
where JoinTaskCPClient.fkTask = @pkTask

union

select	CPClient.NorthwoodsNumber
from CPClient
join CPJoinClientClientCase
	on CPClient.pkCPClient = CPJoinClientClientCase.fkCPClient
join JoinTaskCPClientCase
	on JoinTaskCPClientCase.fkCPClientCase = CPJoinClientClientCase.fkCPClientCase
where JoinTaskCPClientCase.fkTask = @pkTask

union

select CompassNumber = CPClient.NorthwoodsNumber
from CPClient
join CPJoinClientClientCase j1
	on CPClient.pkCPClient = j1.fkCPClient
join CPJoinClientClientCase j2
	on j1.fkCPClientCase = j2.fkCPClientCase
join JoinTaskCPClient
	on j2.fkCPClient = JoinTaskCPClient.fkCPClient
where JoinTaskCPClient.fkTask = @pkTask
and @IncludeIndirectAssociations = 1
