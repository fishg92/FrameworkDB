----------------------------------------------------------------------------
-- Select a single record from JoinTaskCPClient
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinTaskCPClientSelect]
(	@pkJoinTaskCPClient decimal(18, 0) = NULL,
	@fkCPClient decimal(18, 0) = NULL,
	@fkTask decimal(18, 0) = NULL
)
AS

SELECT	pkJoinTaskCPClient,
	fkCPClient,
	fkTask
FROM	JoinTaskCPClient
WHERE 	(@pkJoinTaskCPClient IS NULL OR pkJoinTaskCPClient = @pkJoinTaskCPClient)
 AND 	(@fkCPClient IS NULL OR fkCPClient = @fkCPClient)
 AND 	(@fkTask IS NULL OR fkTask = @fkTask)

