----------------------------------------------------------------------------
-- Update a single record in PSPJoinDocTypeFormFolder
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspPSPJoinDocTypeFormFolderUpdate]
(	  @pkPSPJoinDocTypeFormFolder decimal(18, 0)
	, @fkPSPDocType decimal(18, 0) = NULL
	, @fkFormFolder decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	PSPJoinDocTypeFormFolder
SET	fkPSPDocType = ISNULL(@fkPSPDocType, fkPSPDocType),
	fkFormFolder = ISNULL(@fkFormFolder, fkFormFolder)
WHERE 	pkPSPJoinDocTypeFormFolder = @pkPSPJoinDocTypeFormFolder
