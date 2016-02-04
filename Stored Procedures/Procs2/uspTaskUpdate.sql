----------------------------------------------------------------------------
-- Update a single record in Task
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspTaskUpdate]
(	  @pkTask decimal(18, 0)
	, @fkrefTaskType decimal(18, 0) = NULL
	, @Description varchar(100) = NULL
	, @DueDate datetime = NULL
	, @Note varchar(2000) = NULL
	, @fkrefTaskStatus decimal(18, 0) = NULL
	, @Priority tinyint = NULL
	, @StartDate datetime = NULL
	, @CompleteDate datetime = NULL
	, @GroupTask bit = NULL
	, @SourceModuleID int = NULL
	, @fkrefTaskOrigin decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	Task
SET	fkrefTaskType = ISNULL(@fkrefTaskType, fkrefTaskType),
	Description = ISNULL(@Description, Description),
	DueDate = ISNULL(@DueDate, DueDate),
	Note = ISNULL(@Note, Note),
	fkrefTaskStatus = ISNULL(@fkrefTaskStatus, fkrefTaskStatus),
	Priority = ISNULL(@Priority, Priority),
	StartDate = ISNULL(@StartDate, StartDate),
	CompleteDate = ISNULL(@CompleteDate, CompleteDate),
	GroupTask = ISNULL(@GroupTask, GroupTask),
	SourceModuleID = ISNULL(@SourceModuleID, SourceModuleID),
	fkrefTaskOrigin = ISNULL(@fkrefTaskOrigin, fkrefTaskOrigin)
WHERE 	pkTask = @pkTask
