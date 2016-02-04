----------------------------------------------------------------------------
-- Update a single record in JoinTaskCPClientCase
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinTaskCPClientCaseUpdate]
(	  @pkJoinTaskCPClientCase decimal(18, 0)
	, @fkCPClientCase decimal(18, 0) = NULL
	, @fkTask decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	JoinTaskCPClientCase
SET	fkCPClientCase = ISNULL(@fkCPClientCase, fkCPClientCase),
	fkTask = ISNULL(@fkTask, fkTask)
WHERE 	pkJoinTaskCPClientCase = @pkJoinTaskCPClientCase
