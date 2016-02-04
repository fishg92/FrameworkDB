----------------------------------------------------------------------------
-- Select a single record from JoinrefTaskTyperefTaskEntityType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinrefTaskTyperefTaskEntityTypeSelect]
(	@pkJoinrefTaskTyperefTaskEntityType decimal(18, 0) = NULL,
	@fkrefTaskType decimal(18, 0) = NULL,
	@fkrefTaskEntityType decimal(18, 0) = NULL
)
AS

SELECT	pkJoinrefTaskTyperefTaskEntityType,
	fkrefTaskType,
	fkrefTaskEntityType
FROM	JoinrefTaskTyperefTaskEntityType
WHERE 	(@pkJoinrefTaskTyperefTaskEntityType IS NULL OR pkJoinrefTaskTyperefTaskEntityType = @pkJoinrefTaskTyperefTaskEntityType)
 AND 	(@fkrefTaskType IS NULL OR fkrefTaskType = @fkrefTaskType)
 AND 	(@fkrefTaskEntityType IS NULL OR fkrefTaskEntityType = @fkrefTaskEntityType)
