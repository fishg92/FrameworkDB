
----------------------------------------------------------------------------
-- Select a single record from FormPath
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormPathSelect]
(	@pkFormPath decimal(10, 0) = NULL,
	@fkFormName decimal(10, 0) = NULL,
	@Path varchar(500) = NULL
)
AS

SELECT	pkFormPath,
	fkFormName,
	Path
FROM	FormPath
WHERE 	(@pkFormPath IS NULL OR pkFormPath = @pkFormPath)
 AND 	(@fkFormName IS NULL OR fkFormName = @fkFormName)
 AND 	(@Path IS NULL OR Path LIKE @Path + '%')


