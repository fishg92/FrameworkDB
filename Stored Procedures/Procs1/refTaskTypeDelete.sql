CREATE PROC [dbo].[refTaskTypeDelete]
(	@pkrefTaskType decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15) 
	, @LUPMachine varchar(15)
)
AS

declare @pkJoinrefTaskTyperefTaskEntityType decimal
		,@pkrefTaskTypeEscalation decimal

declare crEntity insensitive cursor for
select	pkJoinrefTaskTyperefTaskEntityType
from	JoinrefTaskTyperefTaskEntityType
where	fkrefTaskType = @pkrefTaskType

open crEntity
fetch next from crEntity into @pkJoinrefTaskTyperefTaskEntityType
while @@fetch_status = 0
	begin
	exec dbo.uspJoinrefTaskTyperefTaskEntityTypeDelete
			@pkJoinrefTaskTyperefTaskEntityType = @pkJoinrefTaskTyperefTaskEntityType
			, @LUPUser = @LUPUser
			, @LUPMac = @LUPMac
			, @LUPIP = @LUPIP
			, @LUPMachine = @LUPMachine
	
	fetch next from crEntity into @pkJoinrefTaskTyperefTaskEntityType
	end
close crEntity
deallocate crEntity

declare crEscalation insensitive cursor for
select pkrefTaskTypeEscalation
from refTaskTypeEscalation
where fkrefTaskType = @pkrefTaskType

open crEscalation
fetch next from crEscalation into @pkrefTaskTypeEscalation
while @@fetch_status = 0
	begin
	exec dbo.usprefTaskTypeEscalationDelete
			@pkrefTaskTypeEscalation = @pkrefTaskTypeEscalation
			, @LUPUser = @LUPUser
			, @LUPMac = @LUPMac
			, @LUPIP = @LUPIP
			, @LUPMachine = @LUPMachine
		
	fetch next from crEscalation into @pkrefTaskTypeEscalation
	end
	
close crEscalation
deallocate crEscalation

exec dbo.usprefTaskTypeDelete
		@pkrefTaskType = @pkrefTaskType
		, @LUPUser = @LUPUser
		, @LUPMac = @LUPMac
		, @LUPIP = @LUPIP
		, @LUPMachine = @LUPMachine
