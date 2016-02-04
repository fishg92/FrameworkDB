

CREATE proc [dbo].[DataMigratorProcessCasesSubBatch]
	@fkCPImportBatch decimal
	,@SubBatchID int
as


update CPClientCase	
	set LocalCaseNumber = (case when s.LocalCaseNumber = '' then CPClientCase.LocalCaseNumber else s.LocalCaseNumber end)
	,fkApplicationUser = isnull(s.fkApplicationUserCaseWorker,fkApplicationUser)
	,fkCPRefClientCaseProgramType = isnull(s.fkProgramType,cpClientCase.fkCPRefClientCaseProgramType)
	,fkCPClientCaseHead = (case when s.CaseHead = 1 then s.fkCPClient else null end)
	,DistrictID = (case when s.CaseWorkerID = '' then DistrictID else s.CaseWorkerID end)
from DataMigratorStaging s
join CPClientCase on
 CPClientCase.pkCPClientCase = s.fkCPClientCase
where s.ExclusionFlag = 0
and s.fkCPImportBatch = @fkCPImportBatch
and s.SubBatchID = @SubBatchID
and (CPClientCase.LocalCaseNumber <> s.LocalCaseNumber  or s.CaseworkerID <> DistrictID
 or isnull(fkApplicationUser,-1) <>  isnull(s.fkApplicationUserCaseWorker,isnull(fkApplicationUser,-1))
		or CPClientCase.fkCPClientCaseHead <> 
			(case when s.CaseHead = 1 then s.fkCPClient else null end))

/* create cases from rows with case head identified */

--Step 1 - Staging rows with only state case number
insert into CPClientCase	
	(StateCaseNumber
	,LocalCaseNumber
	,fkCPRefClientCaseProgramType
	,fkCPClientCaseHead
	,fkApplicationUser
	,DistrictID
	)
	select distinct
	s.StateCaseNumber
	,s.LocalCaseNumber
	,s.fkProgramType
	,case when s.CaseHead = 1 then s.fkCPClient else 0 end
	,s.fkApplicationUserCaseWorker
	,s.CaseWorkerID
	from DataMigratorStaging s
	where s.ExclusionFlag = 0
	and s.CaseHead = 1
	and s.fkCPClientCase is null
	and s.SubBatchID = @SubBatchID
	and s.StateCaseNumber <> ''
	and s.LocalCaseNumber = ''
	and s.fkCPImportBatch = @fkCPImportBatch
		and not exists (select * from CPClientCase cc where 
			s.StateCaseNumber = cc.StateCaseNumber
			--and s.LocalCaseNumber = cc.LocalCaseNumber
			and s.fkProgramType = cc.fkCPRefClientCaseProgramType
			and isnull(s.fkApplicationUserCaseWorker,0) = isnull(cc.fkApplicationUser,0)
			and s.fkProgramType = cc.fkCPRefClientCaseProgramType)
	
--Step 2 - Staging rows with state and local case number
insert into CPClientCase	
	(StateCaseNumber
	,LocalCaseNumber
	,fkCPRefClientCaseProgramType
	,fkCPClientCaseHead
	,fkApplicationUser
	,DistrictID
	)
	select distinct
	s.StateCaseNumber
	,s.LocalCaseNumber
	,s.fkProgramType
	,case when s.CaseHead = 1 then s.fkCPClient else 0 end
	,s.fkApplicationUserCaseWorker
	,s.CaseWorkerID
	from DataMigratorStaging s
	where s.ExclusionFlag = 0
	and s.CaseHead = 1
	and s.fkCPClientCase is null
	and s.SubBatchID = @SubBatchID
	and s.StateCaseNumber <> ''
	and s.LocalCaseNumber <> ''
	and s.fkCPImportBatch = @fkCPImportBatch
		and not exists (select * from CPClientCase cc where 
			s.StateCaseNumber = cc.StateCaseNumber
			and s.LocalCaseNumber = cc.LocalCaseNumber
			and s.fkProgramType = cc.fkCPRefClientCaseProgramType
			and isnull(s.fkApplicationUserCaseWorker,0) = isnull(cc.fkApplicationUser,0)
			and s.fkProgramType = cc.fkCPRefClientCaseProgramType)
	
			
/* create cases not created above, rows with no case head */

--Step 1 - Staging rows with only state case number
insert into CPClientCase	
	(StateCaseNumber
	,LocalCaseNumber
	,fkCPRefClientCaseProgramType
	,fkCPClientCaseHead
	,fkApplicationUser
	,DistrictID
	)
	select distinct
	s.StateCaseNumber
	,s.LocalCaseNumber
	,s.fkProgramType
	,case when s.CaseHead = 1 then s.fkCPClient else 0 end
	,s.fkApplicationUserCaseWorker
	,s.CaseWorkerID
	from DataMigratorStaging s
	where s.ExclusionFlag = 0
	and s.CaseHead = 0
	and s.fkCPClientCase is null
	and s.SubBatchID = @SubBatchID
	and s.fkCPImportBatch = @fkCPImportBatch
	and s.StateCaseNumber <> ''
	and s.LocalCaseNumber = ''
		and not exists (select * from CPClientCase cc where 
			s.StateCaseNumber = cc.StateCaseNumber
			--and s.LocalCaseNumber = cc.LocalCaseNumber
			and isnull(s.fkApplicationUserCaseWorker,0) = isnull(cc.fkApplicationUser,0)
			and s.fkProgramType = cc.fkCPRefClientCaseProgramType)			

--Step 2 - Staging rows with state and local case number
insert into CPClientCase	
	(StateCaseNumber
	,LocalCaseNumber
	,fkCPRefClientCaseProgramType
	,fkCPClientCaseHead
	,fkApplicationUser
	,DistrictID
	)
	select distinct
	s.StateCaseNumber
	,s.LocalCaseNumber
	,s.fkProgramType
	,case when s.CaseHead = 1 then s.fkCPClient else 0 end
	,s.fkApplicationUserCaseWorker
	,s.CaseWorkerID
	from DataMigratorStaging s
	where s.ExclusionFlag = 0
	and s.CaseHead = 0
	and s.fkCPClientCase is null
	and s.SubBatchID = @SubBatchID
	and s.fkCPImportBatch = @fkCPImportBatch
	and s.StateCaseNumber <> ''
	and s.LocalCaseNumber <> ''
		and not exists (select * from CPClientCase cc where 
			s.StateCaseNumber = cc.StateCaseNumber
			and s.LocalCaseNumber = cc.LocalCaseNumber
			and isnull(s.fkApplicationUserCaseWorker,0) = isnull(cc.fkApplicationUser,0)
			and s.fkProgramType = cc.fkCPRefClientCaseProgramType)			

/* now update fkclient in staging for records we just created above */
--CPClientCase
/***********
PCR 18055 - This is now done in 2 steps to bring in LocalCaseNumber
as a unique indicator (only if LocalCaseNumber is in the import)
**************/
update	DataMigratorStaging
set		fkCPClientCase = cc.pkCpClientCase
from	DataMigratorStaging s
join CPClientCase cc
	on s.StateCaseNumber = cc.StateCaseNumber
	and s.LocalCaseNumber = cc.LocalCaseNumber
	and s.fkProgramType = cc.fkCPRefClientCaseProgramType
	and isnull(s.fkApplicationUserCaseWorker,0) = isnull(cc.fkApplicationUser,0)
where s.fkCPImportBatch = @fkCPImportBatch
and s.SubBatchID = @SubBatchID
and ExclusionFlag = 0
and s.LocalCaseNumber <> ''
and s.fkCPClientCase is null

update	DataMigratorStaging
set		fkCPClientCase = cc.pkCpClientCase
from	DataMigratorStaging s
join CPClientCase cc
	on s.StateCaseNumber = cc.StateCaseNumber
	and s.fkProgramType = cc.fkCPRefClientCaseProgramType
	and isnull(s.fkApplicationUserCaseWorker,0) = isnull(cc.fkApplicationUser,0)
where s.fkCPImportBatch = @fkCPImportBatch
and s.SubBatchID = @SubBatchID
and ExclusionFlag = 0
and s.LocalCaseNumber = ''
and s.fkCPClientCase is null

update CPJoinClientClientCase set
	PrimaryParticipantOnCase = s.CaseHead 
from DataMigratorStaging s 
inner join CPJoinClientClientCase c on 
	c.fkCPClient = s.fkCPClient
	and c.fkCPClientCase = s.fkCPClientCase
	and isnull(c.PrimaryParticipantOnCase,0) <>  s.CaseHead
where s.ExclusionFlag = 0
and s.fkCPImportBatch = @fkCPImportBatch
and s.SubBatchID = @SubBatchID
and s.fkCPClient is not null
and s.fkCPClientCase is not null

insert into CPJoinClientClientCase
  (fkCPClient, fkCPClientCase,PrimaryParticipantOnCase)
 select  distinct s.fkCPClient
		,s.fkCPClientCase
		, s.CaseHead
from DataMigratorStaging s 
where s.ExclusionFlag = 0
and s.fkCPImportBatch = @fkCPImportBatch
and s.SubBatchID = @SubBatchID
and s.fkCPClient is not null
and s.fkCPClientCase is not null
and not exists (select * from CPJoinClientClientCase j where 
					j.fkCPClient = s.fkCPClient
					and j.fkCPClientCase = s.fkCPClientCase)
