CREATE proc [dbo].[GetTaskViewDetails]
	@pkTaskView decimal
as

/* TaskView, Table 0 */
select	TaskView.pkTaskView
		,TaskView.fkApplicationUser
		,[Owner] = isnull(ApplicationUser.UserName,'')
		,TaskView.ViewName
		,TaskView.IsGlobal
		,TaskView.ShowUnread
		,TaskView.IgnoreFilters
		,TaskView.IncludeCompleted
		,TaskView.FromNumDaysSpan
		,TaskView.ColumnSettings
from	TaskView
left join ApplicationUser
	on TaskView.fkApplicationUser = ApplicationUser.pkApplicationUser
where	pkTaskView = @pkTaskView

/* TaskFilter, Table 1 */
select	pkTaskFilter
		,fkTaskView
		,TaskTab
		,ParentNode
		,Node
from	TaskFilter
where	fkTaskView = @pkTaskView

/* TaskViewTaskTypeDeselected, Table 2 */
select	pkTaskViewTaskTypeDeselected
		,fkTaskView
		,fkrefTaskType
from	TaskViewTaskTypeDeselected
where	fkTaskView = @pkTaskView