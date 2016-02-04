/***********************************
select * from jointaskdocument

exec getdocumentassignmentlist
	@fkdocument = 5392
	,@history=1
	
select * from jointaskdocumentaudit
where not exists (select * from jointaskdocument where jointaskdocumentaudit.fkdocument = jointaskdocument.fkdocument)
	
select * from taskassignmentaudit
where fktask=93
	
********************************/
CREATE proc [dbo].[GetDocumentAssignmentList]
	@fkDocument varchar(50)
	,@History bit

as

if @History = 0
	begin		

	select	JoinTaskDocument.fkDocument
			,AssignmentType = refTaskType.Description
			,UserAssigned = userTo.UserName
			,FollowupDate = 
				case
					when Task.fkrefTaskType = 2
						then Task.DueDate
					else null
				end
			,AssignmentDate = isnull(
								(select min(AuditStartDate)
								from TaskAssignmentAudit
								where pkTaskAssignment = TaskAssignment.pkTaskAssignment)
								,convert(datetime,'1/1/1900'))
			,AssignedBy = userBy.UserName
			,Note = Task.Note
	from	JoinTaskDocument
	join Task
		on JoinTaskDocument.fkTask = Task.pkTask
	join TaskAssignment
		on Task.pkTask = TaskAssignment.fkTask
	join refTaskType
		on Task.fkrefTaskType = refTaskType.pkrefTaskType
	join ApplicationUser userBy
		on TaskAssignment.fkApplicationUserAssignedBy = userBy.pkApplicationUser
	join ApplicationUser userTo
		on TaskAssignment.fkApplicationUserAssignedTo = userTo.pkApplicationUser
	join refTaskAssignmentStatus
		on TaskAssignment.fkrefTaskAssignmentStatus = refTaskAssignmentStatus.pkrefTaskAssignmentStatus
	where JoinTaskDocument.fkDocument = @fkDocument
	and refTaskAssignmentStatus.AssignmentComplete = @History	
	
	order by AssignmentDate
	end
else
	begin
	/* This part of the union is for completed (not deleted) assignments */
	select	JoinTaskDocument.fkDocument
			,AssignmentType = refTaskType.Description
			,UserAssigned = userTo.UserName
			,FollowupDate = 
				case
					when Task.fkrefTaskType = 2
						then Task.DueDate
					else null
				end
			,AssignmentDate = (select min(AuditStartDate)
								from TaskAssignmentAudit
								where pkTaskAssignment = TaskAssignment.pkTaskAssignment)
			,AssignedBy = userBy.UserName
			,Note = Task.Note
	from	JoinTaskDocument
	join Task
		on JoinTaskDocument.fkTask = Task.pkTask
	join TaskAssignment
		on Task.pkTask = TaskAssignment.fkTask
	join refTaskType
		on Task.fkrefTaskType = refTaskType.pkrefTaskType
	join ApplicationUser userBy
		on TaskAssignment.fkApplicationUserAssignedBy = userBy.pkApplicationUser
	join ApplicationUser userTo
		on TaskAssignment.fkApplicationUserAssignedTo = userTo.pkApplicationUser
	join refTaskAssignmentStatus
		on TaskAssignment.fkrefTaskAssignmentStatus = refTaskAssignmentStatus.pkrefTaskAssignmentStatus
	where JoinTaskDocument.fkDocument = @fkDocument
	and refTaskAssignmentStatus.AssignmentComplete = 1	
	
	union
	
	/* This part of the union is for current tasks with deleted assignments */
	select	JoinTaskDocument.fkDocument
			,AssignmentType = refTaskType.Description
			,UserAssigned = userTo.UserName
			,FollowupDate = 
				case
					when Task.fkrefTaskType = 2
						then Task.DueDate
					else null
				end
			,AssignmentDate = (select min(AuditStartDate)
								from TaskAssignmentAudit a2
								where a2.pkTaskAssignment = TaskAssignmentAudit.pkTaskAssignment)
			,AssignedBy = userBy.UserName
			,Note = Task.Note
	from	JoinTaskDocument
	join Task
		on JoinTaskDocument.fkTask = Task.pkTask
	join TaskAssignmentAudit
		on Task.pkTask = TaskAssignmentAudit.fkTask
	join refTaskType
		on Task.fkrefTaskType = refTaskType.pkrefTaskType
	join ApplicationUser userBy
		on TaskAssignmentAudit.fkApplicationUserAssignedBy = userBy.pkApplicationUser
	join ApplicationUser userTo
		on TaskAssignmentAudit.fkApplicationUserAssignedTo = userTo.pkApplicationUser
	join refTaskAssignmentStatus
		on TaskAssignmentAudit.fkrefTaskAssignmentStatus = refTaskAssignmentStatus.pkrefTaskAssignmentStatus
	where JoinTaskDocument.fkDocument = @fkDocument
	and TaskAssignmentAudit.AuditDeleted=1

	union
	
	/* This part of the union is for tasks that have been completely deleted */
	select	JoinTaskDocumentAudit.fkDocument
			,AssignmentType = refTaskType.Description
			,UserAssigned = userTo.UserName
			,FollowupDate = 
				case
					when TaskAudit.fkrefTaskType = 2
						then TaskAudit.DueDate
					else null
				end
			,AssignmentDate = (select min(AuditStartDate)
								from TaskAssignmentAudit a2
								where a2.pkTaskAssignment = TaskAssignmentAudit.pkTaskAssignment)
			,AssignedBy = userBy.UserName
			,Note = TaskAudit.Note
	from	JoinTaskDocumentAudit
	join TaskAudit
		on JoinTaskDocumentAudit.fkTask = TaskAudit.pkTask
	join TaskAssignmentAudit
		on TaskAudit.pkTask = TaskAssignmentAudit.fkTask
	join refTaskType
		on TaskAudit.fkrefTaskType = refTaskType.pkrefTaskType
	join ApplicationUser userBy
		on TaskAssignmentAudit.fkApplicationUserAssignedBy = userBy.pkApplicationUser
	join ApplicationUser userTo
		on TaskAssignmentAudit.fkApplicationUserAssignedTo = userTo.pkApplicationUser
	join refTaskAssignmentStatus
		on TaskAssignmentAudit.fkrefTaskAssignmentStatus = refTaskAssignmentStatus.pkrefTaskAssignmentStatus
	where JoinTaskDocumentAudit.fkDocument = @fkDocument
	and TaskAudit.AuditDeleted=1
	and TaskAssignmentAudit.AuditDeleted=1
	and JoinTaskDocumentAudit.AuditDeleted=1
	
	order by AssignmentDate
	end
			
