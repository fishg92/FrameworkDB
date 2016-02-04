CREATE proc [dbo].[GetTaskCategories]
	@fkrefTaskCategoryParent decimal
AS

SELECT    pkrefTaskCategory
		, fkrefTaskCategoryParent
		, CategoryName
		, ExternalTaskingEngineRoot
FROM refTaskCategory
WHERE fkrefTaskCategoryParent = @fkrefTaskCategoryParent