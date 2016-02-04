----------------------------------------------------------------------------
-- Update a single record in refTaskType
----------------------------------------------------------------------------
CREATE PROC [dbo].[usprefTaskTypeUpdate]
(	  @pkrefTaskType decimal(18, 0)
	, @Description varchar(50) = NULL
	, @DefaultDueMinutes decimal(18, 0) = NULL
	, @DefaultGroupTask bit = NULL
	, @DefaultPriority tinyint = NULL
	, @Active bit = NULL
	, @fkrefTaskCategory decimal(18, 0) = NULL
	, @DMSTaskTypeID varchar(50) = NULL
	, @AllowDelete bit = NULL
	, @AllowDescriptionEdit bit = NULL
	, @DMSNewTaskWorkflow varchar(50) = NULL
	, @AutoComplete bit = NULL
	, @DMSWorkflowName varchar(50) = NULL
	, @FixedType decimal(18, 0) = NULL
	, @DueDateCalculationMethod varchar(10) = NULL
	, @DMSRequestedAction varchar(100) = NULL
	, @UseToastNotifications bit = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	refTaskType
SET	Description = ISNULL(@Description, Description),
	DefaultDueMinutes = ISNULL(@DefaultDueMinutes, DefaultDueMinutes),
	DefaultGroupTask = ISNULL(@DefaultGroupTask, DefaultGroupTask),
	DefaultPriority = ISNULL(@DefaultPriority, DefaultPriority),
	Active = ISNULL(@Active, Active),
	fkrefTaskCategory = ISNULL(@fkrefTaskCategory, fkrefTaskCategory),
	DMSTaskTypeID = ISNULL(@DMSTaskTypeID, DMSTaskTypeID),
	AllowDelete = ISNULL(@AllowDelete, AllowDelete),
	AllowDescriptionEdit = ISNULL(@AllowDescriptionEdit, AllowDescriptionEdit),
	DMSNewTaskWorkflow = ISNULL(@DMSNewTaskWorkflow, DMSNewTaskWorkflow),
	AutoComplete = ISNULL(@AutoComplete, AutoComplete),
	DMSWorkflowName = ISNULL(@DMSWorkflowName, DMSWorkflowName),
	FixedType = ISNULL(@FixedType, FixedType),
	DueDateCalculationMethod = ISNULL(@DueDateCalculationMethod, DueDateCalculationMethod),
	DMSRequestedAction = ISNULL(@DMSRequestedAction, DMSRequestedAction),
	UseToastNotifications = ISNULL(@UseToastNotifications, UseToastNotifications)
WHERE 	pkrefTaskType = @pkrefTaskType
