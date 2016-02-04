----------------------------------------------------------------------------
-- Update a single record in refTaskCategory
----------------------------------------------------------------------------
CREATE PROC [dbo].[usprefTaskCategoryUpdate]
(	  @pkrefTaskCategory decimal(18, 0)
	, @fkrefTaskCategoryParent decimal(18, 0) = NULL
	, @CategoryName varchar(50) = NULL
	, @ExternalTaskingEngineRoot varchar(50) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	refTaskCategory
SET	fkrefTaskCategoryParent = ISNULL(@fkrefTaskCategoryParent, fkrefTaskCategoryParent),
	CategoryName = ISNULL(@CategoryName, CategoryName),
	ExternalTaskingEngineRoot = ISNULL(@ExternalTaskingEngineRoot, ExternalTaskingEngineRoot)
WHERE 	pkrefTaskCategory = @pkrefTaskCategory
