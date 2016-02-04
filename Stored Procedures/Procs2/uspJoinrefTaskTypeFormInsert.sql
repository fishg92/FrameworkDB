----------------------------------------------------------------------------
-- Insert a single record into JoinrefTaskTypeForm
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspJoinrefTaskTypeFormInsert]
(	  @fkrefTaskType decimal(18, 0)
	, @fkFormName decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkJoinrefTaskTypeForm decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT JoinrefTaskTypeForm
(	  fkrefTaskType
	, fkFormName
)
VALUES 
(	  @fkrefTaskType
	, @fkFormName

)

SET @pkJoinrefTaskTypeForm = SCOPE_IDENTITY()
