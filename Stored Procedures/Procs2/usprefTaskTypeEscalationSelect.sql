----------------------------------------------------------------------------
-- Select a single record from refTaskTypeEscalation
----------------------------------------------------------------------------
CREATE PROC [dbo].[usprefTaskTypeEscalationSelect]
(	@pkrefTaskTypeEscalation decimal(18, 0) = NULL,
	@fkrefTaskType decimal(18, 0) = NULL,
	@Sequence int = NULL,
	@MinutesAfterDueDate int = NULL
)
AS

SELECT	pkrefTaskTypeEscalation,
	fkrefTaskType,
	Sequence,
	MinutesAfterDueDate
FROM	refTaskTypeEscalation
WHERE 	(@pkrefTaskTypeEscalation IS NULL OR pkrefTaskTypeEscalation = @pkrefTaskTypeEscalation)
 AND 	(@fkrefTaskType IS NULL OR fkrefTaskType = @fkrefTaskType)
 AND 	(@Sequence IS NULL OR Sequence = @Sequence)
 AND 	(@MinutesAfterDueDate IS NULL OR MinutesAfterDueDate = @MinutesAfterDueDate)
