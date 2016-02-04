----------------------------------------------------------------------------
-- Select a single record from refTaskEntityType
----------------------------------------------------------------------------
CREATE PROC [dbo].[usprefTaskEntityTypeSelect]
(	@pkrefTaskEntityType decimal(18, 0) = NULL,
	@fkNCPApplication decimal(18, 0) = NULL,
	@ParentTable varchar(50) = NULL,
	@Description varchar(50) = NULL,
	@EntityJoinTable varchar(50) = NULL
)
AS

SELECT	pkrefTaskEntityType,
	fkNCPApplication,
	ParentTable,
	Description,
	EntityJoinTable
FROM	refTaskEntityType
WHERE 	(@pkrefTaskEntityType IS NULL OR pkrefTaskEntityType = @pkrefTaskEntityType)
 AND 	(@fkNCPApplication IS NULL OR fkNCPApplication = @fkNCPApplication)
 AND 	(@ParentTable IS NULL OR ParentTable LIKE @ParentTable + '%')
 AND 	(@Description IS NULL OR Description LIKE @Description + '%')
 AND 	(@EntityJoinTable IS NULL OR EntityJoinTable LIKE @EntityJoinTable + '%')
