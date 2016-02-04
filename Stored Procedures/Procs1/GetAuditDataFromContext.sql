
CREATE proc [dbo].[GetAuditDataFromContext]
	@AuditUser varchar(50) output
	,@AuditMachine varchar(50) output
as

declare @pkWorkstationUser decimal

set @pkWorkstationUser = CONTEXT_INFO()

select @AuditUser = LUPUser
		,@AuditMachine = LUPMachine
from WorkstationUser with (nolock)
where pkWorkstationUser = @pkWorkstationUser

set @AuditUser = isnull(@AuditUser,host_name())
set @AuditMachine = isnull(@AuditMachine,'')