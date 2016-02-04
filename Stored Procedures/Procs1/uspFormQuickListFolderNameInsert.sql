-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into FormQuickListFolderName
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspFormQuickListFolderNameInsert]
(	  @QuickListFolderName varchar(255)
	, @Description varchar(500) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkFormQuickListFolderName decimal(10, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT FormQuickListFolderName
(	  QuickListFolderName
	, Description
)
VALUES 
(	  @QuickListFolderName
	, @Description

)

SET @pkFormQuickListFolderName = SCOPE_IDENTITY()
