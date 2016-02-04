----------------------------------------------------------------------------
-- Select a single record from TaskAssignment
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspTaskAssignmentSelect]
(	@pkTaskAssignment decimal(18, 0) = NULL,
	@fkTask decimal(18, 0) = NULL,
	@Description varchar(100) = NULL,
	@fkApplicationUserAssignedBy decimal(18, 0) = NULL,
	@fkApplicationUserAssignedTo decimal(18, 0) = NULL,
	@fkTaskAssignmentReassignedTo decimal(18, 0) = NULL,
	@fkrefTaskAssignmentStatus decimal(18, 0) = NULL,
	@StartDate datetime = NULL,
	@CompleteDate datetime = NULL,
	@LUPUser varchar(50) = NULL,
	@LUPDate datetime = NULL,
	@CreateUser varchar(50) = NULL,
	@CreateDate datetime = NULL,
	@UserRead bit = NULL,
	@fkrefTaskAssignmentReason decimal(18, 0) = NULL,
	@UserReadNote bit = NULL,
	@RecipientHasBeenNotified bit = NULL
)
AS

SELECT	pkTaskAssignment,
	fkTask,
	Description,
	fkApplicationUserAssignedBy,
	fkApplicationUserAssignedTo,
	fkTaskAssignmentReassignedTo,
	fkrefTaskAssignmentStatus,
	StartDate,
	CompleteDate,
	LUPUser,
	LUPDate,
	CreateUser,
	CreateDate,
	UserRead,
	fkrefTaskAssignmentReason,
	UserReadNote,
	RecipientHasBeenNotified
FROM	TaskAssignment
WHERE 	(@pkTaskAssignment IS NULL OR pkTaskAssignment = @pkTaskAssignment)
 AND 	(@fkTask IS NULL OR fkTask = @fkTask)
 AND 	(@Description IS NULL OR Description LIKE @Description + '%')
 AND 	(@fkApplicationUserAssignedBy IS NULL OR fkApplicationUserAssignedBy = @fkApplicationUserAssignedBy)
 AND 	(@fkApplicationUserAssignedTo IS NULL OR fkApplicationUserAssignedTo = @fkApplicationUserAssignedTo)
 AND 	(@fkTaskAssignmentReassignedTo IS NULL OR fkTaskAssignmentReassignedTo = @fkTaskAssignmentReassignedTo)
 AND 	(@fkrefTaskAssignmentStatus IS NULL OR fkrefTaskAssignmentStatus = @fkrefTaskAssignmentStatus)
 AND 	(@StartDate IS NULL OR StartDate = @StartDate)
 AND 	(@CompleteDate IS NULL OR CompleteDate = @CompleteDate)
 AND 	(@LUPUser IS NULL OR LUPUser LIKE @LUPUser + '%')
 AND 	(@LUPDate IS NULL OR LUPDate = @LUPDate)
 AND 	(@CreateUser IS NULL OR CreateUser LIKE @CreateUser + '%')
 AND 	(@CreateDate IS NULL OR CreateDate = @CreateDate)
 AND 	(@UserRead IS NULL OR UserRead = @UserRead)
 AND 	(@fkrefTaskAssignmentReason IS NULL OR fkrefTaskAssignmentReason = @fkrefTaskAssignmentReason)
 AND 	(@UserReadNote IS NULL OR UserReadNote = @UserReadNote)
 AND 	(@RecipientHasBeenNotified IS NULL OR RecipientHasBeenNotified = @RecipientHasBeenNotified)

