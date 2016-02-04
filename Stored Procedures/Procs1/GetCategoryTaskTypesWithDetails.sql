
CREATE proc [dbo].[GetCategoryTaskTypesWithDetails]
	@fkrefTaskCategory decimal
	,@fkApplicationUserAssignedTo decimal
as

select	pkrefTaskType
		,Description
		,DefaultDueMinutes
		,DefaultGroupTask
		,DefaultPriority
		,Active
		,fkrefTaskCategory
		,DMSTaskTypeID
		,CountRead = (	select	count(*)
						from	TaskAssignment ta
						join refTaskAssignmentStatus rs
							on ta.fkrefTaskAssignmentStatus = rs.pkrefTaskAssignmentStatus
						join Task t
							on t.pkTask = ta.fkTask
						where	ta.fkApplicationUserAssignedTo = @fkApplicationUserAssignedTo
						and		t.fkrefTaskType = pkrefTaskType
						and		ta.UserRead = 1
						and		rs.AssignmentComplete = 0)
		,CountUnread = (select	count(*)
						from	TaskAssignment ta
						join refTaskAssignmentStatus rs
							on ta.fkrefTaskAssignmentStatus = rs.pkrefTaskAssignmentStatus
						join Task t
							on t.pkTask = ta.fkTask
						where	ta.fkApplicationUserAssignedTo = @fkApplicationUserAssignedTo
						and		t.fkrefTaskType = pkrefTaskType
						and		ta.UserRead = 0
						and		rs.AssignmentComplete = 0)
		,DMSNewTaskWorkflow
		,AllowDelete
		,AllowDescriptionEdit
		,AutoComplete
		,DMSWorkflowName
		,DMSRequestedAction						
from	refTaskType
where	fkrefTaskCategory = @fkrefTaskCategory
order by pkrefTaskType