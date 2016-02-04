----------------------------------------------------------------------------
-- Insert a single record into JoinApplicationUserRefCredentialType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinApplicationUserRefCredentialTypeInsert]
(	  @fkApplicationUser decimal(18, 0)
	, @fkRefCredentialType decimal(18, 0)
	, @UserName varchar(50) = NULL
	, @Password varchar(200) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkJoinApplicationUserRefCredentialType decimal(18, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT JoinApplicationUserRefCredentialType
(	  fkApplicationUser
	, fkRefCredentialType
	, UserName
	, Password
)
VALUES 
(	  @fkApplicationUser
	, @fkRefCredentialType
	, @UserName
	, @Password

)

SET @pkJoinApplicationUserRefCredentialType = SCOPE_IDENTITY()
