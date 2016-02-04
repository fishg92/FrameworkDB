
----------------------------------------------------------------------------
-- Update a single record in FormJoinFormFolderFormName
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormJoinFormFolderFormNameUpdate]
(	  @pkFormJoinFormFolderFormName decimal(10, 0)
	, @fkFormFolder decimal(10, 0) = NULL
	, @fkFormName decimal(10, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	FormJoinFormFolderFormName
SET	fkFormFolder = ISNULL(@fkFormFolder, fkFormFolder),
	fkFormName = ISNULL(@fkFormName, fkFormName)
WHERE 	pkFormJoinFormFolderFormName = @pkFormJoinFormFolderFormName
