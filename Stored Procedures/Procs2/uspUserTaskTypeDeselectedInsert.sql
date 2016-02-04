----------------------------------------------------------------------------
-- Insert a single record into UserTaskTypeDeselected
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspUserTaskTypeDeselectedInsert]
(	  @fkApplicationUser decimal(18, 0)
	, @fkrefTaskType decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkUserTaskTypeDeselected decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT UserTaskTypeDeselected
(	  fkApplicationUser
	, fkrefTaskType
)
VALUES 
(	  @fkApplicationUser
	, @fkrefTaskType

)

SET @pkUserTaskTypeDeselected = SCOPE_IDENTITY()
