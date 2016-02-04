----------------------------------------------------------------------------
-- Insert a single record into TaskAssignment
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspTaskAssignmentInsert]
(	  @fkTask decimal(18, 0)
	, @Description varchar(100) = NULL
	, @fkApplicationUserAssignedBy decimal(18, 0)
	, @fkApplicationUserAssignedTo decimal(18, 0)
	, @fkTaskAssignmentReassignedTo decimal(18, 0) = NULL
	, @fkrefTaskAssignmentStatus decimal(18, 0)
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
	, @pkTaskAssignment decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT TaskAssignment
(	  fkTask
	, Description
	, fkApplicationUserAssignedBy
	, fkApplicationUserAssignedTo
	, fkTaskAssignmentReassignedTo
	, fkrefTaskAssignmentStatus
	, StartDate
	, CompleteDate
	, UserRead
	, fkrefTaskAssignmentReason
	, UserReadNote
	, RecipientHasBeenNotified
)
VALUES 
(	  @fkTask
	, COALESCE(@Description, '')
	, @fkApplicationUserAssignedBy
	, @fkApplicationUserAssignedTo
	, @fkTaskAssignmentReassignedTo
	, @fkrefTaskAssignmentStatus
	, @StartDate
	, @CompleteDate
	, COALESCE(@UserRead, (0))
	, @fkrefTaskAssignmentReason
	, COALESCE(@UserReadNote, (0))
	, COALESCE(@RecipientHasBeenNotified, (0))

)

SET @pkTaskAssignment = SCOPE_IDENTITY()
