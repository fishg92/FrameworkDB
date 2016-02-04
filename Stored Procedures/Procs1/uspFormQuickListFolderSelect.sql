
----------------------------------------------------------------------------
-- Select a single record from FormQuickListFolder
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormQuickListFolderSelect]
(	@pkFormQuickListFolder decimal(10, 0) = NULL,
	@fkFormQuickListFolder decimal(10, 0) = NULL,
	@fkFormUser decimal(10, 0) = NULL,
	@fkFormQuickListFolderName decimal(10, 0) = NULL,
	@DeleteOnFinish bit = NULL
)
AS

SELECT	pkFormQuickListFolder,
	fkFormQuickListFolder,
	fkFormUser,
	fkFormQuickListFolderName,
	DeleteOnFinish
	
FROM	FormQuickListFolder
WHERE 	(@pkFormQuickListFolder IS NULL OR pkFormQuickListFolder = @pkFormQuickListFolder)
 AND 	(@fkFormQuickListFolder IS NULL OR fkFormQuickListFolder = @fkFormQuickListFolder)
 AND 	(@fkFormUser IS NULL OR fkFormUser = @fkFormUser)
 AND 	(@fkFormQuickListFolderName IS NULL OR fkFormQuickListFolderName = @fkFormQuickListFolderName)
 AND 	(@DeleteOnFinish IS NULL OR DeleteOnFinish = @DeleteOnFinish)



