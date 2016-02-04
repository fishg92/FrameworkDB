----------------------------------------------------------------------------
-- Select a single record from refTaskStatus
----------------------------------------------------------------------------
CREATE PROC [dbo].[usprefTaskStatusSelect]
(	@pkrefTaskStatus decimal(18, 0) = NULL,
	@Description varchar(50) = NULL,
	@TaskComplete bit = NULL
)
AS

SELECT	pkrefTaskStatus,
	Description,
	TaskComplete
FROM	refTaskStatus
WHERE 	(@pkrefTaskStatus IS NULL OR pkrefTaskStatus = @pkrefTaskStatus)
 AND 	(@Description IS NULL OR Description LIKE @Description + '%')
 AND 	(@TaskComplete IS NULL OR TaskComplete = @TaskComplete)