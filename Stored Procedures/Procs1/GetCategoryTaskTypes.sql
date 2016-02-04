
/*

UPDATE Configuration SET ItemValue = 'True' WHERE ItemKey = 'DisplayTaskTypeCount'
EXEC GetCategoryTaskTypes 1,1

UPDATE Configuration SET ItemValue = 'False' WHERE ItemKey = 'DisplayTaskTypeCount'
EXEC GetCategoryTaskTypes 1,1
*/


CREATE proc [dbo].[GetCategoryTaskTypes]
	@fkrefTaskCategory decimal
	,@fkApplicationUserAssignedTo decimal
as

IF [dbo].GetConfigSettingValue('DisplayTaskTypeCount') = 'True'
	BEGIN
		EXEC GetCategoryTaskTypesWithDetails @fkrefTaskCategory, @fkApplicationUserAssignedTo
	END
ELSE
	BEGIN
		EXEC GetCategoryTaskTypesNoDetails @fkrefTaskCategory, @fkApplicationUserAssignedTo
	END

/*
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
*/