CREATE proc [dbo].[GetExternalTaskDetails]
	@fkExternalTask varchar(50)
	,@fkApplicationUser decimal
as

/*************************************
exec dbo.GetTaskDetails 1
********************************/
declare @TaskDescription varchar(100)
		,@pkExternalTaskMetadata decimal
		
select	@pkExternalTaskMetadata = pkExternalTaskMetadata
from	ExternalTaskMetadata
where	fkExternalTask = @fkExternalTask

/* Task, Table 0 */
select	pkExternalTaskMetadata
		, fkExternalTask
		, fkrefTaskPriority
		, fkrefTaskStatus
		, UserRead = 
			isnull((
				select	UserRead
				from	JoinExternalTaskMetaDataApplicationUser
				where	fkExternalTaskMetaData = ExternalTaskMetaData.pkExternalTaskMetaData
				and		fkApplicationUser = @fkApplicationUser
			),0)
		, fkrefTaskOrigin
from	ExternalTaskMetadata
where	pkExternalTaskMetadata = @pkExternalTaskMetadata


/* Client Joins, Table 1 */
select	j.pkJoinExternalTaskMetaDataCPClient
		, j.fkCPClient
		, fkExternalTaskMetaData = @pkExternalTaskMetaData
		, LastName = isnull(c.LastName,'')
		, FirstName = isnull(c.FirstName,'')
		, MiddleName = isnull(c.MiddleName,'')
		, Suffix = isnull(c.Suffix,'')
		, SSN = isnull(c.SSN,'')
		, CompassNumber = isnull(c.NorthwoodsNumber,'')
		, StateIssuedNumber = isnull(c.StateIssuedNumber,'')
		, BirthDate = c.BirthDate
		, Gender = isnull(c.Sex,'')
from	JoinExternalTaskMetaDataCPClient j
left join CPClient c
	on j.fkCPClient = c.pkCPClient
where	j.fkExternalTaskMetaData = @pkExternalTaskMetaData

/* Case Joins, Table 2 */
select	j.pkJoinExternalTaskMetaDataCPClientCase
		, j.fkCPClientCase
		, fkExternalTaskMetaData = @pkExternalTaskMetaData
		, StateCaseNumber = isnull(c.StateCaseNumber,'')
		, LocalCaseNumber = isnull(c.LocalCaseNumber,'')
		, fkCPRefClientCaseProgramType = isnull(c.fkCPRefClientCaseProgramType, -1)
		, ProgramType = isnull(pt.Description,'')
		, fkCPCaseWorker = isnull(c.fkApplicationUser,-1)
		, CaseWorkerLastName = isnull(cw.LastName,'')
		, CaseWorkerFirstName = isnull(cw.FirstName,'')
		, CaseWorkerMiddleName = isnull(cw.MiddleName,'')
		, CaseWorkerStateID = isnull(cw.StateID,'')
		, CaseWorkerLocalID = ''-- isnull(cw.LocalID,'')
		, CaseWorkerCountyCode = isnull(cw.CountyCode,'')
		, CaseWorkerEmail = isnull(cw.eMail,'')
from	JoinExternalTaskMetaDataCPClientCase j
left join CPClientCase c
	on j.fkCPClientCase = c.pkCPClientCase
left join CPRefClientCaseProgramType pt
	on c.fkCPRefClientCaseProgramType = pt.pkCPRefClientCaseProgramType
left join ApplicationUser cw-- CPCaseWorker cw
	on c.fkApplicationUser = cw.pkApplicationUser
where	fkExternalTaskMetaData = @pkExternalTaskMetaData


