----------------------------------------------------------------------------
-- Insert a single record into JoinrefTaskTypeApplicationUser
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspJoinrefTaskTypeApplicationUserInsert]
(	  @fkrefTaskType decimal(18, 0)
	, @fkApplicationUser decimal(18, 0)
	, @DisplayOrder int = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkJoinrefTaskTypeApplicationUser decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT JoinrefTaskTypeApplicationUser
(	  fkrefTaskType
	, fkApplicationUser
	, DisplayOrder
)
VALUES 
(	  @fkrefTaskType
	, @fkApplicationUser
	, COALESCE(@DisplayOrder, (0))

)

SET @pkJoinrefTaskTypeApplicationUser = SCOPE_IDENTITY()
