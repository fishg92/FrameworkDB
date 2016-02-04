
----------------------------------------------------------------------------
-- Select a single record from FormQuickListFolderName
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormQuickListFolderNameSelect]
(	
	@fkFormUser decimal(18,0)
)
AS

SELECT	DISTINCT pkFormQuickListFolderName
		, QuickListFolderName
FROM	FormQuickListFolderName
INNER JOIN FormQuickListFolder ON fkFormQuickListFolderName = pkFormQuickListFolderName
WHERE fkFormUser = @fkFormUser




