CREATE PROCEDURE [dbo].[uspIsTaskCategoryDeletable]
(
	  @pkrefTaskCategory decimal(18,0)
)
AS

declare @IsTaskCategoryDeletable bit;


select @IsTaskCategoryDeletable = case when exists (
	select pkrefTaskCategory 
		from dbo.TaskCategoryBranch (@pkrefTaskCategory) t 
			inner join refTaskType tt
			on tt.fkrefTaskCategory = t.pkrefTaskCategory
		) THEN 0
	else 1
	End

select @IsTaskCategoryDeletable 
