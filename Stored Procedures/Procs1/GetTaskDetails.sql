
CREATE proc [dbo].[GetTaskDetails]
	@pkTask decimal
AS

/*************************************
exec dbo.GetTaskDetails 4
********************************/
declare @TaskDescription varchar(100)

/* Task, Table 0 */
select	pkTask
		, fkrefTaskType
		, Description
		, DueDate
		, Note
		, fkrefTaskStatus
		, Priority
		, StartDate
		, CompleteDate
		, GroupTask
		, SourceModuleID
		, fkrefTaskOrigin
		, CreateDate -- = (select min(AuditStartDate) from TaskAudit where pkTask = @pkTask)
		, LUPdate = IsNUll(LUPDate, CreateDate)
from	Task
where	pkTask = @pkTask

select	@TaskDescription = Description
from	Task
where	pkTask = @pkTask

/* TaskAssignment, Table 1 */
select	ta.pkTaskAssignment
		, ta.fkTask
		, Description = 
			case
				when ta.Description = '' 
					then @TaskDescription
				else
					ta.Description
			end
		, ta.fkApplicationUserAssignedBy
		, ta.fkApplicationUserAssignedTo
		, ta.fkTaskAssignmentReassignedTo
		, ta.fkrefTaskAssignmentStatus
		, ta.StartDate
		, ta.CompleteDate
		, AssignedByUserName = isnull(auaBy.UserName,'')
		, AssignedByFirstName = isnull(auaBy.FirstName,'')
		, AssignedByLastName = isnull(auaBy.LastName,'')
		, AssignedToUserName = isnull(auaTo.UserName,'')
		, AssignedToFirstName = isnull(auaTo.FirstName,'')
		, AssignedToLastName = isnull(auaTo.LastName,'')
		, ta.UserRead
		, ta.UserReadNote
		, fkrefTaskAssignmentStatusReason = isnull(ta.fkrefTaskAssignmentReason,0)
		, LUPDate = isnull(ta.LUPDate, ta.CreateDate)
from	TaskAssignment ta
left join ApplicationUser auaBy
	on ta.fkApplicationUserAssignedBy = auaBy.pkApplicationUser
left join ApplicationUser auaTo
	on ta.fkApplicationUserAssignedTo = auaTo.pkApplicationUser
where	fkTask = @pkTask


/* Client Joins, Table 2 */
select	j.pkJoinTaskCPClient
		, j.fkCPClient
		, fkTask = @pkTask
		, LastName = isnull(c.LastName,'')
		, FirstName = isnull(c.FirstName,'')
		, MiddleName = isnull(c.MiddleName,'')
		, Suffix = isnull(c.Suffix,'')
		, SSN = isnull(c.SSN,'')
		, CompassNumber = isnull(c.NorthwoodsNumber,'')
		, StateIssuedNumber = isnull(c.StateIssuedNumber,'')
		, BirthDate = c.BirthDate
		, Gender = isnull(c.Sex,'')
from	JoinTaskCPClient j
left join CPClient c
	on j.fkCPClient = c.pkCPClient
where	j.fkTask = @pkTask

/* Case Joins, Table 3 */
select	j.pkJoinTaskCPClientCase
		, j.fkCPClientCase
		, fkTask = @pkTask
		, StateCaseNumber = isnull(c.StateCaseNumber,'')
		, LocalCaseNumber = isnull(c.LocalCaseNumber,'')
		, fkCPRefClientCaseProgramType = isnull(c.fkCPRefClientCaseProgramType, -1)
		, ProgramType = isnull(pt.Description,'')
		, fkCPCaseWorker = isnull(c.fkCPCaseWorker,-1)
		, CaseWorkerLastName = isnull(cw.LastName,'')
		, CaseWorkerFirstName = isnull(cw.FirstName,'')
		, CaseWorkerMiddleName = isnull(cw.MiddleName,'')
		, CaseWorkerStateID = isnull(cw.StateID,'')
		, CaseWorkerLocalID = ''-- isnull(cw.LocalID,'')
		, CaseWorkerCountyCode = isnull(cw.CountyCode,'')
		, CaseWorkerEmail = isnull(cw.eMail,'')
from	JoinTaskCPClientCase j
left join CPClientCase c
	on j.fkCPClientCase = c.pkCPClientCase
left join CPRefClientCaseProgramType pt
	on c.fkCPRefClientCaseProgramType = pt.pkCPRefClientCaseProgramType
left join ApplicationUser cw
	on c.fkCPCaseWorker = cw.pkApplicationUser
where	fkTask = @pkTask

/* Document Joins, Table 4 */
select	pkJoinTaskDocument
		, fkDocument
		, fkTask = @pkTask
from	JoinTaskDocument
where	fkTask = @pkTask

