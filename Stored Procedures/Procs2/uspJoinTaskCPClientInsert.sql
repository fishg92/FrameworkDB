----------------------------------------------------------------------------
-- Insert a single record into JoinTaskCPClient
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspJoinTaskCPClientInsert]
(	  @fkCPClient decimal(18, 0)
	, @fkTask decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkJoinTaskCPClient decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT JoinTaskCPClient
(	  fkCPClient
	, fkTask
)
VALUES 
(	  @fkCPClient
	, @fkTask

)

SET @pkJoinTaskCPClient = SCOPE_IDENTITY()
