----------------------------------------------------------------------------
-- Insert a single record into refTaskAssignmentStatus
----------------------------------------------------------------------------
CREATE Proc [dbo].[usprefTaskAssignmentStatusInsert]
(	  @Description varchar(50)
	, @AssignmentComplete decimal(18, 0) = NULL
	, @PropagateTaskStatus decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkrefTaskAssignmentStatus decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT refTaskAssignmentStatus
(	  Description
	, AssignmentComplete
	, PropagateTaskStatus
)
VALUES 
(	  @Description
	, @AssignmentComplete
	, COALESCE(@PropagateTaskStatus, (-1))

)

SET @pkrefTaskAssignmentStatus = SCOPE_IDENTITY()
