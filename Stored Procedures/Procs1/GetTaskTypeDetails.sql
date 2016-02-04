CREATE proc [dbo].[GetTaskTypeDetails]
	@pkrefTaskType decimal
	,@Description varchar(50) output
	,@DefaultDueMinutes decimal output
	,@DefaultGroupTask bit output
	,@DefaultPriority tinyint output
	,@Active bit output
as

select	@Description = Description
		,@DefaultDueMinutes = DefaultDueMinutes
		,@DefaultGroupTask = DefaultGroupTask
		,@DefaultPriority = DefaultPriority
		,@Active = Active
from	refTaskType
where	pkrefTaskType = @pkrefTaskType