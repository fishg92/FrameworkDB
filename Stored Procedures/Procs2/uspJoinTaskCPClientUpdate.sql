----------------------------------------------------------------------------
-- Update a single record in JoinTaskCPClient
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinTaskCPClientUpdate]
(	  @pkJoinTaskCPClient decimal(18, 0)
	, @fkCPClient decimal(18, 0) = NULL
	, @fkTask decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	JoinTaskCPClient
SET	fkCPClient = ISNULL(@fkCPClient, fkCPClient),
	fkTask = ISNULL(@fkTask, fkTask)
WHERE 	pkJoinTaskCPClient = @pkJoinTaskCPClient
