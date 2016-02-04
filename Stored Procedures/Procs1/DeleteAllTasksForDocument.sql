----------------------------------------------------------------------------
-- Update all task joins related to a document
/*

*/
----------------------------------------------------------------------------
CREATE PROC [dbo].[DeleteAllTasksForDocument]
	@fkDocument varchar(50)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)

AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine


declare @TasksToDelete table (pkTask decimal)

insert @TasksToDelete (pkTask)
select	fkTask
from	JoinTaskDocument j1
where	fkDocument = @fkDocument
and not exists 
	(
		select	*
		from	JoinTaskDocument j2
		where	j2.fkTask = j1.fkTask
		and		j2.fkDocument <> j1.fkDocument
	)

delete	JoinTaskDocument
where	fkDocument = @fkDocument

delete	JoinTaskCPClient
from JoinTaskCPClient
join @TasksToDelete ttd
	on JoinTaskCPClient.fkTask = ttd.pkTask
	
delete	JoinTaskCPClientCase
from JoinTaskCPClientCase 
join @TasksToDelete ttd
	on JoinTaskCPClientCase.fkTask = ttd.pkTask
	
delete	TaskAssignment
from TaskAssignment
join @TasksToDelete ttd
	on TaskAssignment.fkTask = ttd.pkTask
	
delete	Task
from Task
join @TasksToDelete ttd
	on Task.pkTask = ttd.pkTask
