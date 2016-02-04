----------------------------------------------------------------------------
-- Update a single record in JoinrefTaskTypeForm
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinrefTaskTypeFormUpdate]
(	  @pkJoinrefTaskTypeForm decimal(18, 0)
	, @fkrefTaskType decimal(18, 0) = NULL
	, @fkFormName decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	JoinrefTaskTypeForm
SET	fkrefTaskType = ISNULL(@fkrefTaskType, fkrefTaskType),
	fkFormName = ISNULL(@fkFormName, fkFormName)
WHERE 	pkJoinrefTaskTypeForm = @pkJoinrefTaskTypeForm
