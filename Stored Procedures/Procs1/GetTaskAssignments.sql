CREATE proc [dbo].[GetTaskAssignments]
	@pkApplicationUserAssignedTo decimal(18,0)
	,@DueDateStart datetime = null
	,@DueDateEnd datetime = null
		,@Priority tinyint = null
		,@pkrefTaskStatus decimal = null
		,@pkrefTaskAssignmentStatus decimal = null
		,@TaskComplete bit = null
		,@AssignmentComplete bit = null
as

select	pkTask
		, fkrefTaskType
		, TaskType
		, DueDate
		, TaskNote
		, Priority
		, TaskStartDate
		, TaskCompleteDate
		, GroupTask
		, pkrefTaskStatus
		, TaskStatus
		, TaskComplete
		, pkTaskAssignment
		, AssignmentStartDate
		, AssignmentCompleteDate
		, fkApplicationUserAssignedBy
		, UserNameAssignedBy
		, fkApplicationUserAssignedTo
		, UserNameAssignedTo
		, pkrefTaskAssignmentStatus
		, AssignmentStatus
		, AssignmentComplete
		, ClientEntityCount
		, CaseEntityCount
		, DocumentEntityCount
from	dbo.vTaskAssignment
where fkApplicationUserAssignedTo = @pkApplicationUserAssignedTo
and	
	(
		DueDate >= @DueDateStart
		or
		@DueDateStart is null
	)
and
	(
		DueDate <= @DueDateEnd
		or
		@DueDateEnd is null
	)
and
	(
		Priority = @Priority
		or
		@Priority is null
	)
and
	(
		pkrefTaskStatus = @pkrefTaskStatus
		or
		@pkrefTaskStatus is null
	)
and
	(
		pkrefTaskAssignmentStatus = @pkrefTaskAssignmentStatus
		or
		@pkrefTaskAssignmentStatus is null
	)
and
	(
		TaskComplete = @TaskComplete
		or
		@TaskComplete is null
	)
and
	(
		AssignmentComplete = @AssignmentComplete
		or
		@AssignmentComplete is null
	)
