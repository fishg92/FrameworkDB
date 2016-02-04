----------------------------------------------------------------------------
-- Insert a single record into DocumentDipFolder
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspDocumentDipFolderInsert]
(	  @fkApplication decimal(18, 0)
	, @dipFolderPath varchar(500)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkDocumentDipFolder decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT DocumentDipFolder
(	  fkApplication
	, dipFolderPath
)
VALUES 
(	  @fkApplication
	, @dipFolderPath

)

SET @pkDocumentDipFolder = SCOPE_IDENTITY()
