
CREATE FUNCTION dbo.TaskCreateUser
(
	@pkTask decimal
)
RETURNS decimal
AS
BEGIN
	-- Declare the return variable here
	DECLARE @return decimal
	
	select	@return = AuditUser
	from	TaskAudit
	where	pk = 
		(
			select	min(pk)
			from	TaskAudit
			where	pkTask = @pkTask
			and		isnumeric(AuditUser) = 1
		)

	return isnull(@return,-1)	
		
END
