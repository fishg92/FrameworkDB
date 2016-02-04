CREATE proc [dbo].[GetTaskHistory]
	@pkTask decimal(18,0)

/*********************************
exec dbo.GetTaskHistory @pkTask = 9424
**************************/
as

select	AuditStartDate
		,AuditUser
		,fkrefTaskType
		,Description
		,DueDate
		,Priority
		,SourceModuleID
		,fkrefTaskOrigin
		,fkrefTaskStatus
		,AuditDeleted
from	TaskAudit
where	pkTask = @pkTask
and isnumeric(AuditUser) = 1
order by AuditStartDate

select	pkTaskAssignment
		,AuditStartDate
		,AuditUser
		,fkApplicationUserAssignedTo
		,fkApplicationUserAssignedBy
		,fkrefTaskAssignmentStatus
		,fkrefTaskAssignmentReason = isnull(fkrefTaskAssignmentReason,-1)
		,Description = isnull(Description,'')
		,AuditDeleted
		,fkApplicationUserReassignedTo = 
			case
				when isnull(fkTaskAssignmentReassignedTo,0) <> 0 then
					isnull(
						(select fkApplicationUserAssignedTo
						from	TaskAssignment
						where	pkTaskAssignment = TaskAssignmentAudit.fkTaskAssignmentReassignedTo)
							,0)
				else 0
			end
from	TaskAssignmentAudit
where fkTask = @pkTask
and isnumeric(AuditUser) = 1
order by pkTaskAssignment
		,AuditStartDate
		
		
