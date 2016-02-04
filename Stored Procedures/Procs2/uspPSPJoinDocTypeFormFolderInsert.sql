----------------------------------------------------------------------------
-- Insert a single record into PSPJoinDocTypeFormFolder
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspPSPJoinDocTypeFormFolderInsert]
(	  @fkPSPDocType decimal(18, 0)
	, @fkFormFolder decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkPSPJoinDocTypeFormFolder decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT PSPJoinDocTypeFormFolder
(	  fkPSPDocType
	, fkFormFolder
)
VALUES 
(	  @fkPSPDocType
	, @fkFormFolder

)

SET @pkPSPJoinDocTypeFormFolder = SCOPE_IDENTITY()
