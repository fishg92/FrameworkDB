


create FUNCTION [dbo].[fnIsTaskAssignmentStatusPending](@pkrefTaskAssignmentStatus decimal)
RETURNS bit
AS
BEGIN
declare @return bit
set @return = 0

if exists (	select	* 
			from	refTaskAssignmentStatus
			join	refTaskAssignmentStatusGroup
				on refTaskAssignmentStatus.fkrefTaskAssignmentStatusGroup = refTaskAssignmentStatusGroup.pkrefTaskAssignmentStatusGroup
				where refTaskAssignmentStatus.pkrefTaskAssignmentStatus = @pkrefTaskAssignmentStatus
				and refTaskAssignmentStatusGroup.AssignmentPending = 1)	
	set @return = 1

return @return
END






