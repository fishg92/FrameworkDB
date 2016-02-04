----------------------------------------------------------------------------
-- Update a single record in refTaskTypeEscalation
----------------------------------------------------------------------------
CREATE PROC [dbo].[usprefTaskTypeEscalationUpdate]
(	  @pkrefTaskTypeEscalation decimal(18, 0)
	, @fkrefTaskType decimal(18, 0) = NULL
	, @Sequence int = NULL
	, @MinutesAfterDueDate int = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	refTaskTypeEscalation
SET	fkrefTaskType = ISNULL(@fkrefTaskType, fkrefTaskType),
	Sequence = ISNULL(@Sequence, Sequence),
	MinutesAfterDueDate = ISNULL(@MinutesAfterDueDate, MinutesAfterDueDate)
WHERE 	pkrefTaskTypeEscalation = @pkrefTaskTypeEscalation
