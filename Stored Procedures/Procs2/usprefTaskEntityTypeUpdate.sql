----------------------------------------------------------------------------
-- Update a single record in refTaskEntityType
----------------------------------------------------------------------------
CREATE PROC [dbo].[usprefTaskEntityTypeUpdate]
(	  @pkrefTaskEntityType decimal(18, 0)
	, @fkNCPApplication decimal(18, 0) = NULL
	, @ParentTable varchar(50) = NULL
	, @Description varchar(50) = NULL
	, @EntityJoinTable varchar(50) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	refTaskEntityType
SET	fkNCPApplication = ISNULL(@fkNCPApplication, fkNCPApplication),
	ParentTable = ISNULL(@ParentTable, ParentTable),
	Description = ISNULL(@Description, Description),
	EntityJoinTable = ISNULL(@EntityJoinTable, EntityJoinTable)
WHERE 	pkrefTaskEntityType = @pkrefTaskEntityType
