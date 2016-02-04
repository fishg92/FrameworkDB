CREATE PROC [dbo].[UserTaskTypeDeselectedSelectForUser]
	@fkApplicationUser decimal(18, 0)

AS

select	UserTaskTypeDeselected.fkrefTaskType
from	UserTaskTypeDeselected
join refTaskType
	on UserTaskTypeDeselected.fkrefTaskType = refTaskType.pkrefTaskType
where UserTaskTypeDeselected.fkApplicationUser = @fkApplicationUser
