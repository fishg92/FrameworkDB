-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into JoinApplicationUserrefRole
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspJoinApplicationUserrefRoleInsert]
(	  @fkApplicationUser decimal(18, 0)
	, @fkrefRole decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkJoinApplicationUserrefRole decimal(18, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT JoinApplicationUserrefRole
(	  fkApplicationUser
	, fkrefRole
)
VALUES 
(	  @fkApplicationUser
	, @fkrefRole

)

SET @pkJoinApplicationUserrefRole = SCOPE_IDENTITY()
