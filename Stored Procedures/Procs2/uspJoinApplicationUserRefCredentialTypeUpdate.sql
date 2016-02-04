----------------------------------------------------------------------------
-- Update a single record in JoinApplicationUserRefCredentialType
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinApplicationUserRefCredentialTypeUpdate]
(	  @pkJoinApplicationUserRefCredentialType decimal(18, 0)
	, @fkApplicationUser decimal(18, 0) = NULL
	, @fkRefCredentialType decimal(18, 0) = NULL
	, @UserName varchar(50) = NULL
	, @Password varchar(200) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	JoinApplicationUserRefCredentialType
SET	fkApplicationUser = ISNULL(@fkApplicationUser, fkApplicationUser),
	fkRefCredentialType = ISNULL(@fkRefCredentialType, fkRefCredentialType),
	UserName = ISNULL(@UserName, UserName),
	Password = ISNULL(@Password, Password)
WHERE 	pkJoinApplicationUserRefCredentialType = @pkJoinApplicationUserRefCredentialType
