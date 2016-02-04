
CREATE PROC [dbo].[CanTaskStatusAssignmentReasonBeDeleted]
@fkrefTaskAssignmentReason decimal(18, 0)
AS

Select 
		CanDelete =
		CASE WHEN EXISTS(SELECT * FROM TaskAssignment t (nolock) WHERE t.fkRefTaskAssignmentReason = @fkrefTaskAssignmentReason) THEN
			0
		WHEN EXISTS(SELECT * FROM TaskAssignmentAudit a (nolock) WHERE a.fkRefTaskAssignmentReason = @fkrefTaskAssignmentReason) THEN
			0
		ELSE
			1
		END
