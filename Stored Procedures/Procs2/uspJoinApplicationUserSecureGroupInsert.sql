----------------------------------------------------------------------------
-- Insert a single record into JoinApplicationUserSecureGroup
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspJoinApplicationUserSecureGroupInsert]
(	  @fkApplicationUser decimal(18, 0) = NULL
	, @fkLockedEntity decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkJoinApplicationUserSecureGroup decimal(18, 0) = NULL OUTPUT 
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT JoinApplicationUserSecureGroup
(	  fkApplicationUser
	, fkLockedEntity
)
VALUES 
(	  @fkApplicationUser
	, @fkLockedEntity

)

SET @pkJoinApplicationUserSecureGroup = SCOPE_IDENTITY()
