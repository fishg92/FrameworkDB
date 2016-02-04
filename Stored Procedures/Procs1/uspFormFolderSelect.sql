
----------------------------------------------------------------------------
-- Select a single record from FormFolder
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormFolderSelect]
(	@pkFormFolder decimal(10, 0) = NULL,
	@fkFormFolder decimal(10, 0) = NULL,
	@fkFormFolderName decimal(10, 0) = NULL,
	@Hidden int = NULL
)
AS

SELECT	pkFormFolder,
	fkFormFolder,
	fkFormFolderName,
	Hidden
FROM	FormFolder
WHERE 	(@pkFormFolder IS NULL OR pkFormFolder = @pkFormFolder)
 AND 	(@fkFormFolder IS NULL OR fkFormFolder = @fkFormFolder)
 AND 	(@fkFormFolderName IS NULL OR fkFormFolderName = @fkFormFolderName)
 AND 	(@Hidden IS NULL OR Hidden = @Hidden)




