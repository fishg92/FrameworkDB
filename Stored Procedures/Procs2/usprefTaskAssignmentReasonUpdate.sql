----------------------------------------------------------------------------
-- Update a single record in refTaskAssignmentReason
----------------------------------------------------------------------------
CREATE PROC [dbo].[usprefTaskAssignmentReasonUpdate]
(	  @pkrefTaskAssignmentReason decimal(18, 0)
	, @fkrefTaskAssignmentStatus decimal(18, 0) = NULL
	, @Description varchar(50) = NULL
	, @Active bit = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	refTaskAssignmentReason
SET	fkrefTaskAssignmentStatus = ISNULL(@fkrefTaskAssignmentStatus, fkrefTaskAssignmentStatus),
	Description = ISNULL(@Description, Description),
	Active = ISNULL(@Active, Active)
WHERE 	pkrefTaskAssignmentReason = @pkrefTaskAssignmentReason
