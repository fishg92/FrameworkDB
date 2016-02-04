CREATE proc [dbo].[ObliterateTask]
@pkTask decimal
,@RemoveHistory bit = 0
as

delete	JoinTaskDocument
where	fkTask = @pkTask

if @RemoveHistory = 1
	begin
	delete	JoinTaskDocumentAudit
	where	fkTask = @pkTask
	end
	
delete	JoinTaskCPClient
where	fkTask = @pkTask

if @RemoveHistory = 1
	begin
	delete	JoinTaskCPClientAudit
	where	fkTask = @pkTask

	end

delete	JoinTaskCPClientCase
where	fkTask = @pkTask

if @RemoveHistory = 1
	begin
	delete	JoinTaskCPClientCaseAudit
	where	fkTask = @pkTask

	end
	
delete	TaskAssignment
where	fkTask = @pkTask

if @RemoveHistory = 1
	begin
	delete	TaskAssignmentAudit
	where	fkTask = @pkTask

	end

delete	Task
where	pkTask = @pkTask

if @RemoveHistory = 1
	begin
	delete	TaskAudit
	where	pkTask = @pkTask

	end

