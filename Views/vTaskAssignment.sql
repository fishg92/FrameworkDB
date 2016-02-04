


CREATE view [dbo].[vTaskAssignment]
as

select	Task.pkTask
		,Task.fkrefTaskType
		,TaskType = refTaskType.Description
		,Task.DueDate
		,TaskNote = Task.Note
		,TaskDescription = Task.Description
		,Task.Priority
		,TaskStartDate = Task.StartDate
		,TaskCompleteDate = Task.CompleteDate
		,Task.GroupTask
		,refTaskStatus.pkrefTaskStatus
		,TaskStatus = refTaskStatus.Description
		,refTaskStatus.TaskComplete
		,TaskAssignment.pkTaskAssignment
		,TaskAssignment.fkApplicationUserAssignedBy
		,AssignmentDescription = TaskAssignment.Description
		,AssignmentStartDate = TaskAssignment.StartDate
		,AssignmentCompleteDate = TaskAssignment.CompleteDate
		,UserNameAssignedBy = aBy.UserName
		,TaskAssignment.fkApplicationUserAssignedTo
		,UserNameAssignedTo = aTo.UserName
		,refTaskAssignmentStatus.pkrefTaskAssignmentStatus
		,AssignmentStatus = refTaskAssignmentStatus.Description
		,AssignmentComplete = refTaskAssignmentStatus.AssignmentComplete
		,Task.fkrefTaskOrigin
		,TaskOriginDescription = isnull(refTaskOrigin.TaskOriginName,'')
		,ClientEntityCount = 
			(
				select	count(*)
				from	JoinTaskCPClient
				where	fkTask = Task.pkTask
			)
		,CaseEntityCount = 
			(
				select	count(*)
				from	JoinTaskCPClientCase
				where	fkTask = Task.pkTask
			)
		,DocumentEntityCount = 
			(
				select	count(*)
				from	JoinTaskDocument
				where	fkTask = Task.pkTask
			)
from	Task
join refTaskStatus
	on Task.fkrefTaskStatus = refTaskStatus.pkrefTaskStatus
join TaskAssignment
	on Task.pkTask = TaskAssignment.fkTask
join refTaskAssignmentStatus
	on refTaskAssignmentStatus.pkrefTaskAssignmentStatus = TaskAssignment.fkrefTaskAssignmentStatus
join refTaskType
	on Task.fkrefTaskType = refTaskType.pkrefTaskType
join ApplicationUser aBy
	on aBy.pkApplicationUser = TaskAssignment.fkApplicationUserAssignedBy
join ApplicationUser aTo
	on aTo.pkApplicationUser = TaskAssignment.fkApplicationUserAssignedTo
left join refTaskOrigin
	on Task.fkrefTaskOrigin = refTaskOrigin.pkrefTaskOrigin

