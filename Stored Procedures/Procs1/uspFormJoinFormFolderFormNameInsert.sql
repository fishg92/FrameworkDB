
----------------------------------------------------------------------------
-- Insert a single record into FormJoinFormFolderFormName
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormJoinFormFolderFormNameInsert]
(	  @fkFormFolder decimal(10, 0)
	, @fkFormName decimal(10, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkFormJoinFormFolderFormName decimal(10, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT FormJoinFormFolderFormName
(	  fkFormFolder
	, fkFormName
)
VALUES 
(	  @fkFormFolder
	, @fkFormName

)

SET @pkFormJoinFormFolderFormName = SCOPE_IDENTITY()
