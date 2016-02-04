-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into JoinApplicationUserRefProfile
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinApplicationUserRefProfileInsert]
(	  @fkApplicationUser decimal(18, 0)
	, @fkProfile decimal(18, 0)
	, @AppId int
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
	, @pkJoinApplicationUserRefProfile decimal(18, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT JoinApplicationUserRefProfile
(	  fkApplicationUser
	, fkProfile
	, AppId
)
VALUES 
(	  @fkApplicationUser
	, @fkProfile
	, @AppId

)

SET @pkJoinApplicationUserRefProfile = SCOPE_IDENTITY()
