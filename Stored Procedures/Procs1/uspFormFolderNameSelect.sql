
----------------------------------------------------------------------------
-- Select a single record from FormFolderName
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormFolderNameSelect]
(	@pkFormFolderName decimal(10, 0) = NULL,
	@FolderName varchar(255) = NULL,
	@Description varchar(500) = NULL
)
AS

SELECT	pkFormFolderName,
	FolderName,
	Description
FROM	FormFolderName
WHERE 	(@pkFormFolderName IS NULL OR pkFormFolderName = @pkFormFolderName)
 AND 	(@FolderName IS NULL OR FolderName LIKE @FolderName + '%')
 AND 	(@Description IS NULL OR Description LIKE @Description + '%')



