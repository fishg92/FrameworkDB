----------------------------------------------------------------------------
-- Update a single record in TaskViewTaskTypeDeselected
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspTaskViewTaskTypeDeselectedUpdate]
(	  @pkTaskViewTaskTypeDeselected decimal(18, 0)
	, @fkTaskView decimal(18, 0) = NULL
	, @fkrefTaskType decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	TaskViewTaskTypeDeselected
SET	fkTaskView = ISNULL(@fkTaskView, fkTaskView),
	fkrefTaskType = ISNULL(@fkrefTaskType, fkrefTaskType)
WHERE 	pkTaskViewTaskTypeDeselected = @pkTaskViewTaskTypeDeselected
