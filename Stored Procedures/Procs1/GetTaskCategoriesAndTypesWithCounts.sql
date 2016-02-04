CREATE proc [dbo].[GetTaskCategoriesAndTypesWithCounts]
	@fkApplicationUserAssignedTo decimal
AS

SELECT    pkrefTaskCategory
		, fkrefTaskCategoryParent
		, CategoryName
		, ExternalTaskingEngineRoot
		
FROM refTaskCategory
ORDER BY fkrefTaskCategoryParent,pkrefTaskCategory

--COUNTS------------------------------------------------
DECLARE @counts TABLE (
    pkRefTaskType decimal(18,0)
	, userRead int
	, readCount int
    );

insert into @counts
(pkRefTaskType, userRead, readCount)
(
	select 
	pkRefTaskType = t.fkRefTaskType
	, userRead = ta.userRead
	, readCount = count(ta.UserRead)
	from	TaskAssignment ta
	join refTaskAssignmentStatus rs
		on ta.fkrefTaskAssignmentStatus = rs.pkrefTaskAssignmentStatus
	join Task t
		on t.pkTask = ta.fkTask
	where	ta.fkApplicationUserAssignedTo = @fkApplicationUserAssignedTo
	and		rs.AssignmentComplete = 0
	group by t.fkRefTaskType, ta.userRead
)
--------------------------------------------------------

SELECT distinct tt.pkrefTaskType
		,Description
		,DefaultDueMinutes
		,DefaultGroupTask
		,DefaultPriority
		,Active
		,fkrefTaskCategory
		,DMSTaskTypeID
		,CountRead = isnull((
			select readCount from @counts c where c.pkRefTaskType = tt.pkrefTaskType and c.userRead = 1
		),0)
		,CountUnread = isnull((
			select readCount from @counts c where c.pkRefTaskType = tt.pkrefTaskType and c.userRead = 0
		), 0)
		,DMSNewTaskWorkflow
		,AllowDelete
		,AllowDescriptionEdit
		,AutoComplete
		,DMSWorkflowName
		,DMSRequestedAction		
from dbo.refTaskType tt
left join @counts c 
	on c.pkRefTaskType = tt.pkRefTaskType
order by Description ASC
