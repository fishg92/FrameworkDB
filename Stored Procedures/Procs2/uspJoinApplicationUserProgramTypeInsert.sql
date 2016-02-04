----------------------------------------------------------------------------
-- Insert a single record into JoinApplicationUserProgramType
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspJoinApplicationUserProgramTypeInsert]
(	  @fkApplicationUser decimal(18, 0)
	, @fkProgramType decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkJoinApplicationUserProgramType decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT JoinApplicationUserProgramType
(	  fkApplicationUser
	, fkProgramType
)
VALUES 
(	  @fkApplicationUser
	, @fkProgramType

)

SET @pkJoinApplicationUserProgramType = SCOPE_IDENTITY()
