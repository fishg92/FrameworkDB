


CREATE proc [dbo].[GetCaseNumberFrompkCPClientCase]
	@pkCPClientCase decimal
	,@StateCaseNumber varchar(20) = null output
	,@LocalCaseNumber varchar(20) = null output
	,@CaseWorkerName varchar(101) = null output
	,@ProgramTypeName varchar(50) = null output
	,@pkProgramType decimal = null output
as

select	@StateCaseNumber = cc.StateCaseNumber 
		,@LocalCaseNumber = cc.LocalCaseNumber 
		,@CaseWorkerName = isnull(cw.FirstName,'') + ' ' + isnull(cw.LastName,'') 
		,@ProgramTypeName = isnull(pt.ProgramType,'') 
		,@pkProgramType = isnull(pt.pkProgramType,-1)
--select	cc.StateCaseNumber 
--		+ ',' + cc.LocalCaseNumber 
--		+ ',' + isnull(cw.FirstName,'') 
--		+ ' ' + isnull(cw.LastName,'') 
--		+ ',' + isnull(pt.ProgramType,'') 
--		+ ',' + isnull(convert(varchar,pt.pkProgramType),'') StateInfo 
from	CPClientCase cc (nolock)
left join ApplicationUser cw
	on cc.fkApplicationUser = cw.pkApplicationUser
--left join CPCaseWorker cw (nolock)
--	on cc.fkCPCaseWorker = cw.pkCPCaseWorker
left join ProgramType pt (nolock)
	on cc.fkCPRefClientCaseProgramType = pt.pkProgramType
where	pkCPClientCase = @pkCPClientCase



