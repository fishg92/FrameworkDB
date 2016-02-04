
----------------------------------------------------------------------------
-- Select a single record from FormJoinFormFolderFormName
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormJoinFormFolderFormNameSelect]
(	@pkFormJoinFormFolderFormName decimal(10, 0) = NULL,
	@fkFormFolder decimal(10, 0) = NULL,
	@fkFormName decimal(10, 0) = NULL
)
AS

SELECT	pkFormJoinFormFolderFormName,
	fkFormFolder,
	fkFormName
FROM	FormJoinFormFolderFormName
WHERE 	(@pkFormJoinFormFolderFormName IS NULL OR pkFormJoinFormFolderFormName = @pkFormJoinFormFolderFormName)
 AND 	(@fkFormFolder IS NULL OR fkFormFolder = @fkFormFolder)
 AND 	(@fkFormName IS NULL OR fkFormName = @fkFormName)



