----------------------------------------------------------------------------
-- Select a single record from PSPJoinDocTypeFormFolder
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspPSPJoinDocTypeFormFolderSelect]
(	@pkPSPJoinDocTypeFormFolder decimal(18, 0) = NULL,
	@fkPSPDocType decimal(18, 0) = NULL,
	@fkFormFolder decimal(18, 0) = NULL
)
AS

SELECT	pkPSPJoinDocTypeFormFolder,
	fkPSPDocType,
	fkFormFolder
FROM	PSPJoinDocTypeFormFolder
WHERE 	(@pkPSPJoinDocTypeFormFolder IS NULL OR pkPSPJoinDocTypeFormFolder = @pkPSPJoinDocTypeFormFolder)
 AND 	(@fkPSPDocType IS NULL OR fkPSPDocType = @fkPSPDocType)
 AND 	(@fkFormFolder IS NULL OR fkFormFolder = @fkFormFolder)


