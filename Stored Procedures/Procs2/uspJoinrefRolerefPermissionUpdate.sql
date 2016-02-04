-- Stored Procedure

----------------------------------------------------------------------------
-- Update a single record in JoinrefRolerefPermission
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspJoinrefRolerefPermissionUpdate]
(	  @pkJoinrefRolerefPermission decimal(18, 0)
	, @fkrefRole decimal(18, 0) = NULL
	, @fkrefPermission decimal(18, 0) = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
    , @LUPMachine varchar(15)
)
AS

exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	JoinrefRolerefPermission
SET	fkrefRole = ISNULL(@fkrefRole, fkrefRole),
	fkrefPermission = ISNULL(@fkrefPermission, fkrefPermission)
WHERE 	pkJoinrefRolerefPermission = @pkJoinrefRolerefPermission
