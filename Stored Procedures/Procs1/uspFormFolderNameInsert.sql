-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into FormFolderName
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormFolderNameInsert]
(	  @FolderName varchar(255)
	, @Description varchar(500) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkFormFolderName decimal(10, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT FormFolderName
(	  FolderName
	, Description
)
VALUES 
(	  @FolderName
	, @Description

)

SET @pkFormFolderName = SCOPE_IDENTITY()
