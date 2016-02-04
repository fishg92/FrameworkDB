CREATE proc [dbo].[GetpkTaskTypeFromDMSID]
	@Description varchar(50)
	,@ExternalTaskingEngine varchar(50)
	,@pkrefTaskType decimal output
	,@NewlyAdded bit = null output
as

set @pkrefTaskType = null
set @NewlyAdded = 0

select	@pkrefTaskType = pkrefTaskType
from	refTaskType
where	DMSTaskTypeID = @Description

if @pkrefTaskType is null
	begin
	
	declare @fkrefTaskCategory decimal
	
	select	@fkrefTaskCategory = pkrefTaskCategory
	from	refTaskCategory
	where	ExternalTaskingEngineRoot = @ExternalTaskingEngine
	
	--Insert a new category record if needed
	if @fkrefTaskCategory is null
		begin
		insert	refTaskCategory
			(
				fkrefTaskCategoryParent
				,CategoryName
				,ExternalTaskingEngineRoot
			) values (
				-1
				,@ExternalTaskingEngine
				,@ExternalTaskingEngine
			)
		set @fkrefTaskCategory = scope_identity()
		end
	
	insert	refTaskType
		(
			Description
			,DefaultDueMinutes
			,DefaultGroupTask
			,DefaultPriority
			,Active
			,fkrefTaskCategory
			,DMSTaskTypeID
			,AllowDelete
			,AllowDescriptionEdit
		) values (
			@Description
			,1440
			,0
			,2
			,1
			,@fkrefTaskCategory
			,@Description
			,0
			,1
		)
		
	set @pkrefTaskType = scope_identity()
	
	set @NewlyAdded = 1
	end
