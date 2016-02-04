----------------------------------------------------------------------------
-- Insert a single record into JoinrefTaskTyperefTaskEntityType
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspJoinrefTaskTyperefTaskEntityTypeInsert]
(	  @fkrefTaskType decimal(18, 0)
	, @fkrefTaskEntityType decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkJoinrefTaskTyperefTaskEntityType decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT JoinrefTaskTyperefTaskEntityType
(	  fkrefTaskType
	, fkrefTaskEntityType
)
VALUES 
(	  @fkrefTaskType
	, @fkrefTaskEntityType

)

SET @pkJoinrefTaskTyperefTaskEntityType = SCOPE_IDENTITY()
