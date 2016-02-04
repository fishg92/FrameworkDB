-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into FormFolder
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormFolderInsert]
(	  @fkFormFolder decimal(10, 0) = NULL
	, @fkFormFolderName decimal(10, 0)
	, @Hidden int = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkFormFolder decimal(10, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT FormFolder
(	  fkFormFolder
	, fkFormFolderName
	, Hidden
)
VALUES 
(	  COALESCE(@fkFormFolder, 0)
	, @fkFormFolderName
	, @Hidden

)

SET @pkFormFolder = SCOPE_IDENTITY()
