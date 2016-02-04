-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in FormQuickListFolder
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormQuickListFolderUpdate]
(	  @pkFormQuickListFolder decimal(10, 0)
	, @fkFormQuickListFolder decimal(10, 0) = NULL
	, @fkFormUser decimal(10, 0) = NULL
	, @fkFormQuickListFolderName decimal(10, 0) = NULL
	, @DeleteOnFinish bit = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)

)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	FormQuickListFolder
SET	fkFormQuickListFolder = ISNULL(@fkFormQuickListFolder, fkFormQuickListFolder),
	fkFormUser = ISNULL(@fkFormUser, fkFormUser),
	fkFormQuickListFolderName = ISNULL(@fkFormQuickListFolderName, fkFormQuickListFolderName),
	DeleteOnFinish = ISNULL(@DeleteOnFinish, DeleteOnFinish)
WHERE 	pkFormQuickListFolder = @pkFormQuickListFolder
