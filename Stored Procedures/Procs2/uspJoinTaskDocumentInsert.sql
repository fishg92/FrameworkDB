----------------------------------------------------------------------------
-- Insert a single record into JoinTaskDocument
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspJoinTaskDocumentInsert]
(	  @fkDocument varchar(50)
	, @fkTask decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkJoinTaskDocument decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT JoinTaskDocument
(	  fkDocument
	, fkTask
)
VALUES 
(	  @fkDocument
	, @fkTask

)

SET @pkJoinTaskDocument = SCOPE_IDENTITY()
