
----------------------------------------------------------------------------
-- Select a single record from FormJoinQuickListFormFolderQuickListFormName
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormJoinQuickListFormFolderQuickListFormNameSelect]
(	@pkFormJoinQuickListFormFolderQuickListFormName decimal(10, 0) = NULL,
	@fkFormQuickListFolder decimal(10, 0) = NULL,
	@fkFormQuickListFormName decimal(10, 0) = NULL
)
AS

SELECT	pkFormJoinQuickListFormFolderQuickListFormName,
	fkFormQuickListFolder,
	fkFormQuickListFormName
	
FROM	FormJoinQuickListFormFolderQuickListFormName
WHERE 	(@pkFormJoinQuickListFormFolderQuickListFormName IS NULL OR pkFormJoinQuickListFormFolderQuickListFormName = @pkFormJoinQuickListFormFolderQuickListFormName)
 AND 	(@fkFormQuickListFolder IS NULL OR fkFormQuickListFolder = @fkFormQuickListFolder)
 AND 	(@fkFormQuickListFormName IS NULL OR fkFormQuickListFormName = @fkFormQuickListFormName)




