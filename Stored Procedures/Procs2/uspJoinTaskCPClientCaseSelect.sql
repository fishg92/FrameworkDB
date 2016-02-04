----------------------------------------------------------------------------
-- Select a single record from JoinTaskCPClientCase
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinTaskCPClientCaseSelect]
(	@pkJoinTaskCPClientCase decimal(18, 0) = NULL,
	@fkCPClientCase decimal(18, 0) = NULL,
	@fkTask decimal(18, 0) = NULL
)
AS

SELECT	pkJoinTaskCPClientCase,
	fkCPClientCase,
	fkTask
FROM	JoinTaskCPClientCase
WHERE 	(@pkJoinTaskCPClientCase IS NULL OR pkJoinTaskCPClientCase = @pkJoinTaskCPClientCase)
 AND 	(@fkCPClientCase IS NULL OR fkCPClientCase = @fkCPClientCase)
 AND 	(@fkTask IS NULL OR fkTask = @fkTask)