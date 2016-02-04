/*
exec [GetCoPilotCasesForSync] 1,1
select * from cpclientcase
*/
CREATE proc [dbo].[GetCoPilotCasesForSync]
	@pkApplicationUser decimal
	,@pkConnectType decimal
as
select cc.pkcpclientcase 
,StateCaseNumber
,LocalCaseNumber
,fkProgramType = fkCPRefClientCaseProgramType
,fkApplicationUser
,createDate
from joineventtypeConnecttype jevtr 
inner join EventType et on jevtr.fkEventType = et.pkEventType
inner join CPClientCase cc on 
	cc.fkCPRefClientCaseProgramType = et.fkProgramType 
 and @pkApplicationUser = cc.fkApplicationUser
where jevtr.fkConnectType = @pkConnectType
and et.IncludeCaseworkerCases = 1

union
	
select cc.pkcpclientcase 
,StateCaseNumber
,LocalCaseNumber
,fkProgramType = fkCPRefClientCaseProgramType
,fkApplicationUser
,createDate
from joineventtypeConnecttype jevtr 
inner join EventType et on jevtr.fkEventType = et.pkEventType
inner join CPClientCase cc on 
	cc.fkCPRefClientCaseProgramType = et.fkProgramType 
where jevtr.fkConnectType = @pkConnectType
and 
(et.IncludeFavoriteCases = 1 
		and
cc.pkCpClientCase in 
(select fkCpClientCase from 
		ApplicationUserFavoriteCase F where 
		f.fkApplicationUser = @pkApplicationUser)
)

