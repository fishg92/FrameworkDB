----------------------------------------------------------------------------
-- Select a single record from JoinTaskCPClientFormName
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinTaskCPClientFormNameSelect]
(	@pkJoinTaskCPClientFormName decimal(18, 0) = NULL,
	@fkJoinTaskCPClient decimal(18, 0) = NULL,
	@fkFormName decimal(18, 0) = NULL
)
AS

SELECT	pkJoinTaskCPClientFormName,
	fkJoinTaskCPClient,
	fkFormName
FROM	JoinTaskCPClientFormName
WHERE 	(@pkJoinTaskCPClientFormName IS NULL OR pkJoinTaskCPClientFormName = @pkJoinTaskCPClientFormName)
 AND 	(@fkJoinTaskCPClient IS NULL OR fkJoinTaskCPClient = @fkJoinTaskCPClient)
 AND 	(@fkFormName IS NULL OR fkFormName = @fkFormName)

