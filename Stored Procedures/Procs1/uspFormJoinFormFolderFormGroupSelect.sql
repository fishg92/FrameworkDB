
----------------------------------------------------------------------------
-- Select a single record from FormJoinFormFolderFormGroup
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormJoinFormFolderFormGroupSelect]
(	@pkFormJoinFormFolderFormGroup decimal(10, 0) = NULL,
	@fkFormFolder decimal(10, 0) = NULL,
	@fkFormGroup decimal(10, 0) = NULL
)
AS

SELECT	pkFormJoinFormFolderFormGroup,
	fkFormFolder,
	fkFormGroup
FROM	FormJoinFormFolderFormGroup
WHERE 	(@pkFormJoinFormFolderFormGroup IS NULL OR pkFormJoinFormFolderFormGroup = @pkFormJoinFormFolderFormGroup)
 AND 	(@fkFormFolder IS NULL OR fkFormFolder = @fkFormFolder)
 AND 	(@fkFormGroup IS NULL OR fkFormGroup = @fkFormGroup)



