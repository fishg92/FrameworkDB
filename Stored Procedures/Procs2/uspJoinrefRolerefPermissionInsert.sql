-- Stored Procedure

----------------------------------------------------------------------------
-- Insert a single record into JoinrefRolerefPermission
----------------------------------------------------------------------------
CREATE Proc [dbo].[uspJoinrefRolerefPermissionInsert]
(	  @fkrefRole decimal(18, 0)
	, @fkrefPermission decimal(18, 0)
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
	, @pkJoinrefRolerefPermission decimal(18, 0) = NULL OUTPUT 
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

INSERT JoinrefRolerefPermission
(	  fkrefRole
	, fkrefPermission
)
VALUES 
(	  @fkrefRole
	, @fkrefPermission

)

SET @pkJoinrefRolerefPermission = SCOPE_IDENTITY()
