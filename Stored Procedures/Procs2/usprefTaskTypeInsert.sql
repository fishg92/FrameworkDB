----------------------------------------------------------------------------
-- Insert a single record into refTaskType
----------------------------------------------------------------------------
CREATE Proc [dbo].[usprefTaskTypeInsert]
(	  @Description varchar(50)
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
	, @pkrefTaskType decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT refTaskType
(	  Description
	, DefaultDueMinutes
	, DefaultGroupTask
	, DefaultPriority
	, Active
	, fkrefTaskCategory
	, DMSTaskTypeID
	, AllowDelete
	, AllowDescriptionEdit
	, DMSNewTaskWorkflow
	, AutoComplete
	, DMSWorkflowName
	, FixedType
	, DueDateCalculationMethod
	, DMSRequestedAction
	, UseToastNotifications
)
VALUES 
(	  @Description
	, COALESCE(@DefaultDueMinutes, (-1))
	, COALESCE(@DefaultGroupTask, (1))
	, COALESCE(@DefaultPriority, (2))
	, COALESCE(@Active, (1))
	, COALESCE(@fkrefTaskCategory, (-1))
	, COALESCE(@DMSTaskTypeID, '')
	, COALESCE(@AllowDelete, (1))
	, COALESCE(@AllowDescriptionEdit, (1))
	, COALESCE(@DMSNewTaskWorkflow, '')
	, COALESCE(@AutoComplete, (0))
	, COALESCE(@DMSWorkflowName, '')
	, COALESCE(@FixedType, (0))
	, COALESCE(@DueDateCalculationMethod, 'Calendar')
	, COALESCE(@DMSRequestedAction, '')
	, COALESCE(@UseToastNotifications, (0))

)

SET @pkrefTaskType = SCOPE_IDENTITY()
