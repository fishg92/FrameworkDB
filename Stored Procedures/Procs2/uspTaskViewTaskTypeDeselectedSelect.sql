----------------------------------------------------------------------------
-- Select a single record from TaskViewTaskTypeDeselected
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspTaskViewTaskTypeDeselectedSelect]
(	@pkTaskViewTaskTypeDeselected decimal(18, 0) = NULL,
	@fkTaskView decimal(18, 0) = NULL,
	@fkrefTaskType decimal(18, 0) = NULL
)
AS

SELECT	pkTaskViewTaskTypeDeselected,
	fkTaskView,
	fkrefTaskType
FROM	TaskViewTaskTypeDeselected
WHERE 	(@pkTaskViewTaskTypeDeselected IS NULL OR pkTaskViewTaskTypeDeselected = @pkTaskViewTaskTypeDeselected)
 AND 	(@fkTaskView IS NULL OR fkTaskView = @fkTaskView)
 AND 	(@fkrefTaskType IS NULL OR fkrefTaskType = @fkrefTaskType)
