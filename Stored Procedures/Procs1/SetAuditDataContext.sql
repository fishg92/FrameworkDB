CREATE proc [dbo].[SetAuditDataContext]
	@AuditUser varchar (50)
	,@AuditMachine varchar(15)
as

declare @pkWorkstationUser decimal

select	@pkWorkstationUser = pkWorkstationUser
from	WorkstationUser
where	LUPUser = @AuditUser
and		LUPMachine = @AuditMachine

if @pkWorkstationUser is null
begin
	insert	WorkstationUser
		(
			LUPUser
			,LUPMachine
		)
	values
		(
			@AuditUser
			,@AuditMachine
		)

	select @pkWorkstationUser = SCOPE_IDENTITY()
end

declare @bin varbinary(128)
set @bin = convert(varbinary(128),@pkWorkstationUser)
set CONTEXT_INFO @bin
