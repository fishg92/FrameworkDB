----------------------------------------------------------------------------
-- Update a single record in Task
/* This is a variation on the standard auto-generated
stored procedure that is needed because we need to pass
null values */
----------------------------------------------------------------------------
CREATE PROC [dbo].[TaskUpdate]
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
	, @fkrefTaskOrigin decimal = null
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	Task
SET	fkrefTaskType = @fkrefTaskType,
	Description = @Description,
	DueDate = @DueDate,
	Note = @Note,
	fkrefTaskStatus = @fkrefTaskStatus,
	Priority = @Priority,
	StartDate = @StartDate,
	CompleteDate = @CompleteDate,
	GroupTask = @GroupTask,
	SourceModuleID = @SourceModuleID,
	fkrefTaskOrigin = isnull(@fkrefTaskOrigin,fkrefTaskOrigin)
	
WHERE 	pkTask = @pkTask
