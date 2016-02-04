CREATE proc [dbo].[CreateNewTaskType]
	@Description varchar(50)
	,@DMSWorkflowName varchar(50)
	,@DMSTaskTypeID varchar(50)
	,@ExternalTaskingEngine varchar(50)
	,@DMSNewTaskWorkflow varchar(50)
	,@Active bit = 1
	,@pkrefTaskType decimal = null output
as

set @pkrefTaskType = null


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
		,DMSNewTaskWorkflow
		,DMSWorkflowName
	) values (
		@Description
		,1440
		,0
		,2
		,@Active
		,@fkrefTaskCategory
		,@DMSTaskTypeID
		,1
		,1
		,@DMSNewTaskWorkflow
		,@DMSWorkflowName
		
	)
	
set @pkrefTaskType = scope_identity()


