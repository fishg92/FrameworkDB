----------------------------------------------------------------------------
-- Select a single record from refTaskCategory
----------------------------------------------------------------------------
CREATE PROC [dbo].[usprefTaskCategorySelect]
(	@pkrefTaskCategory decimal(18, 0) = NULL,
	@fkrefTaskCategoryParent decimal(18, 0) = NULL,
	@CategoryName varchar(50) = NULL,
	@ExternalTaskingEngineRoot varchar(50) = NULL
)
AS

SELECT	pkrefTaskCategory,
	fkrefTaskCategoryParent,
	CategoryName,
	ExternalTaskingEngineRoot
FROM	refTaskCategory
WHERE 	(@pkrefTaskCategory IS NULL OR pkrefTaskCategory = @pkrefTaskCategory)
 AND 	(@fkrefTaskCategoryParent IS NULL OR fkrefTaskCategoryParent = @fkrefTaskCategoryParent)
 AND 	(@CategoryName IS NULL OR CategoryName LIKE @CategoryName + '%')
 AND 	(@ExternalTaskingEngineRoot IS NULL OR ExternalTaskingEngineRoot LIKE @ExternalTaskingEngineRoot + '%')

