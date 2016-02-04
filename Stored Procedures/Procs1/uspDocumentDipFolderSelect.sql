----------------------------------------------------------------------------
-- Select a single record from DocumentDipFolder
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspDocumentDipFolderSelect]
(	@pkDocumentDipFolder decimal(18, 0) = NULL,
	@fkApplication decimal(18, 0) = NULL,
	@dipFolderPath varchar(500) = NULL
)
AS

SELECT	pkDocumentDipFolder,
	fkApplication,
	dipFolderPath
FROM	DocumentDipFolder
WHERE 	(@pkDocumentDipFolder IS NULL OR pkDocumentDipFolder = @pkDocumentDipFolder)
 AND 	(@fkApplication IS NULL OR fkApplication = @fkApplication)
 AND 	(@dipFolderPath IS NULL OR dipFolderPath LIKE @dipFolderPath + '%')
