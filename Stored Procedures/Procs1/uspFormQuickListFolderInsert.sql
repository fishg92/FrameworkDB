-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into FormQuickListFolder
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormQuickListFolderInsert]
(	  @fkFormQuickListFolder decimal(10, 0)
	, @fkFormUser decimal(10, 0)
	, @fkFormQuickListFolderName decimal(10, 0)
	, @DeleteOnFinish bit = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkFormQuickListFolder decimal(10, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT FormQuickListFolder
(	  fkFormQuickListFolder
	, fkFormUser
	, fkFormQuickListFolderName
	, DeleteOnFinish
)
VALUES 
(	  @fkFormQuickListFolder
	, @fkFormUser
	, @fkFormQuickListFolderName
	, @DeleteOnFinish

)

SET @pkFormQuickListFolder = SCOPE_IDENTITY()
