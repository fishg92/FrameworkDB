




CREATE proc [dbo].[GetTaskCategoriesAndTypesNoCounts]
	
AS

SELECT    pkrefTaskCategory
		, fkrefTaskCategoryParent
		, CategoryName
		, ExternalTaskingEngineRoot
		
FROM refTaskCategory
ORDER BY fkrefTaskCategoryParent,pkrefTaskCategory

SELECT pkrefTaskType
		,Description
		,DefaultDueMinutes
		,DefaultGroupTask
		,DefaultPriority
		,Active
		,fkrefTaskCategory
		,DMSTaskTypeID
		,DMSNewTaskWorkflow
		,AllowDelete
		,AllowDescriptionEdit
		,AutoComplete
		,DMSWorkflowName
		,DMSRequestedAction		

from dbo.refTaskType
order by Description ASC





