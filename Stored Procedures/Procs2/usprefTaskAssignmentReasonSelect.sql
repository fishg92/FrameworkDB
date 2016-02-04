
--usprefTaskAssignmentReasonSelect null, 1, null, 0
----------------------------------------------------------------------------
-- Select a record(s) from refTaskAssignmentReason
----------------------------------------------------------------------------
CREATE PROC [dbo].[usprefTaskAssignmentReasonSelect]
@pkrefTaskAssignmentReason decimal(18, 0) = NULL,
@fkrefTaskAssignmentStatus decimal(18, 0) = NULL,
@Description varchar(50) = NULL,
@ActiveOnly bit = NULL

AS

SELECT	pkrefTaskAssignmentReason,
		fkrefTaskAssignmentStatus,
		Description,
		Active
FROM	refTaskAssignmentReason
WHERE 	(@fkrefTaskAssignmentStatus IS NULL OR fkrefTaskAssignmentStatus = @fkrefTaskAssignmentStatus)
AND 	(@ActiveOnly IS NULL OR Active >= @ActiveOnly) 
order by Description


