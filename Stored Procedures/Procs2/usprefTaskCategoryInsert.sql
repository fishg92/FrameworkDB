----------------------------------------------------------------------------
-- Insert a single record into refTaskCategory
----------------------------------------------------------------------------
CREATE Proc [dbo].[usprefTaskCategoryInsert]
(	  @fkrefTaskCategoryParent decimal(18, 0)
	, @CategoryName varchar(50)
	, @ExternalTaskingEngineRoot varchar(50) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkrefTaskCategory decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT refTaskCategory
(	  fkrefTaskCategoryParent
	, CategoryName
	, ExternalTaskingEngineRoot
)
VALUES 
(	  @fkrefTaskCategoryParent
	, @CategoryName
	, COALESCE(@ExternalTaskingEngineRoot, '')

)

SET @pkrefTaskCategory = SCOPE_IDENTITY()
