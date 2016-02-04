-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in FormFolderName
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormFolderNameUpdate]
(	  @pkFormFolderName int
	, @FolderName varchar(255) = NULL
	, @Description varchar(500) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	FormFolderName
SET	FolderName = ISNULL(@FolderName, FolderName),
	Description = ISNULL(@Description, Description)
WHERE 	pkFormFolderName = @pkFormFolderName
