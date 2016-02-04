----------------------------------------------------------------------------
-- Select a single record from UserTaskTypeDeselected
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspUserTaskTypeDeselectedSelect]
(	@pkUserTaskTypeDeselected decimal(18, 0) = NULL,
	@fkApplicationUser decimal(18, 0) = NULL,
	@fkrefTaskType decimal(18, 0) = NULL
)
AS

SELECT	pkUserTaskTypeDeselected,
	fkApplicationUser,
	fkrefTaskType
FROM	UserTaskTypeDeselected
WHERE 	(@pkUserTaskTypeDeselected IS NULL OR pkUserTaskTypeDeselected = @pkUserTaskTypeDeselected)
 AND 	(@fkApplicationUser IS NULL OR fkApplicationUser = @fkApplicationUser)
 AND 	(@fkrefTaskType IS NULL OR fkrefTaskType = @fkrefTaskType)
