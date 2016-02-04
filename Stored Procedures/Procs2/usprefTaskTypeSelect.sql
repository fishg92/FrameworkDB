----------------------------------------------------------------------------
-- Select a single record from refTaskType
----------------------------------------------------------------------------
CREATE PROC [dbo].[usprefTaskTypeSelect]
(	@pkrefTaskType decimal(18, 0) = NULL,
	@Description varchar(50) = NULL,
	@DefaultDueMinutes decimal(18, 0) = NULL,
	@DefaultGroupTask bit = NULL,
	@DefaultPriority tinyint = NULL,
	@Active bit = NULL,
	@LUPUser varchar(50) = NULL,
	@LUPDate datetime = NULL,
	@CreateUser varchar(50) = NULL,
	@CreateDate datetime = NULL,
	@fkrefTaskCategory decimal(18, 0) = NULL,
	@DMSTaskTypeID varchar(50) = NULL,
	@AllowDelete bit = NULL,
	@AllowDescriptionEdit bit = NULL,
	@DMSNewTaskWorkflow varchar(50) = NULL,
	@AutoComplete bit = NULL,
	@DMSWorkflowName varchar(50) = NULL,
	@FixedType decimal(18, 0) = NULL,
	@DueDateCalculationMethod varchar(10) = NULL,
	@DMSRequestedAction varchar(100) = NULL,
	@UseToastNotifications bit = NULL
)
AS

SELECT	pkrefTaskType,
	Description,
	DefaultDueMinutes,
	DefaultGroupTask,
	DefaultPriority,
	Active,
	LUPUser,
	LUPDate,
	CreateUser,
	CreateDate,
	fkrefTaskCategory,
	DMSTaskTypeID,
	AllowDelete,
	AllowDescriptionEdit,
	DMSNewTaskWorkflow,
	AutoComplete,
	DMSWorkflowName,
	FixedType,
	DueDateCalculationMethod,
	DMSRequestedAction,
	UseToastNotifications
FROM	refTaskType
WHERE 	(@pkrefTaskType IS NULL OR pkrefTaskType = @pkrefTaskType)
 AND 	(@Description IS NULL OR Description LIKE @Description + '%')
 AND 	(@DefaultDueMinutes IS NULL OR DefaultDueMinutes = @DefaultDueMinutes)
 AND 	(@DefaultGroupTask IS NULL OR DefaultGroupTask = @DefaultGroupTask)
 AND 	(@DefaultPriority IS NULL OR DefaultPriority = @DefaultPriority)
 AND 	(@Active IS NULL OR Active = @Active)
 AND 	(@LUPUser IS NULL OR LUPUser LIKE @LUPUser + '%')
 AND 	(@LUPDate IS NULL OR LUPDate = @LUPDate)
 AND 	(@CreateUser IS NULL OR CreateUser LIKE @CreateUser + '%')
 AND 	(@CreateDate IS NULL OR CreateDate = @CreateDate)
 AND 	(@fkrefTaskCategory IS NULL OR fkrefTaskCategory = @fkrefTaskCategory)
 AND 	(@DMSTaskTypeID IS NULL OR DMSTaskTypeID LIKE @DMSTaskTypeID + '%')
 AND 	(@AllowDelete IS NULL OR AllowDelete = @AllowDelete)
 AND 	(@AllowDescriptionEdit IS NULL OR AllowDescriptionEdit = @AllowDescriptionEdit)
 AND 	(@DMSNewTaskWorkflow IS NULL OR DMSNewTaskWorkflow LIKE @DMSNewTaskWorkflow + '%')
 AND 	(@AutoComplete IS NULL OR AutoComplete = @AutoComplete)
 AND 	(@DMSWorkflowName IS NULL OR DMSWorkflowName LIKE @DMSWorkflowName + '%')
 AND 	(@FixedType IS NULL OR FixedType = @FixedType)
 AND 	(@DueDateCalculationMethod IS NULL OR DueDateCalculationMethod LIKE @DueDateCalculationMethod + '%')
 AND 	(@DMSRequestedAction IS NULL OR DMSRequestedAction LIKE @DMSRequestedAction + '%')
 AND 	(@UseToastNotifications IS NULL OR UseToastNotifications = @UseToastNotifications)

