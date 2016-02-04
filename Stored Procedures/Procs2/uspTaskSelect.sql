----------------------------------------------------------------------------
-- Select a single record from Task
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspTaskSelect]
(	@pkTask decimal(18, 0) = NULL,
	@fkrefTaskType decimal(18, 0) = NULL,
	@Description varchar(100) = NULL,
	@DueDate datetime = NULL,
	@Note varchar(2000) = NULL,
	@fkrefTaskStatus decimal(18, 0) = NULL,
	@Priority tinyint = NULL,
	@StartDate datetime = NULL,
	@CompleteDate datetime = NULL,
	@GroupTask bit = NULL,
	@SourceModuleID int = NULL,
	@fkrefTaskOrigin decimal(18, 0) = NULL
)
AS

SELECT	pkTask,
	fkrefTaskType,
	Description,
	DueDate,
	Note,
	fkrefTaskStatus,
	Priority,
	StartDate,
	CompleteDate,
	GroupTask,
	SourceModuleID,
	fkrefTaskOrigin
FROM	Task
WHERE 	(@pkTask IS NULL OR pkTask = @pkTask)
 AND 	(@fkrefTaskType IS NULL OR fkrefTaskType = @fkrefTaskType)
 AND 	(@Description IS NULL OR Description LIKE @Description + '%')
 AND 	(@DueDate IS NULL OR DueDate = @DueDate)
 AND 	(@Note IS NULL OR Note LIKE @Note + '%')
 AND 	(@fkrefTaskStatus IS NULL OR fkrefTaskStatus = @fkrefTaskStatus)
 AND 	(@Priority IS NULL OR Priority = @Priority)
 AND 	(@StartDate IS NULL OR StartDate = @StartDate)
 AND 	(@CompleteDate IS NULL OR CompleteDate = @CompleteDate)
 AND 	(@GroupTask IS NULL OR GroupTask = @GroupTask)
 AND 	(@SourceModuleID IS NULL OR SourceModuleID = @SourceModuleID)
 AND 	(@fkrefTaskOrigin IS NULL OR fkrefTaskOrigin = @fkrefTaskOrigin)

