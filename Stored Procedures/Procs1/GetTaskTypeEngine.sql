CREATE proc [dbo].[GetTaskTypeEngine]
	@pkrefTaskType decimal
as

declare @DMSTaskTypeID varchar(50)
		,@TaskingEngine varchar(50)
		
select	@DMSTaskTypeID = DMSTaskTypeID
from	refTaskType
where	pkrefTaskType = @pkrefTaskType

set @DMSTaskTypeID = ltrim(rtrim(isnull(@DMSTaskTypeID,'')))

if @DMSTaskTypeID = ''
	set @TaskingEngine = 'Compass'
else
	begin
	select @TaskingEngine = ItemValue
	from	Configuration
	where	ItemKey = 'ExternalTaskingEngine'
	
	set @TaskingEngine = ltrim(rtrim(isnull(@TaskingEngine,'Compass')))
	end

select TaskingEngine = @TaskingEngine
