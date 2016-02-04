----------------------------------------------------------------------------
-- Update a single record in JoinTaskDocument
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinTaskDocumentUpdate]
(	  @pkJoinTaskDocument decimal(18, 0)
	, @fkDocument varchar(50) = NULL
	, @fkTask decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	JoinTaskDocument
SET	fkDocument = ISNULL(@fkDocument, fkDocument),
	fkTask = ISNULL(@fkTask, fkTask)
WHERE 	pkJoinTaskDocument = @pkJoinTaskDocument
