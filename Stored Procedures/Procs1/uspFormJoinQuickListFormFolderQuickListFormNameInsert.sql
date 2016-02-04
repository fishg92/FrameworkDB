-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into FormJoinQuickListFormFolderQuickListFormName
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormJoinQuickListFormFolderQuickListFormNameInsert]
(	  @fkFormQuickListFolder decimal(10, 0)
	, @fkFormQuickListFormName decimal(10, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkFormJoinQuickListFormFolderQuickListFormName decimal(10, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT FormJoinQuickListFormFolderQuickListFormName
(	  fkFormQuickListFolder
	, fkFormQuickListFormName
)
VALUES 
(	  @fkFormQuickListFolder
	, @fkFormQuickListFormName

)

SET @pkFormJoinQuickListFormFolderQuickListFormName = SCOPE_IDENTITY()
