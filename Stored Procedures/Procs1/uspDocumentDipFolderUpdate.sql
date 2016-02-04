----------------------------------------------------------------------------
-- Update a single record in DocumentDipFolder
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspDocumentDipFolderUpdate]
(	  @pkDocumentDipFolder decimal(18, 0)
	, @fkApplication decimal(18, 0) = NULL
	, @dipFolderPath varchar(500) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	DocumentDipFolder
SET	fkApplication = ISNULL(@fkApplication, fkApplication),
	dipFolderPath = ISNULL(@dipFolderPath, dipFolderPath)
WHERE 	pkDocumentDipFolder = @pkDocumentDipFolder
