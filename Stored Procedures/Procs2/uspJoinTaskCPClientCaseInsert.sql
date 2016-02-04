----------------------------------------------------------------------------
-- Insert a single record into JoinTaskCPClientCase
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspJoinTaskCPClientCaseInsert]
(	  @fkCPClientCase decimal(18, 0)
	, @fkTask decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkJoinTaskCPClientCase decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT JoinTaskCPClientCase
(	  fkCPClientCase
	, fkTask
)
VALUES 
(	  @fkCPClientCase
	, @fkTask

)

SET @pkJoinTaskCPClientCase = SCOPE_IDENTITY()
