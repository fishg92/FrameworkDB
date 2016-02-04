----------------------------------------------------------------------------
-- Insert a single record into JoinApplicationUserrefTaskTypeEscalation
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspJoinApplicationUserrefTaskTypeEscalationInsert]
(	  @fkrefTaskTypeEscalation decimal(18, 0)
	, @fkApplicationUser decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkJoinApplicationUserrefTaskTypeEscalation decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT JoinApplicationUserrefTaskTypeEscalation
(	  fkrefTaskTypeEscalation
	, fkApplicationUser
)
VALUES 
(	  @fkrefTaskTypeEscalation
	, @fkApplicationUser

)

SET @pkJoinApplicationUserrefTaskTypeEscalation = SCOPE_IDENTITY()
