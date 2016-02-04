


CREATE view [dbo].[TaskReporting]
as

select	pkTask = Task.pkTask
		,TaskDescription = Task.Description
		,fkrefTaskType = Task.fkrefTaskType
		,TaskTypeDescription = refTaskType.Description
		,DueDate = Task.DueDate
		,TaskNote = Task.Note
		,TaskPriorityCode = Task.Priority
		,TaskPriorityDescription = refTaskPriority.Description
		,TaskStartDate = Task.StartDate
		,GroupTask = Task.GroupTask
		,pkTaskAssignment = TaskAssignment.pkTaskAssignment
		,AssignmentDescription = TaskAssignment.Description
		,fkApplicationUserAssignedBy = TaskAssignment.fkApplicationUserAssignedBy
		,fkApplicationUserAssignedTo = TaskAssignment.fkApplicationUserAssignedTo
			/*
			case
				when TaskAssignment.fkrefTaskAssignmentStatus <> 3
					then TaskAssignment.fkApplicationUserAssignedTo
				else
					--isnull((select AuditUser
					--from TaskAssignmentAudit
					--where pk = (select max(pk)
					--			from TaskAssignmentAudit
					--			where pkTaskAssignment = TaskAssignment.pkTaskAssignment
					--			and fkrefTaskAssignmentStatus = 3
					--			and isnumeric(AuditUser) = 1)
					--),TaskAssignment.fkApplicationUserAssignedTo)
					isnull(
						(
							select top 1 AuditUser
							from TaskAssignmentAudit
							where pk = dbo.TaskCompletionAuditRecord(TaskAssignment.pkTaskAssignment)
						),TaskAssignment.fkApplicationUserAssignedTo)

			end
			*/
		,fkrefTaskAssignmentStatus = TaskAssignment.fkrefTaskAssignmentStatus
		,AssignmentStatusDescription = refTaskAssignmentStatus.Description
		,fkrefTaskAssignmentReason = TaskAssignment.fkrefTaskAssignmentReason
		,AssignmentReasonDescription = refTaskAssignmentReason.Description
		,AssignmentOpenDate = TaskAssignment.CreateDate
/*			(
				select	min(AuditStartDate)
				from	TaskAssignmentAudit
				where	pkTaskAssignment = TaskAssignment.pkTaskAssignment
				and		fkrefTaskAssignmentStatus = 1
			)
*/
		,AssignmentCompleteDate = 
			case
				when TaskAssignment.fkrefTaskAssignmentStatus = 3
					then TaskAssignment.CompleteDate
					else
						null
				end
		,CompletionDays = 
			case
				when TaskAssignment.fkrefTaskAssignmentStatus = 3
					then datediff(day,TaskAssignment.CreateDate,TaskAssignment.CompleteDate)
/*							day
							,(
								select	min(AuditStartDate)
								from	TaskAssignmentAudit
								where	pkTaskAssignment = TaskAssignment.pkTaskAssignment
								and		fkrefTaskAssignmentStatus = 1
							)
							,TaskAssignment.CompleteDate
							--,(
							--	select	max(AuditStartDate)
							--	from	TaskAssignmentAudit
							--	where	pkTaskAssignment = TaskAssignment.pkTaskAssignment
							--	and		fkrefTaskAssignmentStatus = 3
							--)
							)
*/
						else
							null
					end

		,fkrefTaskOrigin = Task.fkrefTaskOrigin
		,TaskOriginDescription = isnull(refTaskOrigin.TaskOriginName,'')
		,FixedType = refTaskType.FixedType
		,ServerName = @@SERVERNAME
from Task
join TaskAssignment
	on Task.pkTask = TaskAssignment.fkTask
join refTaskType
	on refTaskType.pkrefTaskType = Task.fkrefTaskType
join refTaskPriority
	on Task.Priority = refTaskPriority.pkrefTaskPriority
join refTaskAssignmentStatus
	on refTaskAssignmentStatus.pkrefTaskAssignmentStatus = TaskAssignment.fkrefTaskAssignmentStatus
left join refTaskAssignmentReason
	on TaskAssignment.fkrefTaskAssignmentReason = refTaskAssignmentReason.pkrefTaskAssignmentReason
left join refTaskOrigin
	on Task.fkrefTaskOrigin = refTaskOrigin.pkrefTaskOrigin









