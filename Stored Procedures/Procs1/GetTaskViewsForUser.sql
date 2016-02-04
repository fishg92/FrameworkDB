CREATE proc [dbo].[GetTaskViewsForUser]
	@pkApplicationUser decimal
	,@IncludeReadOnly as bit
as
/****************************************
exec dbo.GetTaskViewsForUser
	@pkApplicationUser = 1
	,@IncludeReadOnly = 1
*******************************************/
select	TaskView.pkTaskView
		,TaskView.ViewName
		,TaskView.IsGlobal
		,Owner = isnull(ApplicationUser.UserName,'')
		,TaskView.fkApplicationUser
from TaskView
left join ApplicationUser
	on TaskView.fkApplicationUser = ApplicationUser.pkApplicationUser
--Views owned by the user
where 
	(
		TaskView.fkApplicationUser = @pkApplicationUser
		or
		(TaskView.IsGlobal = 1 and @IncludeReadOnly = 1)
		or
		(TaskView.IsGlobal = 1 and dbo.UserHasPermission(@pkApplicationUser,62) = 1)
	)
and
	(
		TaskView.fkApplicationUser <> -1
		or
		@IncludeReadOnly = 1
	)


	