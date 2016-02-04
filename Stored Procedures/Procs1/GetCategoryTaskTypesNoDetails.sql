
/*
EXEC GetCategoryTaskTypesWithDetails
*/

CREATE PROC [dbo].[GetCategoryTaskTypesNoDetails]
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
		,CountRead = -1
		,CountUnread = -1
		,DMSNewTaskWorkflow
		,AllowDelete
		,AllowDescriptionEdit
		,AutoComplete
		,DMSWorkflowName
		,DMSRequestedAction						
from	refTaskType
where	fkrefTaskCategory = @fkrefTaskCategory
order by pkrefTaskType
/*
SELECT	pkrefTaskType = -1
		,Description = ''
		,DefaultDueMinutes = -1
		,DefaultGroupTask = -1
		,DefaultPriority = -1
		,Active = -1
		,fkrefTaskCategory = -1
		,DMSTaskTypeID = ''
		,CountRead = -1
		,CountUnread = -1
		,DMSNewTaskWorkflow = ''
		,AllowDelete = -1
		,AllowDescriptionEdit = -1
		,AutoComplete = -1
		,DMSWorkflowName = ''
		,DMSRequestedAction = ''
*/