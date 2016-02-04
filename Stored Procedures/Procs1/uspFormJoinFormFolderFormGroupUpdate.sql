-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in FormJoinFormFolderFormGroup
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormJoinFormFolderFormGroupUpdate]
(	  @pkFormJoinFormFolderFormGroup decimal(10, 0)
	, @fkFormFolder decimal(10, 0) = NULL
	, @fkFormGroup decimal(10, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	FormJoinFormFolderFormGroup
SET	fkFormFolder = ISNULL(@fkFormFolder, fkFormFolder),
	fkFormGroup = ISNULL(@fkFormGroup, fkFormGroup)
WHERE 	pkFormJoinFormFolderFormGroup = @pkFormJoinFormFolderFormGroup
