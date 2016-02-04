-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into FormJoinFormFolderFormGroup
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormJoinFormFolderFormGroupInsert]
(	  @fkFormFolder decimal(10, 0)
	, @fkFormGroup decimal(10, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkFormJoinFormFolderFormGroup decimal(10, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT FormJoinFormFolderFormGroup
(	  fkFormFolder
	, fkFormGroup
)
VALUES 
(	  @fkFormFolder
	, @fkFormGroup

)

SET @pkFormJoinFormFolderFormGroup = SCOPE_IDENTITY()
