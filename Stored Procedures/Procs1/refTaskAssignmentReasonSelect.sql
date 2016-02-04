CREATE PROC [dbo].[refTaskAssignmentReasonSelect]
@fkrefTaskAssignmentStatus decimal(18, 0) = NULL,
@ActiveOnly bit = null

AS

SELECT	pkrefTaskAssignmentReason,
		fkrefTaskAssignmentStatus,
		Description,
		Active,
		CanDelete = 0
FROM	refTaskAssignmentReason
WHERE 	(fkrefTaskAssignmentStatus = @fkrefTaskAssignmentStatus OR @fkrefTaskAssignmentStatus IS NULL )
		AND
		(Active = @ActiveOnly OR @ActiveOnly IS NULL)

order by Description
