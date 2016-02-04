----------------------------------------------------------------------------
-- Select a single record from refTaskAssignmentStatus
----------------------------------------------------------------------------
CREATE PROC [dbo].[usprefTaskAssignmentStatusSelect]
(	@pkrefTaskAssignmentStatus decimal(18, 0) = NULL,
	@Description varchar(50) = NULL,
	@AssignmentComplete decimal(18, 0) = NULL,
	@PropagateTaskStatus decimal(18, 0) = NULL
)
AS

SELECT	pkrefTaskAssignmentStatus,
	Description,
	AssignmentComplete,
	PropagateTaskStatus
FROM	refTaskAssignmentStatus
WHERE 	(@pkrefTaskAssignmentStatus IS NULL OR pkrefTaskAssignmentStatus = @pkrefTaskAssignmentStatus)
 AND 	(@Description IS NULL OR Description LIKE @Description + '%')
 AND 	(@AssignmentComplete IS NULL OR AssignmentComplete = @AssignmentComplete)
 AND 	(@PropagateTaskStatus IS NULL OR PropagateTaskStatus = @PropagateTaskStatus)
