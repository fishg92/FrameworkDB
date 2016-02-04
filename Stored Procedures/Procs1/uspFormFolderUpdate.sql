-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in FormFolder
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormFolderUpdate]
(	  @pkFormFolder decimal(10, 0)
	, @fkFormFolder decimal(10, 0) = NULL
	, @fkFormFolderName decimal(10, 0) = NULL
	, @Hidden int = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	FormFolder
SET	fkFormFolder = ISNULL(COALESCE(@fkFormFolder, 0), fkFormFolder),
	fkFormFolderName = ISNULL(@fkFormFolderName, fkFormFolderName),
	Hidden = ISNULL(@Hidden, Hidden)
WHERE 	pkFormFolder = @pkFormFolder
