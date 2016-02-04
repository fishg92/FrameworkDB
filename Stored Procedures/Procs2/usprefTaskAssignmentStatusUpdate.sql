----------------------------------------------------------------------------
-- Update a single record in refTaskAssignmentStatus
----------------------------------------------------------------------------
CREATE PROC [dbo].[usprefTaskAssignmentStatusUpdate]
(	  @pkrefTaskAssignmentStatus decimal(18, 0)
	, @Description varchar(50) = NULL
	, @AssignmentComplete decimal(18, 0) = NULL
	, @PropagateTaskStatus decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	refTaskAssignmentStatus
SET	Description = ISNULL(@Description, Description),
	AssignmentComplete = ISNULL(@AssignmentComplete, AssignmentComplete),
	PropagateTaskStatus = ISNULL(@PropagateTaskStatus, PropagateTaskStatus)
WHERE 	pkrefTaskAssignmentStatus = @pkrefTaskAssignmentStatus
