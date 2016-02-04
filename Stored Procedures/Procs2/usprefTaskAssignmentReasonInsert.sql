----------------------------------------------------------------------------
-- Insert a single record into refTaskAssignmentReason
----------------------------------------------------------------------------
CREATE Proc [dbo].[usprefTaskAssignmentReasonInsert]
(	  @fkrefTaskAssignmentStatus decimal(18, 0)
	, @Description varchar(50) = NULL
	, @Active bit = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkrefTaskAssignmentReason decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT refTaskAssignmentReason
(	  fkrefTaskAssignmentStatus
	, Description
	, Active
)
VALUES 
(	  @fkrefTaskAssignmentStatus
	, @Description
	, @Active

)

SET @pkrefTaskAssignmentReason = SCOPE_IDENTITY()
