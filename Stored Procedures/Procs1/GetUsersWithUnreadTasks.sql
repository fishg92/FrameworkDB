create proc dbo.GetUsersWithUnreadTasks
as

select distinct	fkApplicationUserAssignedTo
from	TaskAssignment ta with (nolock)
where	ta.UserRead = 0
and		ta.fkrefTaskAssignmentStatus not in (3,4)
AND NOT EXISTS (SELECT *
				FROM	Task t with (NOLOCK)
				WHERE	t.pkTask = ta.fkTask
				AND		t.fkrefTaskStatus = 3
				)
