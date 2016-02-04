


create FUNCTION [dbo].[TaskCompletionAuditRecord] (
  @pkTaskAssignment decimal
)
-- If the OriginalValue = CheckValue then return the default value
--		OTHERWISE, just return the original value
RETURNS   decimal AS  
BEGIN 
declare @Return decimal

	select @return = min(pk)
	from TaskAssignmentAudit
	where pkTaskAssignment = @pkTaskAssignment
	and CompleteDate = (select max(CompleteDate)
						from TaskAssignmentAudit
						where pkTaskAssignment = @pkTaskAssignment)


return @Return
END


