CREATE PROC [dbo].[uspUserHasUnreadTasks]
(
	@pkApplicationUser decimal
)
AS
	DECLARE @HasMessages bit

	set @HasMessages = 0
	
	if exists (	select pkTaskAssignment
				FROM	TaskAssignment (NOLOCK)
				WHERE fkApplicationUserAssignedTo = @pkApplicationUser
				AND UserRead = 0 
				AND fkrefTaskAssignmentStatus <> 3 
				AND fkrefTaskAssignmentStatus <> 4
				AND NOT EXISTS (SELECT pkTask
								FROM	Task (NOLOCK)
								WHERE	Task.pkTask = TaskAssignment.fkTask
								AND		Task.fkrefTaskStatus = 3
							   )
				)
	set @HasMessages = 1

	SELECT @HasMessages
