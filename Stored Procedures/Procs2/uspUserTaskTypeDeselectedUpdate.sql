----------------------------------------------------------------------------
-- Update a single record in UserTaskTypeDeselected
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspUserTaskTypeDeselectedUpdate]
(	  @pkUserTaskTypeDeselected decimal(18, 0)
	, @fkApplicationUser decimal(18, 0) = NULL
	, @fkrefTaskType decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	UserTaskTypeDeselected
SET	fkApplicationUser = ISNULL(@fkApplicationUser, fkApplicationUser),
	fkrefTaskType = ISNULL(@fkrefTaskType, fkrefTaskType)
WHERE 	pkUserTaskTypeDeselected = @pkUserTaskTypeDeselected
