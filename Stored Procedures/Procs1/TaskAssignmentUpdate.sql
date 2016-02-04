CREATE PROC [dbo].[TaskAssignmentUpdate]
(	  @pkTaskAssignment decimal(18, 0)
	, @fkTask decimal(18, 0) = NULL
	, @fkrefTaskAssignmentReason decimal(18,0) = NULL
	, @Description varchar(100) = NULL
	, @fkApplicationUserAssignedBy decimal(18, 0) = NULL
	, @fkApplicationUserAssignedTo decimal(18, 0) = NULL
	, @fkTaskAssignmentReassignedTo decimal(18, 0) = NULL
	, @fkrefTaskAssignmentStatus decimal(18, 0) = NULL
	, @StartDate datetime = NULL
	, @CompleteDate datetime = NULL
	, @UserRead bit = NULL
	, @UserReadNote bit = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	TaskAssignment
SET	fkTask = @fkTask,
	Description = @Description,
	fkApplicationUserAssignedBy = @fkApplicationUserAssignedBy,
	fkApplicationUserAssignedTo = @fkApplicationUserAssignedTo,
	fkTaskAssignmentReassignedTo = @fkTaskAssignmentReassignedTo,
	fkrefTaskAssignmentStatus = @fkrefTaskAssignmentStatus,
	StartDate = @StartDate,
	CompleteDate = @CompleteDate,
	UserRead = @UserRead,
	UserReadNote = @UserReadNote,
	fkrefTaskAssignmentReason = @fkrefTaskAssignmentReason
WHERE 	pkTaskAssignment = @pkTaskAssignment
