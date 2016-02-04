----------------------------------------------------------------------------
-- Insert a single record into refTaskEntityType
----------------------------------------------------------------------------
CREATE Proc [dbo].[usprefTaskEntityTypeInsert]
(	  @fkNCPApplication decimal(18, 0)
	, @ParentTable varchar(50) = NULL
	, @Description varchar(50) = NULL
	, @EntityJoinTable varchar(50) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkrefTaskEntityType decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT refTaskEntityType
(	  fkNCPApplication
	, ParentTable
	, Description
	, EntityJoinTable
)
VALUES 
(	  @fkNCPApplication
	, COALESCE(@ParentTable, '')
	, COALESCE(@Description, '')
	, COALESCE(@EntityJoinTable, '')

)

SET @pkrefTaskEntityType = SCOPE_IDENTITY()
