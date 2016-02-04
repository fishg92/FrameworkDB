-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in FormQuickListFolderName
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspFormQuickListFolderNameUpdate]
(	  @pkFormQuickListFolderName int
	, @QuickListFolderName varchar(255) = NULL
	, @Description varchar(500) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	FormQuickListFolderName
SET	QuickListFolderName = ISNULL(@QuickListFolderName, QuickListFolderName),
	Description = ISNULL(@Description, Description)
WHERE 	pkFormQuickListFolderName = @pkFormQuickListFolderName
