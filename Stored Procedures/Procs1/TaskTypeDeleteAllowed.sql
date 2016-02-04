CREATE proc [dbo].[TaskTypeDeleteAllowed]
	@pkrefTaskType decimal
as

--Don't allow delete of task types connected to existing tasks
if exists (select * from Task where fkrefTaskType = @pkrefTaskType)
	select 0
--Tasks in audit tables also require valid task types
else if exists (select * from TaskAudit where fkrefTaskType = @pkrefTaskType)
	select 0
else
	select 1