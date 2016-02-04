-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in FormJoinQuickListFormFolderQuickListFormName
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormJoinQuickListFormFolderQuickListFormNameUpdate]
(	  @pkFormJoinQuickListFormFolderQuickListFormName decimal(10, 0)
	, @fkFormQuickListFolder decimal(10, 0) = NULL
	, @fkFormQuickListFormName decimal(10, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	FormJoinQuickListFormFolderQuickListFormName
SET	fkFormQuickListFolder = ISNULL(@fkFormQuickListFolder, fkFormQuickListFolder),
	fkFormQuickListFormName = ISNULL(@fkFormQuickListFormName, fkFormQuickListFormName)
WHERE 	pkFormJoinQuickListFormFolderQuickListFormName = @pkFormJoinQuickListFormFolderQuickListFormName
