----------------------------------------------------------------------------
-- Update a single record in TaskAssignment
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspTaskAssignmentUpdate]
(	  @pkTaskAssignment decimal(18, 0)
	, @fkTask decimal(18, 0) = NULL
	, @Description varchar(100) = NULL
	, @fkApplicationUserAssignedBy decimal(18, 0) = NULL
	, @fkApplicationUserAssignedTo decimal(18, 0) = NULL
	, @fkTaskAssignmentReassignedTo decimal(18, 0) = NULL
	, @fkrefTaskAssignmentStatus decimal(18, 0) = NULL
	, @StartDate datetime = NULL
	, @CompleteDate datetime = NULL
	, @UserRead bit = NULL
	, @fkrefTaskAssignmentReason decimal(18, 0) = NULL
	, @UserReadNote bit = NULL
	, @RecipientHasBeenNotified bit = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	TaskAssignment
SET	fkTask = ISNULL(@fkTask, fkTask),
	Description = ISNULL(@Description, Description),
	fkApplicationUserAssignedBy = ISNULL(@fkApplicationUserAssignedBy, fkApplicationUserAssignedBy),
	fkApplicationUserAssignedTo = ISNULL(@fkApplicationUserAssignedTo, fkApplicationUserAssignedTo),
	fkTaskAssignmentReassignedTo = ISNULL(@fkTaskAssignmentReassignedTo, fkTaskAssignmentReassignedTo),
	fkrefTaskAssignmentStatus = ISNULL(@fkrefTaskAssignmentStatus, fkrefTaskAssignmentStatus),
	StartDate = ISNULL(@StartDate, StartDate),
	CompleteDate = ISNULL(@CompleteDate, CompleteDate),
	UserRead = ISNULL(@UserRead, UserRead),
	fkrefTaskAssignmentReason = ISNULL(@fkrefTaskAssignmentReason, fkrefTaskAssignmentReason),
	UserReadNote = ISNULL(@UserReadNote, UserReadNote),
	RecipientHasBeenNotified = ISNULL(@RecipientHasBeenNotified, RecipientHasBeenNotified)
WHERE 	pkTaskAssignment = @pkTaskAssignment
