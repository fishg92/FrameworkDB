----------------------------------------------------------------------------
-- Insert a single record into Task
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspTaskInsert]
(	  @fkrefTaskType decimal(18, 0)
	, @Description varchar(100) = NULL
	, @DueDate datetime = NULL
	, @Note varchar(2000) = NULL
	, @fkrefTaskStatus decimal(18, 0)
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
	, @pkTask decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT Task
(	  fkrefTaskType
	, Description
	, DueDate
	, Note
	, fkrefTaskStatus
	, Priority
	, StartDate
	, CompleteDate
	, GroupTask
	, SourceModuleID
	, fkrefTaskOrigin
)
VALUES 
(	  @fkrefTaskType
	, COALESCE(@Description, '')
	, @DueDate
	, COALESCE(@Note, '')
	, @fkrefTaskStatus
	, COALESCE(@Priority, (2))
	, @StartDate
	, @CompleteDate
	, COALESCE(@GroupTask, (0))
	, @SourceModuleID
	, COALESCE(@fkrefTaskOrigin, (-1))

)

SET @pkTask = SCOPE_IDENTITY()
