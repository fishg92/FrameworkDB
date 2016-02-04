----------------------------------------------------------------------------
-- Select a single record from TaskFilterTaskTypeDeselected
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspTaskFilterTaskTypeDeselectedSelect]
(	@pkTaskFilterTaskTypeDeselected decimal(18, 0) = NULL,
	@fkTaskFilter decimal(18, 0) = NULL,
	@fkrefTaskType decimal(18, 0) = NULL
)
AS

SELECT	pkTaskFilterTaskTypeDeselected,
	fkTaskFilter,
	fkrefTaskType
FROM	TaskFilterTaskTypeDeselected
WHERE 	(@pkTaskFilterTaskTypeDeselected IS NULL OR pkTaskFilterTaskTypeDeselected = @pkTaskFilterTaskTypeDeselected)
 AND 	(@fkTaskFilter IS NULL OR fkTaskFilter = @fkTaskFilter)
 AND 	(@fkrefTaskType IS NULL OR fkrefTaskType = @fkrefTaskType)
