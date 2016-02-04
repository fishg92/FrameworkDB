----------------------------------------------------------------------------
-- Insert a single record into TaskViewTaskTypeDeselected
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspTaskViewTaskTypeDeselectedInsert]
(	  @fkTaskView decimal(18, 0)
	, @fkrefTaskType decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkTaskViewTaskTypeDeselected decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT TaskViewTaskTypeDeselected
(	  fkTaskView
	, fkrefTaskType
)
VALUES 
(	  @fkTaskView
	, @fkrefTaskType

)

SET @pkTaskViewTaskTypeDeselected = SCOPE_IDENTITY()
