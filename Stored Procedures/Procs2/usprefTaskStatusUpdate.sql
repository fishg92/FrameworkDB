----------------------------------------------------------------------------
-- Update a single record in refTaskStatus
----------------------------------------------------------------------------
CREATE PROC [dbo].[usprefTaskStatusUpdate]
(	  @pkrefTaskStatus decimal(18, 0)
	, @Description varchar(50) = NULL
	, @TaskComplete bit = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	refTaskStatus
SET	Description = ISNULL(@Description, Description),
	TaskComplete = ISNULL(@TaskComplete, TaskComplete)
WHERE 	pkrefTaskStatus = @pkrefTaskStatus
